import 'dart:developer';

import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/utils/notification/notification.dart';
import 'package:matlop_provider/feature/bottomNavBarScreen/bottom_nav_bar_view.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/constants_enum.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/auth/login/presentation/login_view.dart';
import 'package:matlop_provider/feature/auth/login/presentation/manager/cubit/login_cubit.dart';
import 'package:matlop_provider/feature/auth/signUp/data/data_source.dart';
import 'package:matlop_provider/feature/auth/signUp/data/technical_special_list_model.dart';

import '../../data/model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final TechType technicalTypeEnum;

  RegisterCubit(this.technicalTypeEnum) : super(RegisterInitial());

  static RegisterCubit of(BuildContext context) => BlocProvider.of(context);
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nationalNo = TextEditingController();
  TextEditingController countryName = TextEditingController();
  int countryId = -1;
  final RegisterDataSource registerDataSource = RegisterDataSourceImpl();
  GenderEnum selectedGender = GenderEnum.male;

  void register({required BuildContext context}) {
    emit(RegisterLoading());

    registerDataSource
        .register(
      params: SingUpParameters(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        username: userNameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: phoneController.text,
        countryId: countryId,
        technicalTypeEnum: technicalTypeEnum == TechType.technical ? 3 : 9,
        technicalServiceIds: selectedTechnicals.map((e) => e.serviceId ?? 0).toList(),
        genderId: selectedGender.id,
      ),
    )
        .then(
      (value) async {
        value.fold(
          (l) {
            Utils.showToast(title: l.errMessage, state: UtilState.error);
            emit(RegisterError(e: l.errMessage));
          },
          (r) async {
            log('Success Registration');
            userCacheValue = r;
            Constants.token = r.data?.accessToken ?? '';
            selectTokens();
            context.navigateToPage(
              const BottomNavBarView(),
            );
            await userCache?.put(userCacheKey, jsonEncode(r.toJson()));
            await userCache?.put(rememberMeKey, rememberMe);
            emit(RegisterSuccess());
          },
        );
      },
    );
  }

  void getAllTechnicalSpecial({required BuildContext context}) {
    emit(GetAllTechnicalSpecialListLoading());
    registerDataSource.getAllTechnicalSpecialList().then(
      (value) async {
        value.fold(
          (l) {
            //  Utils.showToast(title: l.errMessage, state: UtilState.error);
            emit(GetAllTechnicalSpecialListError(e: l.errMessage));
          },
          (r) async {
            ConstantModel.technicalSpecialListModel = r;
            emit(GetAllTechnicalSpecialListSuccess());
          },
        );
      },
    );
  }

  List<ItemTechnicalSpecialListModel> selectedTechnicals = [];
  TextEditingController nameController = TextEditingController();

  toggleTechnicalSpecial({required ItemTechnicalSpecialListModel technical, required BuildContext context}) {
    if (selectedTechnicals.any((e) => e.serviceId == technical.serviceId)) {
      selectedTechnicals.removeWhere((e) => e.serviceId == technical.serviceId);
    } else {
      selectedTechnicals.add(technical);
    }
    bool isAr = context.locale.languageCode == 'ar';
    nameController.text = selectedTechnicals.map((e) => isAr ? (e.arName ?? "") : (e.enName ?? "")).join(', ');
    emit(AddTechnicalState());
  }
}

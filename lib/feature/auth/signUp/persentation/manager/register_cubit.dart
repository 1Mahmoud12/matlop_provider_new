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
import 'package:matlop_provider/feature/auth/signUp/data/worker_type_model.dart';

import '../../data/model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final TechType technicalTypeEnum;

  RegisterCubit(this.technicalTypeEnum) : super(RegisterInitial());

  static RegisterCubit of(BuildContext context) => BlocProvider.of(context);

  final TextEditingController fullNameController = TextEditingController();
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

  // Worker type
  List<WorkerTypeItem> workerTypes = [];
  WorkerTypeItem? selectedWorkerType;

  void getWorkerTypes() {
    emit(GetWorkerTypesLoading());
    registerDataSource.getAllWorkerTypes().then((value) {
      value.fold(
        (l) => emit(GetWorkerTypesError(e: l.errMessage)),
        (r) {
          workerTypes = r.data?.where((e) => e.isActive == true).toList() ?? [];
          if (workerTypes.isNotEmpty) selectedWorkerType = workerTypes.first;
          emit(GetWorkerTypesSuccess());
        },
      );
    });
  }

  void register({required BuildContext context}) {
    emit(RegisterLoading());

    registerDataSource
        .register(
      params: SingUpParameters(
        fullName: fullNameController.text,
        username: userNameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: phoneController.text,
        // countryId: countryId,
        technicalTypeEnum: technicalTypeEnum == TechType.technical ? 3 : 9,
        technicalSpecialistId: selectedTechnicalSpecialist?.technicalSpecialistId,
        technicalServiceIds: selectedServices.map((e) => e.technicalSpecialistId ?? 0).toList(),
        genderId: selectedGender.id,
        workerTypeId: selectedWorkerType?.id,
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
            String successMessage = 'Register success, you can log in now'.tr();
            if (r.error != null && r.error!.isNotEmpty) {
              successMessage = r.error!;
            } else if (r.message != null && r.message!.isNotEmpty) {
              successMessage = r.message!;
            }

            Utils.showToast(
              title: successMessage,
              state: UtilState.success,
            );
            if (context.mounted) {
              context.navigateToPage(
                BlocProvider(
                  create: (context) => LoginCubit(),
                  child: const LoginView(),
                ),
              );
            }
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
          (l) => emit(GetAllTechnicalSpecialListError(e: l.errMessage)),
          (r) async {
            ConstantModel.technicalSpecialListModel = r;
            emit(GetAllTechnicalSpecialListSuccess());
          },
        );
      },
    );
  }

  void getAllServices({required BuildContext context}) {
    emit(GetAllTechnicalSpecialListLoading());
    registerDataSource.getAllServices().then(
      (value) async {
        value.fold(
          (l) => emit(GetAllTechnicalSpecialListError(e: l.errMessage)),
          (r) async {
            ConstantModel.servicesListModel = r;
            emit(GetAllTechnicalSpecialListSuccess());
          },
        );
      },
    );
  }

  // --- Single Selection for Technical Specialist ---
  ItemTechnicalSpecialListModel? selectedTechnicalSpecialist;
  TextEditingController technicalSpecialistController = TextEditingController();

  void selectTechnicalSpecialist({required ItemTechnicalSpecialListModel technical, required BuildContext context}) {
    selectedTechnicalSpecialist = technical;
    bool isAr = context.locale.languageCode == 'ar';
    technicalSpecialistController.text = isAr ? (technical.arName ?? "") : (technical.enName ?? "");
    emit(AddTechnicalState());
  }

  void clearTechnicalSpecialist() {
    selectedTechnicalSpecialist = null;
    technicalSpecialistController.clear();
    emit(AddTechnicalState());
  }

  // --- Multiple Selection for Services ---
  List<ItemTechnicalSpecialListModel> selectedServices = [];
  TextEditingController servicesController = TextEditingController();

  void toggleService({required ItemTechnicalSpecialListModel service, required BuildContext context}) {
    if (selectedServices.any((e) => e.technicalSpecialistId == service.technicalSpecialistId)) {
      selectedServices.removeWhere((e) => e.technicalSpecialistId == service.technicalSpecialistId);
    } else {
      selectedServices.add(service);
    }
    bool isAr = context.locale.languageCode == 'ar';
    servicesController.text = selectedServices.map((e) => isAr ? (e.arName ?? "") : (e.enName ?? "")).join(', ');
    emit(AddTechnicalState());
  }

  void clearServices() {
    selectedServices.clear();
    servicesController.clear();
    emit(AddTechnicalState());
  }
}

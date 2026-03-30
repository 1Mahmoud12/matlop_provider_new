import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/utils/app_images.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/bottomNavBarScreen/bottom_nav_bar_view.dart';
import 'package:matlop_provider/feature/menu/views/editProfile/data/dataSource/update_profile_data_source.dart';
import 'package:matlop_provider/feature/menu/views/editProfile/data/models/update_profile_params.dart';

part 'profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());

  static UpdateProfileCubit of(BuildContext context) => BlocProvider.of(context);
  TextEditingController firstNameController = TextEditingController(text: profileCacheValue?.data?.firstName);
  TextEditingController lastNameController = TextEditingController(text: profileCacheValue?.data?.lastName);
  TextEditingController usernameController = TextEditingController(text: profileCacheValue?.data?.username);
  TextEditingController mobileNumberController = TextEditingController(text: profileCacheValue?.data?.mobileNumber);
  TextEditingController dateOfBirthController = TextEditingController(text: profileCacheValue?.data?.dateOfBirth);
  TextEditingController emailController = TextEditingController(text: profileCacheValue?.data?.email);

  int gender = profileCacheValue?.data?.gender ?? 1;
  final UpdateProfileDataSourceInterface loginDataSource = UpdateProfileDataSource();
  File? imageFile;
  String urlImage = '';

  Future<void> getProfile({required BuildContext context, bool reset = true}) async {
    emit(UpdateProfileLoading());
    if (reset) animationDialogLoading(context);
    loginDataSource.getProfile(userId: userCacheValue?.data?.userId ?? -1).then(
      (value) async {
        if (reset && context.mounted) closeDialog(context);
        value.fold(
          (l) {
            Utils.showToast(title: l.errMessage, state: UtilState.error);
            emit(UpdateProfileError(e: l.errMessage));
          },
          (r) async {
            ConstantModel.profileModel = r;
            profileCacheValue = r;
            await userCache?.put(profileCacheKey, jsonEncode(r.toJson()));
            urlImage = r.data?.imgSrc ?? '';
            // Instead of creating new TextEditingControllers, update the text of existing ones
            firstNameController.text = profileCacheValue?.data?.firstName ?? '';
            lastNameController.text = profileCacheValue?.data?.lastName ?? '';
            usernameController.text = profileCacheValue?.data?.username ?? '';
            if (profileCacheValue?.data?.dateOfBirth != null) {
              final customDate = DateTime.parse(profileCacheValue!.data!.dateOfBirth!);
              final formattedDate = DateFormat('yyyy-MM-dd', 'en').format(customDate);
              dateOfBirthController.text = formattedDate;
            }
            gender = profileCacheValue?.data?.gender ?? 0;
            emailController.text = profileCacheValue?.data?.email ?? '';
            mobileNumberController.text = profileCacheValue?.data?.mobileNumber ?? '';
            // userCacheValue?.data?.profile?.fullName = profileCacheValue?.data?.firstName;
            // userCacheValue?.data?.profile.imgSrc = r.data?.imgSrc ?? '';
            if (!reset) {
              userCache?.put(userCacheKey, jsonEncode(userCacheValue?.toJson()));
              if (context.mounted) {
                context.navigateToPage(
                  const BottomNavBarView(
                    selectedIndex: 3,
                  ),
                );
              }
            }
            emit(UpdateProfileSuccess());
          },
        );
      },
    );
  }

  void updateProfile({required BuildContext context}) {
    emit(UpdateProfileLoading());
    animationDialogLoading(context);
    if (gender == Gender.female.index) AppImages.avatar = AppImages.avatarFemale;
    if (gender == Gender.male.index) AppImages.avatar = AppImages.avatarMale;
    loginDataSource
        .updateProfile(
      params: UpdateProfileParams(
        userId: userCacheValue!.data!.userId!,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        username: usernameController.text,
        mobileNumber: mobileNumberController.text,
        dateOfBirth: dateOfBirthController.text,
        imgSrc: imageFile,
        gender: gender,
        email: emailController.text,
        technicalSpecialistId: (profileCacheValue?.data?.technicalSpecialistId ?? 0).toInt(),
      ),
    )
        .then(
      (value) async {
        await getProfile(context: context, reset: false);
        closeDialog(context);
        value.fold(
          (l) {
            //   Utils.showToast(title: l.errMessage, state: UtilState.error);
            emit(UpdateProfileError(e: l.errMessage));
          },
          (r) async {
            Utils.showToast(title: r.message ?? Constants.unKnownValue, state: UtilState.success);

            profileCacheValue = r;

            profileCacheValue?.data?.email = emailController.text;
            profileCacheValue?.data?.firstName = firstNameController.text;
            profileCacheValue?.data?.lastName = lastNameController.text;
            profileCacheValue?.data?.username = usernameController.text;
            profileCacheValue?.data?.gender = gender;
            profileCacheValue?.data?.dateOfBirth = dateOfBirthController.text;
           // userCacheValue?.data?.name = firstNameController.text;

            userCache?.put(profileCacheKey, jsonEncode(profileCacheValue?.toJson()));

            emit(UpdateProfileSuccess());
          },
        );
      },
    );
  }
}

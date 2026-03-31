import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

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

import '../../../../../core/network/end_points.dart';
import '../../../../auth/login/data/models/login_model.dart';

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
            urlImage = r.data?.imgSrc?.trim() ?? '';
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
            }
            emit(UpdateProfileSuccess());
          },
        );
      },
    );
  }

  bool hasChanges() {
    if (imageFile != null) return true;
    if (firstNameController.text != (profileCacheValue?.data?.firstName ?? '')) return true;
    if (lastNameController.text != (profileCacheValue?.data?.lastName ?? '')) return true;
    if (emailController.text != (profileCacheValue?.data?.email ?? '')) return true;
    if (usernameController.text != (profileCacheValue?.data?.username ?? '')) return true;
    if (mobileNumberController.text != (profileCacheValue?.data?.mobileNumber ?? '')) return true;
    if (gender != (profileCacheValue?.data?.gender ?? 1)) return true;
    return false;
  }

  void updateProfile({required BuildContext context}) {
    emit(UpdateProfileLoading());
    animationDialogLoading(context);
    if (gender == Gender.female.index) AppImages.avatar = AppImages.avatarFemale;
    if (gender == Gender.male.index) AppImages.avatar = AppImages.avatarMale;
    loginDataSource
        .updateProfile(
      params: UpdateProfileParams(
        firstName: firstNameController.text,
        // Last name has no input field in the UI — fall back to cached value
        // to avoid sending an empty string that the API rejects.
        lastName: lastNameController.text.isNotEmpty ? lastNameController.text : profileCacheValue?.data?.lastName ?? '',
        mobileNumber: mobileNumberController.text,
        email: emailController.text,
        genderId: gender,
        imgSrc: imageFile,
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
            Utils.showToast(title: 'Profile updated successfully'.tr(), state: UtilState.success);

            profileCacheValue = r;

            profileCacheValue?.data?.email = emailController.text;
            profileCacheValue?.data?.firstName = firstNameController.text;
            profileCacheValue?.data?.lastName = lastNameController.text;
            profileCacheValue?.data?.username = usernameController.text;
            profileCacheValue?.data?.gender = gender;
            profileCacheValue?.data?.dateOfBirth = dateOfBirthController.text;
            // Sync changes to the global userCacheValue so Home headers and other screens pick them up immediately
            // Convert to JSON map because LoginModel fields are immutable final properties
            if (userCacheValue != null) {
              // Evict old image from CachedNetworkImage cache so new image loads fresh
              final oldImgSrc = userCacheValue?.data?.imgSrc ?? '';
              if (oldImgSrc.isNotEmpty && oldImgSrc != Constants.unKnownValue) {
                CachedNetworkImage.evictFromCache(oldImgSrc);
              }

              final userMap = userCacheValue!.toJson();
              if (userMap['data'] != null && userMap['data']['profile'] != null) {
                userMap['data']['profile']['firstName'] = firstNameController.text;
                userMap['data']['profile']['fullName'] = '${firstNameController.text} ${lastNameController.text}';
                // Store relative path since LoginResponseData.imgSrc getter prepends the domain
                final fullImg = profileCacheValue?.data?.imgSrc ?? '';
                final relativeImg = fullImg.startsWith(EndPoints.domain)
                    ? fullImg.substring(EndPoints.domain.length)
                    : fullImg;
                userMap['data']['profile']['imgSrc'] = relativeImg;
              }
              userCacheValue = LoginModel.fromJson(userMap);
              userCache?.put(userCacheKey, jsonEncode(userCacheValue?.toJson()));
            }

            userCache?.put(profileCacheKey, jsonEncode(profileCacheValue?.toJson()));

            emit(UpdateProfileSuccess());
          },
        );
      },
    );
  }
}

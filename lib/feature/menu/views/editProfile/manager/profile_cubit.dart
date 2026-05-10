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
import 'package:matlop_provider/feature/auth/signUp/data/data_source.dart';
import 'package:matlop_provider/feature/auth/signUp/data/worker_type_model.dart';

import '../../../../../core/network/end_points.dart';
import '../../../../auth/login/data/models/login_model.dart';

part 'profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());

  static UpdateProfileCubit of(BuildContext context) => BlocProvider.of(context);
  TextEditingController fullNameController = TextEditingController(text: profileCacheValue?.data?.fullName ?? '');
  TextEditingController usernameController = TextEditingController(text: profileCacheValue?.data?.username);
  TextEditingController mobileNumberController = TextEditingController(text: profileCacheValue?.data?.mobileNumber);
  TextEditingController dateOfBirthController = TextEditingController(text: profileCacheValue?.data?.dateOfBirth);
  TextEditingController emailController = TextEditingController(text: profileCacheValue?.data?.email);

  int gender = profileCacheValue?.data?.gender ?? 1;
  final UpdateProfileDataSourceInterface loginDataSource = UpdateProfileDataSource();
  final RegisterDataSource _registerDataSource = RegisterDataSourceImpl();
  File? imageFile;
  String urlImage = '';

  // Worker type
  List<WorkerTypeItem> workerTypes = [];
  WorkerTypeItem? selectedWorkerType;

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
            // Update controllers with fresh profile data
            fullNameController.text = profileCacheValue?.data?.fullName ?? '';
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

  void getWorkerTypes() {
    emit(GetWorkerTypesLoading());
    _registerDataSource.getAllWorkerTypes().then((value) {
      value.fold(
        (l) => emit(GetWorkerTypesError(e: l.errMessage)),
        (r) {
          workerTypes = r.data?.where((e) => e.isActive == true).toList() ?? [];
          // Pre-select the worker type matching the cached profile
          final cachedId = profileCacheValue?.data?.workerTypeId;
          if (cachedId != null && workerTypes.isNotEmpty) {
            selectedWorkerType = workerTypes.firstWhere(
              (e) => e.id == cachedId,
              orElse: () => workerTypes.first,
            );
          } else if (workerTypes.isNotEmpty) {
            selectedWorkerType = workerTypes.first;
          }
          emit(GetWorkerTypesSuccess());
        },
      );
    });
  }

  bool hasChanges() {
    if (imageFile != null) return true;
    if (fullNameController.text != (profileCacheValue?.data?.fullName ?? '')) return true;
    if (emailController.text != (profileCacheValue?.data?.email ?? '')) return true;
    if (usernameController.text != (profileCacheValue?.data?.username ?? '')) return true;
    if (mobileNumberController.text != (profileCacheValue?.data?.mobileNumber ?? '')) return true;
    if (gender != (profileCacheValue?.data?.gender ?? 1)) return true;
    if (selectedWorkerType?.id != profileCacheValue?.data?.workerTypeId) return true;
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
        fullName: fullNameController.text,
        mobileNumber: mobileNumberController.text,
        email: emailController.text,
        genderId: gender,
        workerTypeId: selectedWorkerType?.id ?? profileCacheValue?.data?.workerTypeId ?? 0,
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
            profileCacheValue?.data?.fullName = fullNameController.text;
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
                userMap['data']['profile']['fullName'] = fullNameController.text;
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

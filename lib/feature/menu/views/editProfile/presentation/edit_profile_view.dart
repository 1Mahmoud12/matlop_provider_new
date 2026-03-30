import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matlop_provider/core/component/buttons/arrow_back_button.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/component/custom_drop_down_model_button.dart';
import 'package:matlop_provider/core/component/custom_text_form_field.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/utils/custom_calendar.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/menu/views/editProfile/data/models/country_model.dart';
import 'package:matlop_provider/feature/menu/views/editProfile/manager/profile_cubit.dart';
import 'package:matlop_provider/feature/menu/views/editProfile/presentation/widgets/edit_profile_image.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late UpdateProfileCubit cubit;
  final formKey = GlobalKey<FormState>();

  // List of country codes and flags

  // The selected country
  Country? selectedCountry;

  @override
  void initState() {
    super.initState();
    selectedCountry = Constants.countries[4]; // Default to the first country in the list

    cubit = UpdateProfileCubit();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        cubit.getProfile(context: context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 45,
        leading: const ArrowBackButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                EditProfileImage(
                  updateProfileCubit: cubit,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  userCacheValue?.data?.name ?? '',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Utils.copyToClipboard(userCacheValue?.data?.mobileNumber ?? '');
                      },
                      child: SvgPicture.asset(
                        AppIcons.copyIcon,
                        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      userCacheValue?.data?.mobileNumber ?? '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.withOpacity(0.6)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 0.5,
                  color: AppColors.primaryColor.withOpacity(0.2),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        labelStringText: 'Name'.tr(),
                        controller: cubit.firstNameController,
                        hintText: 'Please enter your name'.tr(),
                        outPadding: EdgeInsets.zero,
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // CustomTextFormField(
                      //   labelStringText: 'last name'.tr(),
                      //   controller: cubit.lastNameController,
                      //   hintText: 'Please enter your last name'.tr(),
                      //   outPadding: EdgeInsets.zero,
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        labelStringText: 'email'.tr(),
                        controller: cubit.emailController,
                        hintText: 'Please enter your email'.tr(),
                        outPadding: EdgeInsets.zero,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        labelStringText: 'user name'.tr(),
                        controller: cubit.usernameController,
                        hintText: 'Please enter user name'.tr(),
                        outPadding: EdgeInsets.zero,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),

                CustomDropdownWithModel(
                  text: (cubit.gender == 1
                          ? 'male'
                          : cubit.gender == 2
                              ? 'female'
                              : 'Select Gender') ??
                      'Select Gender',
                  itemList: const [DropDownModel('male', 1), DropDownModel('female', 2)],
                  textStyle: Theme.of(context).textTheme.bodyMedium!,
                  onItemSelected: (p0) {
                    cubit.gender = p0.value;
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                // InkWell(
                //   onTap: () {
                //     showDialog(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return Center(
                //           child: Material(
                //             color: AppColors.transparent,
                //             child: CustomCalendarWidget(
                //               initialDate: DateTime.parse(
                //                 cubit.dateOfBirthController.text,
                //               ),
                //               onDateSelected: (date) {
                //                 setState(() {
                //                   cubit.dateOfBirthController.text = DateFormat('yyyy-MM-dd', 'en').format(date);
                //                 });
                //               },
                //             ),
                //           ),
                //         );
                //       },
                //     );
                //   },
                //   child: BlocProvider.value(
                //     value: cubit,
                //     child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                //       buildWhen: (previous, current) => current is UpdateProfileSuccess,
                //       builder: (context, state) => CustomTextFormField(
                //         labelStringText: 'Select Date'.tr(),
                //         controller: cubit.dateOfBirthController,
                //         hintText: 'Select Date'.tr(),
                //         outPadding: EdgeInsets.zero,
                //         enable: false,
                //       ),
                //     ),
                //   ),
                // ),

                const SizedBox(
                  height: 20,
                ),
                // InkWell(
                //   onTap: () {
                //     showDialog(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return Center(
                //           child: Material(
                //             color: AppColors.transparent,
                //             child: CustomCalendarWidget(
                //               initialDate: DateTime.parse(cubit.dateOfBirthController.text),
                //               onDateSelected: (date) {
                //                 setState(() {
                //                   cubit.dateOfBirthController.text = DateFormat('yyyy-MM-dd', 'en').format(date);
                //                 });
                //               },
                //             ),
                //           ),
                //         );
                //       },
                //     );
                //   },
                //   child: BlocProvider.value(
                //     value: cubit,
                //     child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                //       buildWhen: (previous, current) => current is UpdateProfileSuccess,
                //       builder: (context, state) => CustomTextFormField(
                //         labelStringText: 'Select Date'.tr(),
                //         controller: cubit.dateOfBirthController,
                //         hintText: 'Select Date'.tr(),
                //         outPadding: EdgeInsets.zero,
                //         enable: false,
                //       ),
                //     ),
                //   ),
                // ),

                // const SizedBox(
                //   height: 40,
                // ),
                CustomTextButton(
                  borderRadius: 20,
                  child: Text(
                    'Save'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                  onPress: () {
                    // Navigator.pop(context);
                    cubit.updateProfile(context: context);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextButton(
                  borderRadius: 20,
                  borderColor: AppColors.primaryColor,
                  backgroundColor: Colors.white,
                  child: Text(
                    'Cancel'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor),
                  ),
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

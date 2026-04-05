import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/component/custom_text_form_field.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/auth/forgetPassword/view/presentation/forget_password_view.dart';
import 'package:matlop_provider/feature/auth/login/presentation/manager/cubit/login_cubit.dart';
import 'package:matlop_provider/feature/auth/signUp/persentation/widgets/account_action_text.dart';
import 'package:matlop_provider/feature/auth/userType/user_type.dart';
import 'package:matlop_provider/core/component/custom_drop_down_model_button.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/feature/addNewAddress/data/models/country_model.dart' as add_new_address_country;
import 'package:matlop_provider/feature/addNewAddress/presentation/manager/getCountriesCubit/country_cubit.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  DateTime? _lastPressedAt;
  add_new_address_country.CountryData? selectedCountry;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        // Check if the user presses the back button twice within 2 seconds
        if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt!) > const Duration(seconds: 2)) {
          // Record the time of the first press
          _lastPressedAt = DateTime.now();
          // Show a toast message prompting the user to press again to exit
          Utils.showToast(title: 'Click again to exit', state: UtilState.success);
        } else {
          exit(0);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: const [
            // ArrowBackButton(),
            Spacer(),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20.sp),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Please enter your phone number to log in'.tr(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<CountryCubit, CountryState>(
                    builder: (context, state) {
                      final List<add_new_address_country.CountryData> apiCountries = ConstantModel.countryModel?.data ?? [];
                      if (selectedCountry == null && apiCountries.isNotEmpty) {
                        selectedCountry = apiCountries.firstWhere((c) => c.countryId == 1, orElse: () => apiCountries.first);
                      }

                      final List<DropDownModel> cList = apiCountries.map((e) {
                        return DropDownModel(
                          '${e.phoneCode}',
                          e.countryId,
                        );
                      }).toList();

                      return CustomTextFormField(
                        labelStringText: 'Phone Number'.tr(),
                        controller: LoginCubit.of(context).phoneController,
                        hintText: 'xxxxxxxxx',
                        textInputType: TextInputType.number,
                        outPadding: EdgeInsets.zero,
                        arabicLanguage: false,
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (selectedCountry != null)
                              SizedBox(
                                width: 110,
                                child: CustomDropdownWithModel(
                                  text: '${selectedCountry!.phoneCode}',
                                  itemList: cList,
                                  textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),
                                  onItemSelected: (DropDownModel country) {
                                    setState(() {
                                      if (country.value != selectedCountry!.countryId) {
                                        LoginCubit.of(context).phoneController.clear();
                                      }
                                      selectedCountry = apiCountries.firstWhere((c) => c.countryId == country.value);
                                      Constants.selectedCountryId = selectedCountry!.countryId;
                                      Constants.myCountry = selectedCountry;
                                      userCache?.put(countryIdKey, selectedCountry!.countryId);
                                    });
                                  },
                                ),
                              ),
                          ],
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(selectedCountry?.maxPhoneLength ?? 15),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            return newValue;
                          }),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Empty Field'.tr();
                          }
                          final minLength = selectedCountry?.minPhoneLength ?? 0;
                          if (value.length < minLength) {
                            final isArabic = context.locale.languageCode == 'ar';
                            return isArabic
                                ? (selectedCountry?.phoneValidationMessageAr ?? 'Please enter a valid phone number'.tr())
                                : (selectedCountry?.phoneValidationMessageEn ?? 'Please enter a valid phone number'.tr());
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    labelStringText: 'Enter Password'.tr(),
                    controller: LoginCubit.of(context).passwordController,
                    hintText: '*******',
                    hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColor),
                    outPadding: EdgeInsets.zero,
                    password: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.navigateToPage(
                        const ForgetPasswordView(),
                      );
                    },
                    child: Text(
                      'Forget password?'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.primaryColor,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // BlocBuilder<LoginCubit, LoginState>(
                  //   builder: (context, state) {
                  //     return CustomTextButton(
                  //       gradientColors: const [
                  //         Color(0xff33C0A8),
                  //         Color(0xff20D4AD),
                  //       ],
                  //       stops: const [0.5, 1],
                  //       child: state is LoginLoading
                  //           ? const CircularProgressIndicator()
                  //           : Text(
                  //               'Login'.tr(),
                  //               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  //                     color: Colors.white,
                  //                   ),
                  //             ),
                  //       onPress: () {
                  //         if (_formKey.currentState!.validate()) {
                  //           LoginCubit.of(context).login(context: context);
                  //         }
                  //       },
                  //     );
                  //   },
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return CustomTextButton(
                        gradientColors: true,
                        stops: const [0.5, 1],
                        child: state is LoginLoading
                            ? const CircularProgressIndicator()
                            : Text(
                                'Login'.tr(),
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            if (selectedCountry != null) {
                              Constants.selectedCountryId = selectedCountry!.countryId;
                              Constants.myCountry = selectedCountry;
                              userCache?.put(countryIdKey, selectedCountry!.countryId);
                            }
                            LoginCubit.of(context).login(context: context);
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AccountActionText(
                    text1: "Don't have an account?".tr(),
                    text2: 'Create Account'.tr(),
                    onTap: () {
                      context.navigateToPage(
                        const UserTypeView(),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

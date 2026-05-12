import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/component/buttons/arrow_back_button.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/component/custom_text_form_field.dart';
import 'package:matlop_provider/core/component/custom_drop_down_model_button.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/utils/constants_enum.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/auth/login/presentation/login_view.dart';
import 'package:matlop_provider/feature/auth/login/presentation/manager/cubit/login_cubit.dart';
import 'package:matlop_provider/feature/auth/signUp/persentation/manager/register_cubit.dart';
import 'package:matlop_provider/feature/auth/signUp/persentation/widgets/account_action_text.dart';
import 'package:matlop_provider/feature/auth/signUp/persentation/widgets/technical_widget.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/feature/addNewAddress/data/models/country_model.dart' as add_new_address_country;
import 'package:matlop_provider/feature/addNewAddress/presentation/manager/getCountriesCubit/country_cubit.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final formKey = GlobalKey<FormState>();
  add_new_address_country.CountryData? selectedCountry;

  @override
  void initState() {
    super.initState();
    // Fetch worker types when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RegisterCubit.of(context).getWorkerTypes();
    });
  }

  /// Validator: accepts Arabic letters, English letters, and spaces only — no digits or symbols.
  String? _validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Empty Field'.tr();
    }
    // Arabic letters: \u0600-\u06FF, English letters: a-zA-Z, spaces allowed
    final lettersOnly = RegExp(r'^[\u0600-\u06FFa-zA-Z\s]+$');
    if (!lettersOnly.hasMatch(value.trim())) {
      return 'Name must contain letters only'.tr();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = RegisterCubit.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: const [
          ArrowBackButton(),
          Spacer(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Account'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20.sp),
                ),
                const SizedBox(height: 10),
                Text(
                  'Please enter your data to create an account'.tr(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColor),
                ),
                const SizedBox(height: 20),

                // ── Full Name (letters only) ──────────────────────────
                CustomTextFormField(
                  labelStringText: 'Full Name'.tr(),
                  controller: cubit.fullNameController,
                  hintText: 'Please enter your full name'.tr(),
                  outPadding: EdgeInsets.zero,
                  // Block digits and common symbols at input level
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[\u0600-\u06FFa-zA-Z\s]'),
                    ),
                  ],
                  validator: _validateFullName,
                ),
                const SizedBox(height: 20),

                // ── Email ─────────────────────────────────────────────
                CustomTextFormField(
                  labelStringText: 'email'.tr(),
                  controller: cubit.emailController,
                  hintText: 'Please enter your email'.tr(),
                  outPadding: EdgeInsets.zero,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                // ── Username ──────────────────────────────────────────
                CustomTextFormField(
                  labelStringText: 'User Name'.tr(),
                  controller: cubit.userNameController,
                  hintText: 'Please enter your User Name'.tr(),
                  outPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 20),

                // ── Phone with country code ───────────────────────────
                BlocBuilder<CountryCubit, CountryState>(
                  builder: (context, state) {
                    final List<add_new_address_country.CountryData> apiCountries =
                        ConstantModel.countryModel?.data ?? [];
                    if (selectedCountry == null && apiCountries.isNotEmpty) {
                      selectedCountry = apiCountries.firstWhere(
                            (c) => c.countryId == 1,
                        orElse: () => apiCountries.first,
                      );
                      cubit.countryId = selectedCountry!.countryId;
                      ConstantModel.technicalSpecialListModel = null;
                      //
                      // Ensure Constants.selectedCountryId aligns with the selectedCountry
                      if (Constants.selectedCountryId != selectedCountry!.countryId) {
                        Constants.selectedCountryId = selectedCountry!.countryId;
                        Constants.myCountry = selectedCountry;
                        userCache?.put(countryIdKey, selectedCountry!.countryId);
                      }
                    }

                    final List<DropDownModel> cList = apiCountries.map((e) {
                      return DropDownModel('${e.phoneCode}', e.countryId);
                    }).toList();

                    return CustomTextFormField(
                      labelStringText: 'Phone Number'.tr(),
                      controller: cubit.phoneController,
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
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 14),
                                onItemSelected: (DropDownModel country) {
                                  setState(() {
                                    if (country.value != selectedCountry!.countryId) {
                                      cubit.phoneController.clear();
                                      
                                      // Clear data related to previous country
                                      cubit.clearTechnicalSpecial();
                                      ConstantModel.technicalSpecialListModel = null;

                                      selectedCountry = apiCountries
                                          .firstWhere((c) => c.countryId == country.value);
                                      cubit.countryId = selectedCountry!.countryId;
                                      Constants.selectedCountryId = selectedCountry!.countryId;
                                      Constants.myCountry = selectedCountry;
                                      userCache?.put(countryIdKey, selectedCountry!.countryId);
                                    }
                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(
                            selectedCountry?.maxPhoneLength ?? 15),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Empty Field'.tr();
                        }
                        final minLength = selectedCountry?.minPhoneLength ?? 0;
                        if (value.length < minLength) {
                          final isArabic = context.locale.languageCode == 'ar';
                          return isArabic
                              ? (selectedCountry?.phoneValidationMessageAr ??
                              'Please enter a valid phone number'.tr())
                              : (selectedCountry?.phoneValidationMessageEn ??
                              'Please enter a valid phone number'.tr());
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),

                // ── Gender ────────────────────────────────────────────
                BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (_, current) => current is AddTechnicalState,
                  builder: (context, _) {
                    return CustomDropdownWithModel(
                      nameFiled: 'Gender'.tr(),
                      text: cubit.selectedGender.label,
                      itemList: const [
                        DropDownModel('male', 1),
                        DropDownModel('female', 2),
                      ],
                      textStyle: Theme.of(context).textTheme.bodyMedium!,
                      onItemSelected: (item) {
                        cubit.selectedGender =
                        item.value == 1 ? GenderEnum.male : GenderEnum.female;
                        cubit.emit(AddTechnicalState());
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),

                // ── Worker Type ───────────────────────────────────────
                BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (_, current) =>
                  current is GetWorkerTypesLoading ||
                      current is GetWorkerTypesSuccess ||
                      current is GetWorkerTypesError ||
                      current is AddTechnicalState,
                  builder: (context, state) {
                    final isLoading = state is GetWorkerTypesLoading;
                    final isAr = context.locale.languageCode == 'ar';
                    final workerList = cubit.workerTypes
                        .map((e) => DropDownModel(
                      isAr ? (e.arName ?? '') : (e.enName ?? ''),
                      e.id ?? 0,
                    ))
                        .toList();

                    return AbsorbPointer(
                      absorbing: isLoading,
                      child: Opacity(
                        opacity: isLoading ? 0.5 : 1.0,
                        child: CustomDropdownWithModel(
                          nameFiled: 'Worker Type'.tr(),
                          text: cubit.selectedWorkerType == null
                              ? 'Select worker type'.tr()
                              : (isAr
                              ? (cubit.selectedWorkerType!.arName ?? '')
                              : (cubit.selectedWorkerType!.enName ?? '')),
                          itemList: workerList,
                          textStyle: Theme.of(context).textTheme.bodyMedium!,
                          onItemSelected: (item) {
                            cubit.selectedWorkerType =
                                cubit.workerTypes.firstWhere((e) => e.id == item.value);
                            cubit.emit(AddTechnicalState());
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // ── Technical Specialties ─────────────────────────────
                AddAdditionalItems(registerCubit: cubit),
                const SizedBox(height: 20),

                // ── Password ──────────────────────────────────────────
                CustomTextFormField(
                  labelStringText: 'Password'.tr(),
                  controller: cubit.passwordController,
                  hintText: 'Password'.tr(),
                  outPadding: EdgeInsets.zero,
                  password: true,
                ),
                const SizedBox(height: 20),

                // ── Confirm Password ──────────────────────────────────
                CustomTextFormField(
                  labelStringText: 'Confirm Password'.tr(),
                  controller: cubit.confirmPasswordController,
                  hintText: 'Confirm Password'.tr(),
                  outPadding: EdgeInsets.zero,
                  password: true,
                ),
                const SizedBox(height: 40),

                // ── Submit ────────────────────────────────────────────
                BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (_, current) =>
                  current is RegisterLoading ||
                      current is RegisterError ||
                      current is RegisterSuccess,
                  builder: (context, state) {
                    return CustomTextButton(
                      gradientColors: true,
                      stops: const [0.5, 1],
                      child: state is RegisterLoading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      )
                          : Text(
                        'Create Account'.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.white),
                      ),
                      onPress: () {
                        if (state is RegisterLoading) return;
                        if (!formKey.currentState!.validate()) return;
                        if (cubit.selectedWorkerType == null) {
                          Utils.showToast(
                            title: 'Please select a worker type'.tr(),
                            state: UtilState.warning,
                          );
                          return;
                        }
                        if (cubit.passwordController.text.isNotEmpty &&
                            cubit.passwordController.text !=
                                cubit.confirmPasswordController.text) {
                          Utils.showToast(
                            title: 'Passwords does not match'.tr(),
                            state: UtilState.warning,
                          );
                          return;
                        }
                        cubit.register(context: context);
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),

                AccountActionText(
                  text1: 'Already have an account?'.tr(),
                  text2: 'Log In'.tr(),
                  onTap: () {
                    context.navigateToPage(
                      BlocProvider(
                        create: (context) => LoginCubit(),
                        child: const LoginView(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/component/custom_drop_down_model_button.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/feature/addNewAddress/data/models/country_model.dart' as add_new_address_country;
import 'package:matlop_provider/feature/addNewAddress/presentation/manager/getCountriesCubit/country_cubit.dart';
import 'package:matlop_provider/core/component/buttons/arrow_back_button.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/component/custom_text_form_field.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/feature/auth/forgetPassword/manager/resetCubit/reset_password_cubit.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  add_new_address_country.CountryData? selectedCountry;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot Password'.tr(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20.sp),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Please enter your phone number to reset your password'.tr(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColor),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: formKey,
                child: BlocBuilder<CountryCubit, CountryState>(
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
                      controller: ResetPasswordCubit.of(context).phoneController,
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
                                      ResetPasswordCubit.of(context).phoneController.clear();
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
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextButton(
                gradientColors: true,
                stops: const [0.5, 1],
                child: Text(
                  'Reset Password'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
                onPress: () {
                  if (formKey.currentState!.validate()) {
                    if (selectedCountry != null) {
                      Constants.selectedCountryId = selectedCountry!.countryId;
                      Constants.myCountry = selectedCountry;
                      userCache?.put(countryIdKey, selectedCountry!.countryId);
                    }
                    ResetPasswordCubit.of(context).verifyPhoneNumber(context: context);
                  }
                  //context.navigateToPage(const OtpView());
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matlop_provider/core/component/buttons/arrow_back_button.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/component/custom_text_form_field.dart';
import 'package:matlop_provider/core/component/custom_drop_down_model_button.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_icons.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/utils/constants_enum.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/manager/addNewAddress/cubit/add_new_address_cubit.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/widgets/select_country_bottom_sheet.dart';
import 'package:matlop_provider/feature/auth/login/presentation/login_view.dart';
import 'package:matlop_provider/feature/auth/login/presentation/manager/cubit/login_cubit.dart';
import 'package:matlop_provider/feature/auth/signUp/persentation/manager/register_cubit.dart';
import 'package:matlop_provider/feature/auth/signUp/persentation/widgets/account_action_text.dart';
import 'package:matlop_provider/feature/auth/signUp/persentation/widgets/technical_widget.dart';
import 'package:matlop_provider/feature/menu/views/editProfile/data/models/country_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final formKey = GlobalKey<FormState>();
  Country? selectedCountry;
  final FocusNode _locationNameFocusNode = FocusNode();

  @override
  void initState() {
    selectedCountry = Constants.countries[4];
    super.initState();
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
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Please enter your data to create an account'.tr(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    CustomTextFormField(
                      labelStringText: 'First Name'.tr(),
                      controller: RegisterCubit.of(context).firstNameController,
                      hintText: 'Please enter your first name'.tr(),
                      outPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      labelStringText: 'Last Name'.tr(),
                      controller: RegisterCubit.of(context).lastNameController,
                      hintText: 'Please enter your last name'.tr(),
                      outPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      labelStringText: 'email'.tr(),
                      controller: RegisterCubit.of(context).emailController,
                      hintText: 'Please enter your email'.tr(),
                      outPadding: EdgeInsets.zero,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      labelStringText: 'User Name'.tr(),
                      controller: RegisterCubit.of(context).userNameController,
                      hintText: 'Please enter your User Name'.tr(),
                      outPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      // prefixIcon: Padding(
                      //   padding:
                      //       EdgeInsets.only(left: context.locale.languageCode == 'en' ? 8 : 0, right: context.locale.languageCode == 'ar' ? 8 : 0),
                      //   child: CountryDropdown(
                      //     selectedCountry: selectedCountry,
                      //     onChanged: (Country? newValue) {
                      //       setState(() {
                      //         selectedCountry = newValue;
                      //       });
                      //     },
                      //   ),
                      // ),
                      arabicLanguage: false,
                      labelStringText: 'Phone Number'.tr(),
                      controller: RegisterCubit.of(context).phoneController,
                      hintText: '5xxxxxxxxx'.tr(),
                      outPadding: EdgeInsets.zero,
                      textInputType: TextInputType.number,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(AppIcons.saudiFlagIc),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(9),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          final text = newValue.text;

                          // Enforce the "05" rule
                          //  if (text.isEmpty) return oldValue; // Prevent deleting all text
                          if (text.length == 1 && text[0] != '5') return oldValue; // Second char must be "5"

                          return newValue; // Allow valid input
                        }),
                      ],
                    ),
                    // CustomTextFormField(
                    //   labelStringText: 'Phone Number'.tr(),
                    //   controller: RegisterCubit.of(context).firstNameController,
                    //   hintText: '05xxxxxxxxx',
                    //   textInputType: TextInputType.number,
                    //   outPadding: EdgeInsets.zero,
                    //   inputFormatters: [
                    //     FilteringTextInputFormatter.digitsOnly,
                    //     LengthLimitingTextInputFormatter(10),
                    //     TextInputFormatter.withFunction((oldValue, newValue) {
                    //       final text = newValue.text;

                    //       // Enforce the "05" rule
                    //       //  if (text.isEmpty) return oldValue; // Prevent deleting all text
                    //       if (text.length == 1 && text != '0') return oldValue; // First char must be "0"
                    //       if (text.length == 2 && text[1] != '5') return oldValue; // Second char must be "5"

                    //       return newValue; // Allow valid input
                    //     }),
                    //   ],
                    // ),
                  ],
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                // CustomTextFormField(
                //   labelStringText: 'National ID'.tr(),
                //   controller: RegisterCubit.of(context).nationalNo,
                //   hintText: 'National ID'.tr(),
                //   outPadding: EdgeInsets.zero,
                // ),
                const SizedBox(height: 10),
                BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (_, current) => current is AddTechnicalState,
                  builder: (context, _) {
                    final cubit = RegisterCubit.of(context);
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
                const SizedBox(
                  height: 20,
                ),

                AddAdditionalItems(registerCubit: RegisterCubit.of(context)),
                const SizedBox(
                  height: 10,
                ),

                // GestureDetector(
                //   onTap: () {
                //     _locationNameFocusNode.unfocus();
                //     showModalBottomSheet(
                //       context: context,
                //       isScrollControlled: true,
                //       backgroundColor: Colors.transparent,
                //       builder: (context) {
                //         return MultiBlocProvider(
                //           providers: [
                //             BlocProvider(
                //               create: (context) => AddNewAddressCubit(),
                //             ),
                //           ],
                //           child: SelectCountryBottomSheet(
                //             onTap: (countryData) {
                //               cubit.countryName.text = countryData.enName.toString();
                //               cubit.countryId = countryData.countryId;
                //             },
                //           ),
                //         );
                //       },
                //     );
                //   },
                //   child: CustomTextFormField(
                //     labelStringText: 'Country'.tr(),
                //     controller: cubit.countryName,
                //     hintText: 'Country'.tr(),
                //     outPadding: EdgeInsets.zero,
                //     borderColor: Colors.grey.withOpacity(0.2),
                //     suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
                //     focusNode: _locationNameFocusNode,
                //     enable: false,
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
                //               initialDate: DateTime(2000),
                //               onDateSelected: (date) {
                //                 setState(() {
                //                   // cubit.dateOfBirthController.text = DateFormat('yyyy-MM-dd','en').format(date);
                //                 });
                //               },
                //             ),
                //           ),
                //         );
                //       },
                //     );
                //   },
                //   child: CustomTextFormField(
                //     labelStringText: 'Select Date'.tr(),
                //     controller: TextEditingController(),
                //     hintText: 'Select Date'.tr(),
                //     outPadding: EdgeInsets.zero,
                //     enable: false,
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),

                CustomTextFormField(
                  labelStringText: 'Password'.tr(),
                  controller: RegisterCubit.of(context).passwordController,
                  hintText: 'Password'.tr(),
                  outPadding: EdgeInsets.zero,
                  password: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  labelStringText: 'Confirm Password'.tr(),
                  controller: RegisterCubit.of(context).confirmPasswordController,
                  hintText: 'Confirm Password'.tr(),
                  outPadding: EdgeInsets.zero,
                  password: true,
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomTextButton(
                  gradientColors: true,
                  stops: const [0.5, 1],
                  child: Text(
                    'Create Account'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  onPress: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    if ((cubit.passwordController.text.isNotEmpty) && cubit.passwordController.text != cubit.confirmPasswordController.text) {
                      Utils.showToast(title: 'Passwords does not match'.tr(), state: UtilState.warning);
                      return;
                    }
                    cubit.register(context: context);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                AccountActionText(
                  text1: 'Already have an account?'.tr(),
                  text2: 'Log In'.tr(),
                  onTap: () {
                    context.navigateToPage(BlocProvider(create: (context) => LoginCubit(), child: const LoginView()));
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/generated/l10n.dart';
import 'package:flutter_template/modules/authentication/controller/sign_up_controller.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/utils/navigation_utils/routes.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:flutter_template/widget/custom_button.dart';
import 'package:flutter_template/widget/custom_textfeild.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController _signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return CustomAnnotatedRegions(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.36.h,
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                LayoutBuilder(
                  builder: (context, constraint) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: constraint.maxHeight),
                        child: IntrinsicHeight(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    20.h.verticalSpace,
                                    _loginWidget(),
                                    3.verticalSpace,
                                    Center(
                                      child: Text(
                                        S.of(context).register,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                    ),
                                    5.verticalSpace,
                                    _emailTextField(),
                                    20.h.verticalSpace,
                                    _passwordTextField(),
                                    2.h.verticalSpace,
                                    Text(
                                      S.of(context).passwordValidationMsg,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                    3.5.verticalSpace
                                  ],
                                ),
                              ),
                              // Spacer(),
                              _agreeWidget(),
                              8.5.verticalSpace,
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () => Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 2.h,
                        ),
                        child: CustomButton(
                          isLoader: _signUpController.isLoading.value,
                          text: S.of(context).signUp,
                          isDisabled: _signUpController.isDisable.value,
                          onTap: () {
                            onSubmit(context);
                          },
                        ),
                      ),
                    ),
                   2.h.verticalSpace,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit(BuildContext context) async {
    Utils.hideKeyboardInApp(context);
    await _signUpController.signUp();
   /* if (_signUpController.checkError()) {

    }*/
  }

  Widget _loginWidget() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          Navigation.replaceAll(Routes.signIn);
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            S.of(context).login,
            style: TextStyle(
              color: AppColors.appThemeColor,
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return CustomTextField(
      controller: _signUpController.controller,
      hintText: S.of(context).enterEmailAddress,
      keyboardType: TextInputType.emailAddress,
      onChanged: (String? data) {
        _signUpController.handleDisable();
      },
    );
  }

  Widget _agreeWidget() {
    return Row(
      children: [
        Obx(() => Checkbox(
              checkColor: Colors.white,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: _signUpController.isCheck.value,
              shape: const CircleBorder(),
              onChanged: (bool? val) {
                _signUpController.isCheck.value = val!;
                _signUpController.handleDisable();
              },
            )),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: S.of(context).readAndAgreeMsg,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor,
                  ),
                ),
                TextSpan(
                  text: S.of(context).appAgreement,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.appThemeColor,
                  ),
                ),
                TextSpan(
                  text: "${S.of(context).and} ",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor,
                  ),
                ),
                TextSpan(
                  text: S.of(context).privacyNotice,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.appThemeColor,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _passwordTextField() {
    return CustomTextField(
      controller: _signUpController.passwordController,
      hintText: S.of(context).password,
      isPassword: true,
      onChanged: (String? data) {
        _signUpController.handleDisable();
      },
    );
  }
}

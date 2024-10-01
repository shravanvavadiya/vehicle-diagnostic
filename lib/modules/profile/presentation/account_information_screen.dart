import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/app_text.dart';
import 'package:flutter_template/utils/assets.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:flutter_template/widget/custom_button.dart';
import 'package:get/get.dart';
import '../../../utils/utils.dart';
import '../../../utils/validation_utils.dart';
import '../../dashboad/home/presentation/home_screen.dart';
import '../../personal_information_view/presentation/user_information_screen.dart';
import '../controller/profile_controller.dart';

class AccountInformationScreen extends StatefulWidget {
  AccountInformationScreen({super.key});

  @override
  State<AccountInformationScreen> createState() => _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return CustomAnnotatedRegions(
        statusBarColor: AppColors.transparent,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            leadingWidth: 30,
            elevation: 0,
            title: AppText(
              text: profileController.screenName.value,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w600,
              fontSize: 17.sp,
            ),
            leading: GestureDetector(
              onTap: () {
                Navigation.pop();
              },
              child: SvgPicture.asset(
                IconAsset.leftArrow,
                height: 18.h,
              ),
            ).paddingOnly(left: 16.w),
          ),
          body: Column(
            children: [
              Expanded(
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: SingleChildScrollView(
                    child: Form(
                      key: profileController.updateFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Obx(() {
                                  return profileController.image!.value.isEmpty
                                      ? Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: AppColors.borderColor,
                                              width: 0.5.w,
                                            ),
                                          ),
                                          child: CircularProgressIndicator(color: AppColors.highlightedColor).paddingAll(50.w),
                                        )
                                      : ClipOval(
                                          child: GestureDetector(
                                            onTap: () async {
                                              await Utils()
                                                  .imagePickerModel(selectImage: profileController.imagePath, image: profileController.image);
                                              profileController.isValidateImage.value = true;
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: AppColors.borderColor,
                                                  width: 0.5.w,
                                                ),
                                              ),
                                              height: 150.h,
                                              width: 150.h,
                                              child: Image.network(
                                                profileController.image!.value,
                                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Center(
                                                    child: CircularProgressIndicator(color: AppColors.highlightedColor),
                                                  );
                                                },
                                                height: 150.h,
                                                width: 150.h,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) => Image.file(
                                                  File(profileController.image!.value),
                                                  fit: BoxFit.cover,
                                                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                                    if (frame == null) {
                                                      return Center(
                                                        child: CircularProgressIndicator(color: AppColors.highlightedColor),
                                                      );
                                                    }
                                                    return child;
                                                  },
                                                ),
                                              ),

                                              /*  CachedNetworkImage(
                                                  color: Colors.transparent,
                                                  imageUrl: profileController.image.value,
                                                  fit: BoxFit.cover,

                                                  imageBuilder: (context, imageProvider) => Container(
                                                    height: 152.h,
                                                    width: 152.w,
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius: BorderRadius.circular(9.r),
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) => Center(
                                                    child: CircularProgressIndicator(
                                                      color: AppColors.highlightedColor,
                                                    ),
                                                  ),
                                                  errorWidget: (context, url, error) =>  CircularProgressIndicator(
                                                    color: AppColors.highlightedColor,
                                                  ),
                                                ),*/

                                              // Image.file(
                                              //   File(editProfileController.pickedImage.value),
                                              //   fit: BoxFit.cover,
                                              // ):
                                              // editProfileController.profileImage.value != null && editProfileController.profileImage.value != ""
                                              //     ? CommonNetworkImageLoader(imageUrl: editProfileController.profileImage.value,)
                                              //     : SvgPicture.asset(IconsAsset.placeHolderIconImage)
                                              // : Image.asset(
                                              //     ImagesAsset.profileImage,
                                              //     fit: BoxFit.cover,
                                              //   ),
                                            ),
                                          ),
                                        );
                                }),
                                Obx(
                                  () => profileController.image?.value != null && profileController.image!.value.isEmpty
                                      ? const SizedBox()
                                      : Positioned(
                                          right: 6.w,
                                          bottom: 6.h,
                                          child: GestureDetector(
                                            onTap: () async {
                                              await Utils()
                                                  .imagePickerModel(selectImage: profileController.imagePath, image: profileController.image);

                                              profileController.isValidateImage.value = true;
                                            },
                                            child: ClipOval(
                                              child: Container(
                                                padding: EdgeInsets.all(5.r),
                                                height: 31.h,
                                                width: 31.h,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppColors.blackColor.withOpacity(0.5),
                                                      spreadRadius: 14,
                                                      blurRadius: 12,
                                                    ),
                                                  ],
                                                  color: AppColors.whiteColor,
                                                ),
                                                child: SvgPicture.asset(IconAsset.editIcon, color: AppColors.primaryColor).paddingAll(3.w),
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ).paddingOnly(top: 25.h),
                          /*  Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                                onTap: () async {
                                  log("profileController.imagePath ::${profileController.imagePath}");
                                  await Utils().imagePickerModel(
                                      selectImage: profileController.imagePath,
                                      image: profileController.image);
                                  log("profileController.imagePath 2::${profileController.imagePath}");
                                },
                                child: Container(
                                  height: 150.w,
                                  width: 150.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(165.r),
                                      color: Colors.red,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            " ${profileController.image.value}"),
                                      )),
                                )),
                          ).paddingOnly(
                            top: 25,
                          ),*/
                          customTextFormField(
                            text: AppString.firstName,
                            hintText: AppString.firstName,
                            validator: AppValidation.nameValidator,
                            textCapitalization: TextCapitalization.words,
                            controller: profileController.firstname,
                            onChanged: (String) {
                              profileController.isValidateName.value = profileController.firstname.text.isNotEmpty;
                            },
                          ).paddingOnly(top: 24.h, bottom: 16.h),
                          customTextFormField(
                            text: AppString.lastName,
                            hintText: AppString.lastName,
                            validator: AppValidation.lastNameValidator,
                            textCapitalization: TextCapitalization.words,
                            controller: profileController.lastname,
                            onChanged: (String) {
                              profileController.isValidateLastName.value = profileController.lastname.text.isNotEmpty;
                            },
                          ),
                          customTextFormField(
                            text: AppString.email,
                            hintText: AppString.emailEx,
                            controller: profileController.email,
                            readOnly: true,
                            keyboardType: TextInputType.emailAddress,
                            // validator: AppValidation.emailValidator,
                            /* onChanged: (String) {
                              profileController.isValidateEmail.value = profileController.email.text.isNotEmpty;
                            },*/
                          ).paddingSymmetric(vertical: 16.h),
                          customTextFormField(
                            text: AppString.postCode,
                            hintText: AppString.postCode,
                            validator: AppValidation.postCode,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            controller: profileController.postCode,
                            onChanged: (String) {
                              profileController.isValidatePostCode.value = profileController.postCode.text.isNotEmpty;
                            },
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 16.w),
                    ),
                  ),
                ),
              ),
              CustomButton(
                onTap: () async {
                  if (profileController.updateFormKey.currentState?.validate() ?? false) {
                    profileController.updateUserProfileAPI(
                      email: profileController.email.text,
                      firstname: profileController.firstname.text,
                      lastname: profileController.lastname.text,
                      postCode: profileController.postCode.text,
                      imagePath: profileController.image!.value.contains("http") ? null : profileController.image!.value,
                    );
                  }
                },
                /*   isDisabled: (profileController.isValidateName.value &&
                          profileController.isValidateLastName.value &&
                          profileController.isValidatePostCode.value&&
                        profileController.image.value.isNotEmpty)
                      ? false
                      : true,*/
                height: 52.h,
                buttonColor: AppColors.highlightedColor,
                fontSize: 15.h,
                //   disableTextColor: AppColors.whiteColor,
                text: AppString.updateProfile,
                borderRadius: BorderRadius.circular(8.r),
              ).paddingSymmetric(
                horizontal: 16.w,
                vertical: 25.h,
              ),
            ],
          ),
        ));
  }
}

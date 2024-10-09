import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_string.dart';
import '../../../utils/app_text.dart';
import '../../../utils/assets.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../personal_information_view/presentation/user_information_screen.dart';
import '../controller/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  final int vehicleId;
  final int userId;

  const ChatScreen({super.key, required this.vehicleId, required this.userId});

  @override
  Widget build(BuildContext context) {
    return GetX<ChatController>(
      init: ChatController(vehicleId: vehicleId),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            leadingWidth: 30,
            elevation: 0,
            title: AppText(
              text: controller.screenHeading.value,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
            ),
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset(
                IconAsset.leftArrow,
                color: AppColors.primaryColor,
              ),
            ).paddingOnly(left: 16.w),
            actions: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    // controller.isResponse.value = false;
                    // controller.getAllChatQuestion();
                    log("userId ${userId}");
                    controller.downloadUserReport(userId: userId);
                  },
                  child: Container(
                    width: 72.w,
                    height: 28.h,
                    decoration: BoxDecoration(
                      color: AppColors.highlightedColor,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Center(
                      child: AppText(
                        text: AppString.finish,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ).paddingOnly(right: 16.w)
            ],
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                  child: controller.isResponse.value == true
                      ? ListView.builder(
                          itemCount: controller.fillAnswer.value,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(43.r),
                                          child: Image.asset(
                                            IconAsset.appLogo,
                                            height: 32.h,
                                            width: 32.h,
                                          ),
                                        ).paddingOnly(right: 8.w),
                                        Expanded(
                                          child: AppText(
                                            // text: "What is the current mileage of the vehicle?",
                                            text: controller.questionAndAnswerList[index].question.toString(),
                                            fontWeight: FontWeight.w500,
                                            maxLines: 3,
                                            fontSize: 14.sp,
                                            color: AppColors.grey60,
                                          ),
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        print("object ${controller.questionAndAnswerList[index].question}");
                                        await Clipboard.setData(ClipboardData(text: "${controller.questionAndAnswerList[index].question}"));
                                      },
                                      child: SvgPicture.asset(IconAsset.copyIcon).paddingOnly(
                                        left: 38.w,
                                      ),
                                    )
                                  ],
                                ).paddingOnly(left: 16.w, right: 16.w, top: 16.h),
                                controller.questionAndAnswerList[index].answer!.isNotEmpty
                                    ? Align(
                                        alignment: Alignment.bottomRight,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 44.h,
                                              width: Get.width / 1.5,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6.r),
                                                color: AppColors.chatBgColor,
                                              ),
                                              child: Center(
                                                child: AppText(
                                                  text: controller.questionAndAnswerList[index].answer.toString(),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.sp,
                                                  color: AppColors.grey60,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ).paddingAll(10),
                                            ),
                                            SvgPicture.asset(
                                              IconAsset.icEditIcon,
                                              color: AppColors.editIconColor,
                                            ),
                                          ],
                                        ).paddingOnly(left: 16.w, right: 16.w, top: 16.h),
                                      )
                                    : SizedBox(),
                              ],
                            );
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            color: AppColors.highlightedColor,
                          ),
                        )),
            ],
          ),
          bottomNavigationBar: controller.isResponse.value == true
              ? TextFormField(
                  controller: controller.answerController.value,
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.blackColor, decoration: TextDecoration.none),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: AppColors.textFieldBorderColor,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: AppColors.textFieldBorderColor, width: 1.0),
                      ),
                      hintText: AppString.typeAMessage,
                      hintStyle: TextStyle(
                        color: AppColors.editIconColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: !controller.isCheckText.value
                            ? () {}
                            : () {
                                log(controller.questionAndAnswerList[controller.fillAnswer.value - 1].question.toString());
                                log(controller.answerController.value.text);

                                controller.submitUserAns(
                                    answer: controller.answerController.value.text,
                                    question: controller.questionAndAnswerList[controller.fillAnswer.value - 1].question.toString());

                                Utils.hideKeyboardInApp(context);
                                controller.isCheckText.value = false;
                              },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(180.r),
                              color: !controller.isCheckText.value ? AppColors.highlightedColor.withOpacity(0.5) : AppColors.highlightedColor),
                          height: 34.w,
                          width: 34.w,
                          child: Center(
                            child: Icon(
                              Icons.arrow_upward_outlined,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ).paddingOnly(right: 10, bottom: 5, top: 5),
                      )),
                  onChanged: (value) {
                    log("value $value");
                    value.isNotEmpty ? controller.isCheckText.value = true : controller.isCheckText.value = false;
                  },
                ).paddingOnly(right: 16.w, left: 16.w, bottom: MediaQuery.of(context).viewInsets.bottom + 16.h, top: 15.h)
              : SizedBox(),
        );
      },
    );
  }
}

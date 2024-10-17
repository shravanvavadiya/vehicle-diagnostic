import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/modules/dashboad/home/presentation/home_screen.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_string.dart';
import '../../../utils/app_text.dart';
import '../../../utils/assets.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../personal_information_view/presentation/user_information_screen.dart';
import '../controller/chat_controller.dart';
import 'generate_pdf_pop_up.dart';

class ChatScreen extends StatefulWidget {
  final int vehicleId;
  final int userId;
  final String screenFlag;

  const ChatScreen({super.key, required this.vehicleId, required this.userId, required this.screenFlag});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    // TODO: implement initState
    super.initState();
  }

  void scrollToBottom() {
    // Animate to the bottom of the scrollable content
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

// This method is called when the app's dimensions change (keyboard open/close)
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    log("open");
    // Check if the keyboard is visible
    if (WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
      // If keyboard is visible, scroll to the end
      scrollToBottom();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("vehicleId 0000000000000 ${widget.vehicleId}");
    return GetX<ChatController>(
      init: ChatController(vehicleId: widget.vehicleId),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            return await Get.offAll(HomeScreen());
          },
          child: Scaffold(
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
                  widget.screenFlag == AppString.generateReportFlag ? Get.back() : Get.offAll(HomeScreen());
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
                      log("vehicleId ${widget.vehicleId}");
                      log("controller.fillAnswer.value ${controller.fillAnswer.value}");
                      log("controller.questionAndAnswerList.length ${controller.splitQuestionList.length}");
                      (controller.isResponse.value != true || controller.isAllAnswerAdd.value == false)
                          ? {}
                          : showGeneratePdfDialog(vehicleId: widget.vehicleId, controller: controller);
                    },
                    child: Container(
                      width: 72.w,
                      height: 28.h,
                      decoration: BoxDecoration(
                        color: (controller.isResponse.value != true || controller.isAllAnswerAdd.value == false)
                            ? AppColors.primaryColor.withOpacity(0.5)
                            : AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Center(
                        child: AppText(
                          text: AppString.generate,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ).paddingOnly(right: 16.w)
              ],
            ),
            body: controller.isResponse.value == true
                ? SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
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
                                    ).paddingOnly(bottom: 8.h),
                                    // GestureDetector(
                                    //   onTap: () async {
                                    //     print("object ${controller.questionAndAnswerList[index].question}");
                                    //     await Clipboard.setData(ClipboardData(text: "${controller.questionAndAnswerList[index].question}"));
                                    //     // controller.answerController.value.text = controller.questionAndAnswerList[index].question ?? "";
                                    //     controller.isCheckText.value = true;
                                    //   },
                                    //   child: SvgPicture.asset(IconAsset.copyIcon).paddingOnly(
                                    //     left: 38.w,
                                    //   ),
                                    // )
                                  ],
                                ).paddingOnly(
                                  left: 16.w,
                                  right: 16.w,
                                  top: 16.h,
                                ),
                                controller.questionAndAnswerList[index].answer!.isNotEmpty
                                    ? Align(
                                        alignment: Alignment.bottomRight,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                controller.isEditSelectedIndex.value = index;
                                                controller.editQuestionAnswerFunction(currentIndex: index);

                                                controller.isAllAnswerAdd.value = false;
                                              },
                                              child: SvgPicture.asset(
                                                IconAsset.icEditIcon,
                                                color: AppColors.editIconColor,
                                              ),
                                            ).paddingOnly(right: 5),
                                            Container(
                                              // height: 44.h,
                                              // width: Get.width / 1.5,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6.r),
                                                color: AppColors.chatBgColor,
                                              ),
                                              child: AppText(
                                                text: controller.questionAndAnswerList[index].answer.toString(),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.sp,
                                                color: AppColors.grey60,
                                                textAlign: TextAlign.end,
                                              ).paddingAll(10),
                                            ).paddingOnly(bottom: 8.h),
                                          ],
                                        ).paddingOnly(left: 16.w, right: 16.w, top: 16.h),
                                      )
                                    : const SizedBox(),
                              ],
                            );
                          },
                        ).paddingOnly(bottom: 16.h),
                        controller.isAllAnswerAdd.value == true
                            ? Row(
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
                                      text: "I've got all the information I need to generate the report now you can generate the report",
                                      fontWeight: FontWeight.w500,
                                      maxLines: 3,
                                      fontSize: 14.sp,
                                      color: AppColors.grey60,
                                    ),
                                  )
                                ],
                              ).paddingOnly(right: 16.w, left: 16.w, bottom: 32.h)
                            : SizedBox()
                      ],
                    ))
                : Center(
                    child: CircularProgressIndicator(
                      color: AppColors.highlightedColor,
                    ),
                  ),
            bottomNavigationBar: AnimatedPadding(
              padding: EdgeInsets.only(),
              duration: Duration(seconds: 1),
              child: controller.isResponse.value == true
                  ? controller.isAllAnswerAdd.value == true
                      ? const SizedBox.shrink()
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            controller.isEditAnsValue.value == true
                                ? Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(6.r),
                                                    color: AppColors.chatBgColor,
                                                    border: Border.all(color: AppColors.primaryColor)),
                                                child: AppText(
                                                  text: controller.questionAndAnswerList[controller.isEditSelectedIndex.value].question.toString(),
                                                  fontWeight: FontWeight.w500,
                                                  maxLines: 3,
                                                  fontSize: 14.sp,
                                                  color: AppColors.grey60,
                                                ).paddingAll(12))
                                            .paddingOnly(right: 16.w, left: 16.w, top: 5.h),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            if (controller.isEditTimeIndex.value != -1) {
                                              controller.isEditTimeIndex.value = -1;
                                              controller.answerController.value.clear();
                                              controller.isEditAnsValue.value = false;
                                              controller.isCheckText.value = false;
                                              if (controller.questionAndAnswerList.length > controller.fillAnswer.value) {
                                              } else {
                                                controller.isAllAnswerAdd.value = true;
                                              }
                                            }
                                          },
                                          icon: const Icon(Icons.clear))
                                    ],
                                  )
                                : SizedBox(),
                            TextFormField(
                              focusNode: controller.myFocusNode,
                              controller: controller.answerController.value,
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.blackColor, decoration: TextDecoration.none),
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
                                            controller.isEditAnsValue.value == true
                                                ? {
                                                    controller.submitUserAns(
                                                        answer: controller.answerController.value.text,
                                                        question:
                                                            controller.questionAndAnswerList[controller.isEditTimeIndex.value].question.toString())
                                                  }
                                                : {
                                                    controller.submitUserAns(
                                                        answer: controller.answerController.value.text,
                                                        question:
                                                            controller.questionAndAnswerList[controller.fillAnswer.value - 1].question.toString())
                                                  };

                                            Utils.hideKeyboardInApp(context);
                                            controller.isCheckText.value = false;
                                            scrollToBottom();
                                          },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(180.r),
                                          color: !controller.isCheckText.value
                                              ? AppColors.highlightedColor.withOpacity(0.5)
                                              : AppColors.highlightedColor),
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
                            ).paddingOnly(right: 16.w, left: 16.w, bottom: MediaQuery.of(context).viewInsets.bottom + 16.h, top: 15.h),
                          ],
                        )
                  : const SizedBox.shrink(),
            ),
          ),
        );
      },
    );
  }
}

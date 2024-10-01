import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/modules/add_vehicle_information/controller/question_ans_controller.dart';
import 'package:flutter_template/modules/add_vehicle_information/models/selected_qns_ans_model.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_string.dart';
import '../../../utils/assets.dart';
import '../../../widget/custom_backarrow_widget.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/info_text_widget.dart';

class QuestionAndAnsScreen extends StatefulWidget {
  final String screenName;
  final int vehicleId;

  const QuestionAndAnsScreen({super.key, required this.screenName, required this.vehicleId});

  @override
  _QuestionAndAnsScreenState createState() => _QuestionAndAnsScreenState();
}

class _QuestionAndAnsScreenState extends State<QuestionAndAnsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetX<QuestionAndAnsController>(
      init: QuestionAndAnsController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          leading: CustomBackArrowWidget(
                  onTap: controller.currentStep > 0
                      ? () {
                          controller.pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      : () {
                          Get.back();
                          controller.clearAll();
                        })
              .paddingAll(11.r),
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          actions: [
            Obx(
              () => Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${controller.currentStep.value + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          color: AppColors.blackColor,
                        ),
                      ),
                      TextSpan(
                        text: "/${controller.vehicleModel.value.apiresponse?.data?.length ?? 0} Steps",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: AppColors.grey60.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ).paddingSymmetric(horizontal: 16.h),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: LinearProgressIndicator(
                value: controller.progress.value,
                backgroundColor: AppColors.backHighlightedColor,
                color: AppColors.highlightedColor,
                borderRadius: BorderRadius.circular(10),
                minHeight: 2.h,
              ),
            ),
            controller.isResponseData.value == true
                ? Expanded(
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller.pageController,
                      onPageChanged: (int page) {
                        controller.currentStep.value = page;
                        controller.updateProgress();
                      },
                      itemCount: controller.vehicleModel.value.apiresponse!.data!.length,
                      itemBuilder: (context, index) {
                        return _buildStepPage(
                            controller.vehicleModel.value.apiresponse!.data![index].question!.obs,
                            controller.vehicleModel.value.apiresponse!.data![index].answers!,
                            controller.vehicleModel.value.apiresponse!.data![index].key!.obs,
                            index.obs,
                            controller);
                      },
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.highlightedColor,
                      ),
                    ),
                  ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        floatingActionButton: controller.isResponseData.value == true
            ? GestureDetector(
                onTap: controller.currentStep.value < controller.vehicleModel.value.apiresponse!.data!.length - 1 &&
                        controller.selectedAnswers.containsKey(controller.currentStep.value)
                    ? () {
                        controller.pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                        log("vehicle id ${widget.vehicleId}");
                      }
                    : controller.currentStep.value == controller.vehicleModel.value.apiresponse!.data!.length - 1 &&
                            controller.selectedAnswers.containsKey(controller.currentStep)
                        ? () {
                            log("controller.selectedResponse ${controller.selectedResponseList}");
                            widget.screenName == AppString.editScreenFlag
                                ? controller.EditForm(vehicleId: widget.vehicleId, selectedResponse: controller.selectedResponseList)
                                : controller.submitForm(vehicleId: widget.vehicleId, selectedResponse: controller.selectedResponseList);
                          }
                        : null,
                child: Container(
                  height: 52.h,
                  width: 113.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(46.r),
                    color: controller.selectedAnswers.containsKey(controller.currentStep.value)
                        ? AppColors.highlightedColor
                        : AppColors.highlightedColor.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        controller.currentStep.value == controller.vehicleModel.value.apiresponse!.data!.length - 1
                            ? AppString.finish
                            : AppString.next,
                        style: TextStyle(fontSize: 16.h, color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      SvgPicture.asset(
                        IconAsset.forwardArrow,
                        height: 20.h,
                      ).paddingOnly(left: 14.w)
                    ],
                  ),
                ),
              ).paddingOnly(bottom: 25.h)
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildStepPage(RxString question, List<dynamic> answers, RxString questionKey, RxInt index, QuestionAndAnsController controller) {
    String? selectedAnswer = controller.selectedAnswers[index.value]; // Get the selected answer for this page

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.value,
            style: TextStyle(fontSize: 24.sp, height: 1.35.h, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
          ),
          const SizedBox(height: 20),
          Text(
            AppString.addYourVehicleInformationForBetterSearch,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.h, color: AppColors.grey60),
          ),
          Column(
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, listIndex) {
                    return CheckboxListTile(
                      checkColor: AppColors.primaryColor,
                      side: BorderSide(color: AppColors.transparent),
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.r),
                        side: BorderSide(
                          color: AppColors.whiteColor,
                          width: 0,
                        ),
                      ),
                      visualDensity: VisualDensity.standard,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        answers[listIndex],
                        style: TextStyle(
                          fontSize: 16.sp,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      value: selectedAnswer == answers[listIndex],
                      onChanged: (bool? value) {
                        log('Q&A===>onChanged 00  answers[listIndex]::${answers[listIndex]} value::$value');

                        if (value == true) {
                          log('Q&A===>onChanged 01 listIndex::$listIndex answers[listIndex]::${answers[listIndex]}');
                          controller.selectedAnswers[index.value] = answers[listIndex]; // Store answer by index
                          log('Q&A===>onChanged 02 BEFORE controller.selectedResponseList::${controller.selectedResponseList.toString()}');
                          log('Q&A===>onChanged 02 BEFORE controller.selectedAnswers::${controller.selectedAnswers.toString()}');
                          controller.selectedResponseList.removeWhere((element) => element.question == questionKey.value);

                          controller.selectedResponseList.add(SelectedQnsAnsModel(
                            answer: "${answers[listIndex]}",
                            question: questionKey.value,
                          ));
                          log('Q&A===>onChanged 03 AFTER controller.selectedResponseList::${controller.selectedResponseList.toString()}');
                          log('Q&A===>onChanged 03 AFTER controller.selectedAnswers::${controller.selectedAnswers.toString()}');
                        } else {
                          controller.selectedAnswers.remove(index.value);
                          controller.selectedResponseList.removeWhere((element) => element.question == questionKey.value);
                          log('Q&A===>onChanged 04 FALSE AFTER controller.selectedResponseList::${controller.selectedResponseList.toString()}');
                          log('Q&A===>onChanged 04 FALSE AFTER controller.selectedAnswers::${controller.selectedAnswers.toString()}');
                        }
                        setState(() {});
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 15.h,
                      thickness: 0.5.h,
                      color: AppColors.borderColor,
                    );
                  },
                  itemCount: answers.length),
            ],
          )
        ],
      ),
    );
  }
}

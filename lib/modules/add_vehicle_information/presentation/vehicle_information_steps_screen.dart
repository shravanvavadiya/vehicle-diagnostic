import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_preferences.dart';
import '../../../utils/app_string.dart';
import '../../../utils/assets.dart';
import '../../../utils/loading_mixin.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../../utils/navigation_utils/routes.dart';
import '../../../widget/custom_backarrow_widget.dart';
import '../../../widget/custom_button.dart';
import '../controller/add_vehicle_information_controller.dart';
import '../models/vehicle_information_step_model.dart';

class VehicleInformationStepsScreen extends StatefulWidget {
  final String screenName;

  const VehicleInformationStepsScreen({super.key, required this.screenName});

  @override
  State<VehicleInformationStepsScreen> createState() => _VehicleInformationStepsScreenState();
}

class _VehicleInformationStepsScreenState extends State<VehicleInformationStepsScreen> {
  final PageController _pageController = PageController();

  final AddVehicleInformationController addVehicleQueController = Get.find();

  @override
  void initState() {
    addVehicleQueController.initializeFormStates(addVehicleQueController.getAllVehicleQueList.length);
    super.initState();
  }

  int? vehicleId;

  int _currentSegment = 0;
  int _currentFormIndex = 0;
  final int _totalFormsPerSegment = 4;

  final int _totalSegments = 3;

  int get _currentStep {
    int step = (_currentSegment * _totalFormsPerSegment) + _currentFormIndex + 1;
    int maxSteps = addVehicleQueController.getAllVehicleQueList.length;

    // Ensure the step doesn't exceed the total number of steps
    return step > maxSteps ? maxSteps : step;
  }

  /* int get _currentStep =>
      (_currentSegment * _totalFormsPerSegment) + _currentFormIndex + 1;*/

  void _updateProgress(int direction) {
    setState(() {
      // Update form index within the current segment
      _currentFormIndex += direction;

      // Handle boundaries for form navigation
      if (_currentFormIndex >= _totalFormsPerSegment) {
        _currentFormIndex = 0;
        if (_currentSegment < _totalSegments - 1) {
          _currentSegment++;
        }

        /*  if (_currentSegment < _totalSegments - 1) {
          _currentSegment++;
        }*/
      } else if (_currentFormIndex < 0) {
        _currentFormIndex = _totalFormsPerSegment - 1;
        if (_currentSegment > 0) {
          _currentSegment--;
        }

        /*_currentFormIndex = _totalFormsPerSegment - 1;
        if (_currentSegment > 0) {
          _currentSegment--;
        }*/
      }

      //  _currentSegment=_currentFormIndex ~/ _totalFormsPerSegment;

      // Navigate between segments when required
      _pageController.animateToPage(
        _currentSegment,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  double _getSegmentProgress(int segment) {
    // Get the start index for the current segment
    int startIndex = segment * _totalFormsPerSegment;
    // Calculate the progress for the current segment
    if (segment == _currentSegment) {
      int formsInThisSegment = _totalFormsPerSegment;
      // Make sure not to go out of bounds
      if (startIndex + formsInThisSegment > addVehicleQueController.getAllVehicleQueList.length) {
        formsInThisSegment = addVehicleQueController.getAllVehicleQueList.length - startIndex;
      }
      // Prevent division by zero
      if (formsInThisSegment == 0) {
        return 0.0;
      }
      return (_currentFormIndex + 1) / formsInThisSegment;
    }
    return segment < _currentSegment ? 1.0 : 0.0;
  }

/*  double _getSegmentProgress(int segment) {
    if (segment == _currentSegment) {
      return (_currentFormIndex + 1) / _totalFormsPerSegment;
    }
    return segment < _currentSegment ? 1.0 : 0.0;
  }*/

  @override
  Widget build(BuildContext context) {
    log("_currentFormIndex ::${_currentFormIndex + 1}");
    addVehicleQueController.currentIndex.value = _currentFormIndex + 1;
    return SafeArea(
      child: CustomAnnotatedRegions(
        child: Scaffold(
          appBar: AppBar(
            leading: CustomBackArrowWidget(onTap: () {
              if (_currentFormIndex > 0 || _currentSegment > 0) {
                _updateProgress(-1);
              } else {
                Navigation.pop();
              }
            }).paddingAll(11.r),
            backgroundColor: AppColors.whiteColor,
            elevation: 0,
            actions: [
              Obx(
                () => Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '$_currentStep',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                            color: AppColors.blackColor,
                          ),
                        ),
                        TextSpan(
                          text: "/${addVehicleQueController.getAllVehicleQueList.length} Steps",
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
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    _totalSegments,
                    (index) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: LinearProgressIndicator(
                          value: _getSegmentProgress(index),
                          backgroundColor: Colors.deepOrange.withOpacity(0.2),
                          color: Colors.deepOrange,
                          minHeight: 2.h,
                        ),
                      ),
                    ),
                  ),
                ).paddingSymmetric(horizontal: 8.w, vertical: 16.h),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  return addVehicleQueController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.highlightedColor,
                          ),
                        )
                      : addVehicleQueController.getAllVehicleQueList.isNotEmpty
                          ? PageView(
                              controller: _pageController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: List.generate(_totalSegments, (index) {
                                int startFormIndex = index * _totalFormsPerSegment;
                                int endFormIndex = startFormIndex + _totalFormsPerSegment;
                                endFormIndex = endFormIndex > addVehicleQueController.getAllVehicleQueList.length
                                    ? addVehicleQueController.getAllVehicleQueList.length
                                    : endFormIndex;
                                List<QueData> segmentForms = addVehicleQueController.getAllVehicleQueList.sublist(startFormIndex, endFormIndex);

                                log("startFormIndex :$startFormIndex");
                                log("endFormIndex :$endFormIndex");
                                log("segmentForms :$segmentForms");

                                return BuildFormView(
                                  formStepData: segmentForms[_currentFormIndex % _totalFormsPerSegment],
                                  // addVehicleQueController
                                  //     .getAllVehicleQueList[_currentFormIndex % _totalFormsPerSegment]

                                  // formStepsList[_currentFormIndex],
                                );
                              }),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                color: AppColors.highlightedColor,
                              ),
                            );
                  //const Text("No questions available");
                }),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
          floatingActionButton: CustomButton(
            onTap: () async {
              log(Get.arguments.toString());
              {
                if (_currentFormIndex < _totalFormsPerSegment - 1 || _currentSegment < _totalSegments - 1) {
                  _updateProgress(1);
                } else {
                  widget.screenName == "Edit Screen"
                      ? await addVehicleQueController.EditForm(vehicleId: Get.arguments)
                      : await addVehicleQueController.submitForm(vehicleId: Get.arguments);

                  log("response :${addVehicleQueController.questionAnswerPair.toJson()}");
                }
              }
            },
            //isDisabled: addVehicleQueController.checkFormFilledUp(),
            height: 52.h,
            width: 113.w,
            endSvgHeight: 16.h,
            fontSize: 15.h,
            endSvg: IconAsset.forwardArrow,
            text: _currentFormIndex < _totalFormsPerSegment - 1 || _currentSegment < _totalSegments - 1 ? AppString.next : AppString.finish,
            borderRadius: BorderRadius.circular(46.r),
          ).paddingOnly(bottom: 25.h),
        ),
      ),
    );
  }
}

class BuildFormView extends StatefulWidget {
  final QueData formStepData;

  BuildFormView({
    super.key,
    required this.formStepData,
  });

  @override
  State<BuildFormView> createState() => _BuildFormViewState();
}

class _BuildFormViewState extends State<BuildFormView> {
  final AddVehicleInformationController addVehicleQueController = Get.find();

  bool getCheckboxValue(String questionKey, String answer) {
    int existingIndex = addVehicleQueController.questionAnswerPair.indexWhere((element) => element['question'] == questionKey);
    return addVehicleQueController.questionAnswerPair[existingIndex]['answer'] == answer;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.formStepData.question}",
          style: TextStyle(fontSize: 24.sp, height: 1.35.h, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.only(top: 24.h),
            itemCount: widget.formStepData.answers?.length ?? 0,
            itemBuilder: (context, index) {
              String answer = widget.formStepData.answers?[index] ?? '';
              final isSelected = getCheckboxValue("${widget.formStepData.key}", answer);
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
                  answer,
                  style: TextStyle(
                    fontSize: 16.sp,
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
                value: isSelected,
                onChanged: (bool? selected) {
                  log("isSelected ::${isSelected}");
                  log("Checkbox toggled: ${selected.toString()}");
                  setState(() {});

                  if (selected == true) {
                    addVehicleQueController.updateSelectedAnswers(
                      question: '${widget.formStepData.key}',
                      answer: answer,
                    );
                    addVehicleQueController.checkFormFilledUp(answer: answer);
                  } else {
                    addVehicleQueController.updateSelectedAnswers(
                      question: '${widget.formStepData.key}',
                      answer: '',
                    );
                    addVehicleQueController.checkFormFilledUp(answer: answer);
                  }
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 15.h,
                thickness: 0.5.h,
                color: AppColors.borderColor,
              );
            },
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 16.w);
  }
}

/*
class DynamicForm extends StatefulWidget {
  final FormStepData formStepData;
  final List<String> initialResponses;
  final void Function(List<String>) onValuesChanged;

  DynamicForm({
    required this.formStepData,
    required this.initialResponses,
    required this.onValuesChanged,
  });

  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  late List<String> _selectedOptions;

  @override
  void initState() {
    super.initState();
    _selectedOptions = List.from(widget.initialResponses);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.formStepData.question,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text(widget.formStepData.subtitle,
            style: TextStyle(fontSize: 16, color: Colors.grey)),
        SizedBox(height: 16),
        ...widget.formStepData.options.map((option) => CheckboxListTile(
              title: Text(option),
              value: _selectedOptions.contains(option),
              onChanged: (bool? selected) {
                setState(() {
                  if (selected == true) {
                    _selectedOptions.add(option);
                  } else {
                    _selectedOptions.remove(option);
                  }
                  widget.onValuesChanged(_selectedOptions);
                });
              },
            )),
      ],
    );
  }
}
*/

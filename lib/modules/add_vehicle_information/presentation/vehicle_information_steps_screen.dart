import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/widget/annotated_region.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_string.dart';
import '../../../utils/assets.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../../utils/navigation_utils/routes.dart';
import '../../../widget/custom_backarrow_widget.dart';
import '../../../widget/custom_button.dart';
import '../models/vehicle_information_step_model.dart';

int _currentSegment = 0;
int _currentFormIndex = 0;
const int _totalFormsPerSegment = 4;
const int _totalSegments = 3;

class VehicleInformationStepsScreen extends StatefulWidget {
  const VehicleInformationStepsScreen({super.key});

  @override
  State<VehicleInformationStepsScreen> createState() =>
      _VehicleInformationStepsScreenState();
}

class _VehicleInformationStepsScreenState
    extends State<VehicleInformationStepsScreen> {
  final PageController _pageController = PageController();


  int get _currentStep =>
      (_currentSegment * _totalFormsPerSegment) + _currentFormIndex + 1;

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
      } else if (_currentFormIndex < 0) {
        _currentFormIndex = _totalFormsPerSegment - 1;
        if (_currentSegment > 0) {
          _currentSegment--;
        }
      }

      // Navigate between segments when required
      _pageController.animateToPage(
        _currentSegment,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  double _getSegmentProgress(int segment) {
    if (segment == _currentSegment) {
      return (_currentFormIndex + 1) / _totalFormsPerSegment;
    }
    return segment < _currentSegment ? 1.0 : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomAnnotatedRegions(
        child: Scaffold(
          appBar: AppBar(
            leading: CustomBackArrowWidget(onTap: () {
              log("message");
              if (_currentFormIndex > 0 || _currentSegment > 0) {
                _updateProgress(-1);
              } else {
                Navigation.pop();
              }
              /* _currentFormIndex > 0 || _currentSegment > 0
                  ? _updateProgress(-1)
                  : Navigation.pop;*/
            }).paddingAll(11.r),
            backgroundColor: AppColors.whiteColor,
            elevation: 0,
            actions: [
              Center(
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
                        text: '/12 Steps',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: AppColors.grey60.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ).paddingSymmetric(horizontal: 16.h),
              )
            ],
          ),
          body: Column(
            children: [
              Row(
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
              const SizedBox(height: 16),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(_totalSegments, (index) {
                    log("_currentFormIndex -===$_currentFormIndex");
                    return BuildFormView(
                      formStepData: formStepsList[_currentFormIndex],

                    );
                  }),
                ),
              ),

              ///next and previous button coding
              /*  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: (_currentFormIndex > 0 || _currentSegment > 0)
                        ? () => _updateProgress(-1)
                        : null,
                    child: const Text("Previous"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentFormIndex < _totalFormsPerSegment - 1 ||
                          _currentSegment < _totalSegments - 1) {
                        _updateProgress(1);
                      } else {
                        Navigation.pushNamed(Routes.homeScreen);
                      }
                    },
                    */ /*  onPressed: (_currentFormIndex < _totalFormsPerSegment - 1 ||
                            _currentSegment < 2)
                        ? () => _updateProgress(1)
                        : null,*/ /*
                    child: Text("Next"),
                  ),
                ],
              ),*/
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
          floatingActionButton: CustomButton(
            onTap: () {
              {
                if (_currentFormIndex < _totalFormsPerSegment - 1 ||
                    _currentSegment < _totalSegments - 1) {
                  _updateProgress(1);
                } else {
                  Navigation.pushNamed(Routes.homeScreen);
                }
              }
            },
            height: 52.h,
            width: 113.w,
            endSvgHeight: 16.h,
            fontSize: 15.h,
            endSvg: IconAsset.forwardArrow,
            text: _currentFormIndex < _totalFormsPerSegment - 1 ||
                _currentSegment < _totalSegments - 1?AppString.next:"Finish",
            borderRadius: BorderRadius.circular(46),
          ).paddingOnly(bottom: 25.h),
        ),
      ),
    );

  }
}

class BuildFormView extends StatefulWidget {
  final FormStepData formStepData;

  const BuildFormView(
      {super.key,
      required this.formStepData,
      });

  @override
  State<BuildFormView> createState() => _BuildFormViewState();
}

class _BuildFormViewState extends State<BuildFormView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.formStepData.question,
          style: TextStyle(
              fontSize: 24.sp,
              height: 1.35.h,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor),
        ),
        SizedBox(height: 10.h),
        Text(
          widget.formStepData.subtitle,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.grey60,
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.only(top: 24.h),
            itemCount: widget.formStepData.optionsList.length,
            itemBuilder: (context, index) {
              return
                CheckboxListTile(
                  checkColor: AppColors.primaryColor,
                  side: BorderSide(color: AppColors.transparent),
                  checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.r),
                    side: BorderSide(color: AppColors.whiteColor, width: 0),
                  ),
                  visualDensity: VisualDensity.standard,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "${widget.formStepData.optionsList[index]["option"]}",
                    style: TextStyle(
                      fontSize: 16.sp,
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  // value: _selectedOptions.contains(option),
                  value: widget.formStepData.optionsList[index]["isSelected"],
                  onChanged: (bool? selected) {
                    setState(() {
                      widget.formStepData.optionsList[index]["isSelected"] =
                          selected;
                    });
                    /* setState(() {
                    if (selected == true) {
                   //   _selectedOptions.add(option);
                    } else {
                      _selectedOptions.remove(option);
                    }
                    widget.onValuesChanged(_selectedOptions);
                  });*/
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

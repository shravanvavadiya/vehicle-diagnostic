import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../utils/app_text.dart';
import '../utils/assets.dart';

class CustomDropDownField extends StatelessWidget {
  final bool readOnly;
  final List list;
  final String label;
  final String? fontFamily;
  final String selectedValue;
  final int maxLine;
  final Function(String?)? onChanged;
  final Function(String?)? onSaved;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int? maxLength;
  final double radius;
  final bool enabled;
  final bool isPassword;
  final FocusNode? focusNode;
  final String hintText;
  final TextAlign? textAlign;
  final Widget? prefix;
  final Widget? suffix;
  final Color fillColor;
  final VoidCallback? onTap;
  final Color? enableColor;
  final Color? focusedColor;
  final Color? cursorColor;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixWidget;
  final Widget? suffixWidget;

  const CustomDropDownField({
    super.key,
    this.onChanged,
    this.maxLine = 1,
    this.maxLength,
    this.radius = 20,
    required this.label,
    this.fillColor = Colors.white,
    this.isPassword = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    required this.hintText,
    this.textAlign,
    required this.list,
    this.validator,
    this.prefix,
    required this.selectedValue,
    this.suffix,
    this.onTap,
    this.enableColor,
    this.fontFamily,
    this.focusedColor,
    this.cursorColor,
    this.onSaved,
    this.contentPadding,
    this.prefixWidget,
    this.suffixWidget,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: label,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ).paddingOnly(bottom: 8.h),
        DropdownButtonFormField2<String>(
          customButton: Row(
            children: [
              AppText(
                text: selectedValue,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color:  AppColors.blackColor,
              ),
              const Spacer(),
              SvgPicture.asset(
                IconAsset.downArrow,
              ),
            ],
          ),
          isExpanded: true,
          decoration: InputDecoration(
            fillColor: AppColors.backgroundColor,
            filled: true,
            isCollapsed: true,
            contentPadding: EdgeInsets.fromLTRB(
              16.w,
              12.h,
              16.w,
              12.h,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(color: AppColors.backgroundColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(color: AppColors.backgroundColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(color: AppColors.redColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(
                color: AppColors.redColor,
                width: 0.2.w,
              ),
            ),
          ),
       /*   hint: Text(
            hintText,
            style: TextStyle(
              color: Colors.grey.withOpacity(0.6),
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              letterSpacing: 0.2,
            ),
          ),*/
          items: list
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 8.0),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                         /* color: vehicleDetailController.genderItems
                              .indexOf(item) ==
                              0
                              ? Colors.transparent
                              : AppColors.backgroundColor,*/
                          color: AppColors.backgroundColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: AppText(
                      text: item,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
              )
              .toList(),
          validator: validator,
          onChanged: onChanged,
          onSaved: onSaved,
          dropdownStyleData: DropdownStyleData(
            offset: Offset(0, -5.w),
            padding: EdgeInsets.zero,
            scrollPadding: EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
          ),
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.only(right: 20.w),
          ),
          /* iconStyleData: IconStyleData(
               icon: SvgPicture.asset(SvgIcons.arrowDown, color: AppColors.downArrowColor, height: 22.h),
                ),*/
        ),
      ],
    ).paddingOnly(bottom: 10.h);
  }
}

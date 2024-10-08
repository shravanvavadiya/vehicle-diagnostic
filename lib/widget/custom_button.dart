import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/widget/custom_loading_widget.dart';
import 'package:get/get.dart';

class CustomButton extends StatefulWidget {
  final double? height;
  final VoidCallback? onTap;
  final double? width;
  final double? svgPadding;
  final double fontSize;
  final double? endSvgHeight;
  final FontWeight fontWeight;
  final String? text;
  final String? svg;
  final String? endSvg;
  final Color? buttonColor;
  final Color? disableButtonColor;
  final Color? buttonBorderColor;
  final Color? textColor;
  final Color? disableTextColor;
  final bool needBorderColor;
  final bool isDisabled;
  final bool isLoader;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? borderWidth;

  const CustomButton(
      {super.key,
      this.height,
      this.width,
      this.text,
      this.svg,
      this.endSvg,
      this.buttonBorderColor,
      this.buttonColor,
      this.fontWeight = FontWeight.w600,

      this.fontSize = 16,
      this.textColor,
      this.onTap,
      this.endSvgHeight,
      this.padding,
      this.isDisabled = false,
      this.isLoader = false,
      this.disableButtonColor,
      this.disableTextColor,
      this.needBorderColor = true,
      this.borderRadius,
      this.borderWidth,
      this.svgPadding});

  @override
  CustomButtonState createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final buttonColor = (widget.isDisabled)
        ? widget.disableButtonColor ?? AppColors.disableButtonColor
        : widget.buttonColor ??  AppColors.primaryColor;
    return GestureDetector(
      onTap: (widget.isLoader || widget.isDisabled) ? null : widget.onTap,
      child: Container(
        height: widget.height,
        width: widget.width,
        padding: widget.padding ?? EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(8.r),
          color: widget.isDisabled
              ? AppColors.primaryColor.withOpacity(0.5)
              : buttonColor,
          border: Border.all(
              color: widget.isDisabled?AppColors.transparent:(widget.buttonBorderColor != null)
                  ? widget.buttonBorderColor!
                  : buttonColor,
              width: widget.isDisabled?0:widget.borderWidth ?? 0.3
              // color: (widget.needBorderColor) ? buttonColor : Colors.transparent,
              ),
        ),
        child: Center(
          child: widget.isLoader
              ? CustomLoadingWidget(
                  color: Colors.white,
                  size: 3.h,
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.svg != null)
                      SvgPicture.asset(
                        widget.svg!,
                        height: 20.h,
                      ).paddingOnly(right: widget.svgPadding ?? 8.w),
                    Text(
                      widget.text.toString(),
                      style: TextStyle(
                        fontSize: widget.fontSize,
                        fontWeight: widget.fontWeight,
                        color: (widget.isDisabled)
                            ? widget.disableTextColor ??
                                AppColors.textColor.withOpacity(0.6)
                            : widget.textColor ?? Colors.white,
                      ),
                    ),
                    if (widget.endSvg != null)
                      SvgPicture.asset(
                        widget.endSvg!,
                        height: widget.endSvgHeight ?? 20.h,
                      ).paddingOnly(left: 14.w),
                  ],
                ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/widget/custom_loading_widget.dart';

class CustomButton extends StatefulWidget {
  final double? height;
  final VoidCallback? onTap;
  final double? width;
  final double fontSize;
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

  const CustomButton({
    Key? key,
    this.height,
    this.width,
    this.text,
    this.svg,
    this.endSvg,
    this.buttonBorderColor,
    this.buttonColor,
    this.fontWeight = FontWeight.w600,
    this.fontSize = 18,
    this.textColor,
    this.onTap,
    this.padding,
    this.isDisabled = false,
    this.isLoader = false,
    this.disableButtonColor,
    this.disableTextColor,
    this.needBorderColor = true,
    this.borderRadius,
  }) : super(key: key);

  @override
  CustomButtonState createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final buttonButton = (widget.isDisabled)
        ? widget.disableButtonColor ?? AppColors.disableButtonColor
        : widget.buttonColor ?? AppColors.appThemeColor;
    return GestureDetector(
      onTap: (widget.isLoader || widget.isDisabled) ? null : widget.onTap,
      child: Container(
        height: widget.height,
        width: widget.width,
        padding: widget.padding ?? const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
          color: buttonButton,
          border: Border.all(
            color: (widget.needBorderColor) ? buttonButton : Colors.transparent,
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (widget.svg != null)
                      Row(
                        children: [
                          SvgPicture.asset(
                            widget.svg!,
                            color: (widget.isDisabled)
                                ? widget.disableTextColor ?? AppColors.textColor.withOpacity(0.6)
                                : widget.textColor ?? Colors.white,
                            height: 24,
                          ),
                         3.h.horizontalSpace,
                        ],
                      ),
                    Text(
                      widget.text.toString(),
                      style: TextStyle(
                        fontSize: widget.fontSize,
                        fontWeight: widget.fontWeight,
                        color: (widget.isDisabled)
                            ? widget.disableTextColor ?? AppColors.textColor.withOpacity(0.6)
                            : widget.textColor ?? Colors.white,
                      ),
                    ),
                    if (widget.endSvg != null)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          3.w.horizontalSpace,
                          SvgPicture.asset(
                            widget.endSvg!,
                            color: (widget.isDisabled)
                                ? widget.disableTextColor ?? AppColors.textColor.withOpacity(0.6)
                                : widget.textColor ?? Colors.white,
                            height: 20,
                          ),
                        ],
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}

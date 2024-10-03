import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final bool readOnly;
  final TextEditingController controller;
  final int maxLine;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final int? maxLength;
  final double? radius;
  final bool enabled;
  final bool isPassword;
  final FocusNode? focusNode;
  final String? hintText;
  final TextAlign? textAlign;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final Widget? suffix;
  final Color fillColor;
  final VoidCallback? onTap;
  final Color? enableColor;
  final TextCapitalization? textCapitalization;
  final Color? focusedColor;
  final Color? cursorColor;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixWidget;
  final Widget? suffixWidget;

  CustomTextField({
    super.key,
    this.onChanged,
    this.maxLine = 1,
    this.maxLength,
    this.radius,
    this.fillColor = Colors.white,
    this.isPassword = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.hintText,
    this.textAlign,
    this.validator,
    this.prefix,
    this.suffix,
    this.onTap,
    this.textCapitalization,
    this.enableColor,
    this.focusedColor,
    this.cursorColor,
    required this.controller,
    this.contentPadding,
    this.prefixWidget,
    this.suffixWidget,
    this.readOnly = false,
  });

  final ValueNotifier<bool> _isObscure = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _isObscure,
        builder: (context, bool isObscure, _) {
          if (!isPassword) {
            isObscure = false;
          }
          return TextFormField(
            readOnly: readOnly,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: AppColors.primaryColor,
              letterSpacing: 0.5,
            ),
            onTap: onTap,

            obscureText: isObscure,
            obscuringCharacter: '*',
            onChanged: onChanged,
            controller: controller,
            maxLines: maxLine,
            maxLength: maxLength,
            keyboardType: keyboardType,
            validator: validator,
            textCapitalization: textCapitalization??TextCapitalization.none,
            focusNode: focusNode,
            cursorColor: cursorColor,
            textAlign: textAlign ?? TextAlign.start,
            enabled: enabled,

            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              prefix: prefixWidget,
              suffix: suffixWidget,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              isDense: true,
              prefixIcon: prefix,
              suffixIcon: suffix == null && isPassword
                  ? IconButton(
                      icon: Icon(
                        isObscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _isObscure.value = !isObscure;
                      },
                    )
                  : suffix,
              counterText: "",
              // contentPadding: const EdgeInsets.all(12),
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.blackColor.withOpacity(0.4),
                fontWeight: FontWeight.w400,
                fontSize: 15.sp,
                letterSpacing: 0.5,
              ),
              filled: true,
              fillColor: AppColors.backgroundColor,
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius ?? 4.r)),
                borderSide: BorderSide(color: AppColors.backgroundColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius ?? 4.r)),
                borderSide:
                    BorderSide(color: enableColor ?? AppColors.backgroundColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius ?? 4.r)),
                borderSide: BorderSide(
                    color: focusedColor ?? AppColors.backgroundColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(radius ?? 4.r),
                ),
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 1.w,
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(width:1.2, color: Colors.red),
              ),
            ),
          );
        });
  }
}

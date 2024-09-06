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

  CustomTextField({
    Key? key,
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
    this.prefix,
    this.suffix,
    this.onTap,
    this.enableColor,
    this.focusedColor,
    this.cursorColor,
    required this.controller,
    this.contentPadding,
    this.prefixWidget,
    this.suffixWidget,
    this.readOnly = false,
  }) : super(key: key);

  final ValueNotifier<bool> _isObscure = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(radius ?? 8),
      child: ValueListenableBuilder(
          valueListenable: _isObscure,
          builder: (context, bool isObscure, _) {
            if (!isPassword) {
              isObscure = false;
            }
            return IntrinsicHeight(
              child: TextFormField(
                readOnly: readOnly,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                  color: AppColors.textColor,
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
                focusNode: focusNode,
                cursorColor: cursorColor,
                textAlign: textAlign ?? TextAlign.start,
                enabled: enabled,
                decoration: InputDecoration(
                  prefix: prefixWidget,
                  suffix: suffixWidget,
                  contentPadding: contentPadding,
                  isDense: true,
                  prefixIcon: prefix,
                  suffixIcon: suffix == null && isPassword
                      ? IconButton(
                          icon: Icon(
                            isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
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
                    color: AppColors.textColor.withAlpha(60),
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                    letterSpacing: 0.5,
                  ),
                  filled: true,
                  fillColor: fillColor,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
                    borderSide: BorderSide(color: enableColor ?? Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
                    borderSide: BorderSide(color: focusedColor ?? Colors.grey.shade300),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

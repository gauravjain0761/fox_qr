import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextFormField extends StatefulWidget {
  final String name;

  final TextStyle? style;
  final String? labelText;
  final String? hintText;
  final TextStyle? hintStyle;
  final VoidCallback? onTap;
  final TextInputType? textInputType;
  final bool? alignLabelWithHint;
  final int? minLines;
  final bool? obscuretext;
  final Widget? suffixIcon;
  final bool? readOnly;
  final Color? fillColor;
  final int? maxLength;
  final int? maxLines;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? initialValue;
  final bool enabled;

  const AppTextFormField({
    Key? key,
    required this.name,
    this.style,
    this.obscuretext,
    this.suffixIcon,
    this.onTap,
    this.labelText,
    this.fillColor,
    this.hintText,
    this.readOnly = false,
    this.textInputType,
    this.hintStyle,
    this.alignLabelWithHint,
    this.minLines,
    this.maxLines,
    this.validator,
    this.inputFormatters,
    this.controller,
    this.initialValue,
    this.maxLength,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  final formatters = <TextInputFormatter>[];
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    if (widget.inputFormatters?.isEmpty ?? true) {
      formatters.add(FilteringTextInputFormatter.allow(allowAll));
    } else {
      formatters.addAll(widget.inputFormatters!.toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      keyboardType: widget.textInputType,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      initialValue: widget.initialValue,
      enabled: widget.enabled,
      controller: widget.controller,
      readOnly: widget.readOnly!,
      obscureText: widget.obscuretext ?? false,
      textAlign: TextAlign.center,
      onTap: widget.onTap,
      style: widget.enabled
          ? (widget.style ??
              GoogleFonts.montserrat(
                fontSize: 15.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ))
          : AppText.text16w600OffWhite,
      cursorColor: AppColors.black,
      decoration: InputDecoration(
        fillColor: widget.fillColor ?? Colors.transparent,
        filled: true,
        counterText: "",
        contentPadding: EdgeInsets.symmetric(vertical: 10.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.r),
          borderSide: BorderSide(
            color: AppColors.greyColor.withOpacity(0.12),
            width: 1.r,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.r),
          borderSide: BorderSide(
            color: AppColors.greyColor.withOpacity(0.12),
            width: 1.r,
          ),
        ),
        suffixIcon: widget.suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.r),
          borderSide: BorderSide(
            color: AppColors.greyColor.withOpacity(0.12),
            width: 1.r,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.r),
          borderSide: BorderSide(
            color: AppColors.greyColor.withOpacity(0.12),
            width: 1.r,
          ),
        ),
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            AppText.text15w400.copyWith(
              color: AppColors.black,
            ),
        alignLabelWithHint: widget.alignLabelWithHint,
      ),
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      validator: widget.validator,
    );
  }
}

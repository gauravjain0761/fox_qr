import 'package:flutter/material.dart';
import 'package:fox/shared/shared.dart';
import 'package:google_fonts/google_fonts.dart';

class ContinueButton extends StatelessWidget {
  final String buttontext;
  const ContinueButton({Key? key, required this.buttontext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 40.w,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 18.h,
      ),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(30.0),
      ),
      alignment: Alignment.center,
      child: Text(
        buttontext,
        style: GoogleFonts.montserrat(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}

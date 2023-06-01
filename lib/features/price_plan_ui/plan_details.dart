import 'package:flutter/material.dart';
import 'package:fox/shared/shared.dart';
import 'package:google_fonts/google_fonts.dart';

import 'plans.dart';

class PlanDetails extends StatelessWidget {
  final Plan movie;
  const PlanDetails(
    this.movie, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0,
      margin: EdgeInsets.fromLTRB(80, 300.h, 80, 310.h),
      decoration: BoxDecoration(
        border: Border.all(
            color: movie.id == 2 || movie.id == 3 ? Colors.white : Colors.black,
            width: 2),
        borderRadius: BorderRadius.circular(12),
        color: getbackroundcolor(),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          movie.name != ""
              ? Text(
                  movie.id == 1 ? "" : "Premium",
                  style: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    color: movie.id == 2 || movie.id == 3
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                )
              : SizedBox(),
          sizedBoxWithHeight(5),
          Text(
            movie.name,
            style: GoogleFonts.montserrat(
              fontSize: 23.0,
              color:
                  movie.id == 2 || movie.id == 3 ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color getbackroundcolor() {
    if (movie.id == 1) {
      return const Color(0xffFFFFFF);
    } else if (movie.id == 2) {
      return const Color(0xffFF14B5);
    } else if (movie.id == 3) {
      return const Color(0xff26A2C6);
    } else if (movie.id == 4) {
      return const Color(0xfffefe00);
    }
    return const Color(0xffFFFFFF);
  }
}

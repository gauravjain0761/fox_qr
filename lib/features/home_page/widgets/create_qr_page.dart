import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fox/shared/data/constants/colors.dart';
import 'package:fox/shared/ui/ui.dart';
import 'package:fox/shared/utils/utils.dart';
import 'package:fox/themes/app_text.dart';

import '../../../shared/shared.dart';

class CreateQRPage extends StatefulWidget {
  final String qrtype;
  const CreateQRPage({
    super.key,
    required this.qrtype,
  });

  @override
  State<CreateQRPage> createState() => _CreateQRPageState();
}

class _CreateQRPageState extends State<CreateQRPage>
    with SingleTickerProviderStateMixin {
  List<bool> isSelected = [true, false, false];
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellowColor,
      appBar: AppHeader(
        leftWidget: AppImage(
          Images.arrowBackBlackFilled,
          height: 50.r,
          width: 50.r,
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1039.h,
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  color: AppColors.yellowColor,
                  child: Column(
                    children: [
                      Text(
                        "Website",
                        style: AppText.text24w700,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 36.w,
                          vertical: 36.h,
                        ),
                        child: AppTextFormField(
                          name: "website",
                          hintText: "Enter url here",
                          hintStyle: AppText.text15w400.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: AppColors.scaffoldColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 36.w,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedBoxWithHeight(20),
                            Text(
                              "QR Image Size",
                              style: AppText.text15w500black,
                            ),
                            sizedBoxWithHeight(30),
                            ToggleButtons(
                              borderColor: Colors.transparent,
                              isSelected: isSelected,
                              selectedBorderColor: Colors.transparent,
                              onPressed: (int index) {
                                setState(() {
                                  for (int i = 0; i < isSelected.length; i++) {
                                    isSelected[i] = i == index;
                                  }
                                });
                              },
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.black,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.r),
                                      bottomLeft: Radius.circular(10.r),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(
                                    top: 10.h,
                                    bottom: 11.h,
                                    left: 21.w,
                                    right: 21.w,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Small",
                                        style: AppText.text12w400,
                                      ),
                                      Text(
                                        "Best for screens",
                                        style: AppText.text8w400,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: AppColors.black,
                                      ),
                                      bottom: BorderSide(
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(
                                    top: 10.h,
                                    bottom: 11.h,
                                    left: 26.w,
                                    right: 26.w,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Medium",
                                        style: AppText.text12w400,
                                      ),
                                      Text(
                                        "Best for print",
                                        style: AppText.text8w400,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.black,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.r),
                                      bottomRight: Radius.circular(10.r),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(
                                    top: 10.h,
                                    bottom: 11.h,
                                    left: 29.w,
                                    right: 29.w,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Custom",
                                        style: AppText.text12w400,
                                      ),
                                      Text(
                                        "Enter Size",
                                        style: AppText.text8w400,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sizedBoxWithHeight(30),
                            Text(
                              "Custom",
                              style: AppText.text15w400,
                            ),
                            sizedBoxWithHeight(20),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 90.w,
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: AppTextFormField(
                                      name: "custom size",
                                      hintText: "0000",
                                      hintStyle: AppText.text15w400,
                                    ),
                                  ),
                                  sizedBoxWithWidth(11),
                                  Text(
                                    "px",
                                    style: AppText.text15w400.copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  sizedBoxWithWidth(21),
                                  Text(
                                    "By",
                                    style: AppText.text15w400.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  sizedBoxWithWidth(20),
                                  Text(
                                    "0000 px",
                                    style: AppText.text15w400.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            sizedBoxWithHeight(30),
                            Divider(
                              thickness: 0.8,
                              color: AppColors.textcolor,
                            ),
                            sizedBoxWithHeight(30),
                            Container(
                              height: 241.h,
                              width: 241.w,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(
                                  10.r,
                                ),
                              ),
                              child: DottedBorder(
                                strokeWidth: 3, //thickness of dash/dots
                                dashPattern: const [10, 10],
                                color: AppColors.bordercolor,
                                child: Center(
                                    child: Text(
                                  "No Image",
                                  style: AppText.text17w600,
                                )),
                              ),
                            ),
                            sizedBoxWithHeight(33),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 20.h,
                                horizontal: 35.w,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(
                                  30.r,
                                ),
                              ),
                              child: Text(
                                "Choose Image",
                                style: AppText.text17w600.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            sizedBoxWithHeight(14),
                            Text(
                              "Maximum size 5 MB",
                              style: AppText.text10w400,
                            ),
                            sizedBoxWithHeight(39),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 16.w,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.blueTickColor.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(
                                  25.0,
                                ),
                              ),
                              child: TabBar(
                                controller: _tabController,
                                // give the indicator a decoration (color and border radius)
                                indicator: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.black,
                                    width: 2.w,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    25.0,
                                  ),
                                  color: Colors.white,
                                ),

                                labelStyle: AppText.text17w600,
                                labelColor: AppColors.black,
                                unselectedLabelColor:
                                    AppColors.black.withOpacity(0.5),
                                tabs: const [
                                  Tab(
                                    text: 'Half-Tone',
                                  ),
                                  Tab(
                                    text: 'Full Colour',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Expanded(
                      //   child: TabBarView(
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     controller: _tabController,
                      //     children: [
                      //       // first tab bar view widget
                      //       Container(
                      //         height: 50.h,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(10.r),
                      //           color: AppColors.yellowColor,
                      //         ),
                      //         padding: EdgeInsets.symmetric(
                      //           horizontal: 24.w,
                      //           // vertical: 20.h,
                      //         ),
                      //         margin: EdgeInsets.symmetric(
                      //           horizontal: 36.w,
                      //         ),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text(
                      //               "Colour",
                      //               style: AppText.text17w600.copyWith(
                      //                 color: AppColors.black,
                      //               ),
                      //             ),
                      //             Icon(
                      //               Icons.add,
                      //               color: AppColors.black,
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //       // second tab bar view widget
                      //       sizedBoxWithHeight(0),
                      //     ],
                      //   ),
                      // ),
                      sizedBoxWithHeight(30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppImage(
                            "assets/images/premium.svg",
                          ),
                          sizedBoxWithWidth(10),
                          Text(
                            "Get Premium And Track Analytics!",
                            style: AppText.text15w500black.copyWith(
                              color: AppColors.black.withOpacity(0.4),
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                      sizedBoxWithHeight(30),
                      Divider(
                        thickness: 0.8,
                        color: AppColors.textcolor,
                      ),
                      sizedBoxWithHeight(30),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 36.w,
                        ),
                        padding: EdgeInsets.symmetric(
                              vertical: 18.h,
                            ) +
                            EdgeInsets.only(
                              left: 119.w,
                              right: 20.w,
                            ),
                        decoration: BoxDecoration(
                            color: AppColors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(
                              30.r,
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Submit",
                              style: AppText.text20w600White,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: AppColors.white,
                            )
                          ],
                        ),
                      ),
                      sizedBoxWithHeight(10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

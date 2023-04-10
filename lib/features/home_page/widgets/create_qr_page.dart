import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<bool> isSelected = [true, false, false];
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  bool hidenetwork = true;
  String securityType = "None";
  int selectedbutton = 0;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                AppHeader(
                  color: AppColors.yellowColor,
                  leftWidget: AppImage(
                    Images.arrowBackBlackFilled,
                    height: 50.r,
                    width: 50.r,
                  ),
                ),
                Column(
                  children: [
                    _renderQrContainer(),
                    Column(
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
                              _qrTabButtons(),
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
                              ),
                            ],
                          ),
                        ),
                        ColorPicker(
                          enableAlpha: true,
                          hexInputBar: false,
                          portraitOnly: false,
                          displayThumbColor: true,
                          labelTypes: [],

                          pickerColor: Colors.red, //default color
                          onColorChanged: (Color color) {
                            //on color picked
                            print(color);
                          },
                        ),
                        // SizedBox(
                        //   height: 400.h,
                        //   child: GoogleMap(
                        //     onMapCreated: _onMapCreated,
                        //     initialCameraPosition: CameraPosition(
                        //       target: _center,
                        //       zoom: 11.0,
                        //     ),
                        //   ),
                        // ),
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
                              _qrDisplayImage(),
                              sizedBoxWithHeight(33),
                              _qrChooseImage(),
                              sizedBoxWithHeight(14),
                              Text(
                                "Maximum size 5 MB",
                                style: AppText.text10w400,
                              ),
                              sizedBoxWithHeight(39),
                              _qrTabBar(),
                            ],
                          ),
                        ),
                        // TabBarView(
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   controller: _tabController,
                        //   children: [
                        //     // first tab bar view widget
                        //     Container(
                        //       height: 50.h,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10.r),
                        //         color: AppColors.yellowColor,
                        //       ),
                        //       padding: EdgeInsets.symmetric(
                        //         horizontal: 24.w,
                        //         // vertical: 20.h,
                        //       ),
                        //       margin: EdgeInsets.symmetric(
                        //         horizontal: 36.w,
                        //       ),
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text(
                        //             "Colour",
                        //             style: AppText.text17w600.copyWith(
                        //               color: AppColors.black,
                        //             ),
                        //           ),
                        //           Icon(
                        //             Icons.add,
                        //             color: AppColors.black,
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //     // second tab bar view widget
                        //     sizedBoxWithHeight(0),
                        //   ],
                        // ),
                        sizedBoxWithHeight(30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AppImage(
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
                        _qrSubmit(),
                        sizedBoxWithHeight(10),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _qrSubmit() {
    return Container(
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
    );
  }

  Widget _qrTabBar() {
    return Container(
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
        unselectedLabelColor: AppColors.black.withOpacity(0.5),
        tabs: const [
          Tab(
            text: 'Half-Tone',
          ),
          Tab(
            text: 'Full Colour',
          ),
        ],
      ),
    );
  }

  Widget _qrChooseImage() {
    return Container(
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
    );
  }

  Widget _qrDisplayImage() {
    return Container(
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
    );
  }

  Widget _qrTabButtons() {
    return ToggleButtons(
      borderColor: Colors.transparent,
      isSelected: isSelected,
      selectedBorderColor: Colors.transparent,
      selectedColor: AppColors.yellowColor,
      //  fillColor: AppColors.yellowColor,

      onPressed: (int index) {
        setState(() {
          selectedbutton = index;
        });
      },
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.black,
            ),
            color: selectedbutton == 0
                ? AppColors.yellowColor
                : Colors.transparent,
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
          child: _renderQrSize(
            title: "Small",
            subtitle: "Best for screens",
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: selectedbutton == 1
                ? AppColors.yellowColor
                : Colors.transparent,
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
          child: _renderQrSize(
            title: "Medium",
            subtitle: "Best for print",
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: selectedbutton == 2
                ? AppColors.yellowColor
                : Colors.transparent,
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
          child: _renderQrSize(
            title: "Custom",
            subtitle: "Enter Size",
          ),
        ),
      ],
    );
  }

  Widget _renderQrSize({
    required String title,
    required String subtitle,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: AppText.text12w400,
        ),
        Text(
          subtitle,
          style: AppText.text8w400,
        )
      ],
    );
  }

  Widget _renderQrContainer() {
    return Container(
      color: AppColors.yellowColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 36.w,
        ),
        child: _renderQrTypes(),
      ),
    );
  }

  Widget _renderQrTypes() {
    if (widget.qrtype == "Website") {
      return Column(
        children: [
          Text(
            "Website",
            style: AppText.text24w700,
          ),
          sizedBoxWithHeight(36),
          const AppTextFormField(
            name: "website",
            hintText: "Enter url here",
          ),
          sizedBoxWithHeight(36),
        ],
      );
    } else if (widget.qrtype == "Email") {
      return Column(
        children: [
          Text(
            "Email",
            style: AppText.text24w700,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 36.h,
            ),
            child: const AppTextFormField(
              name: "email",
              hintText: "email@address.foxtrot",
            ),
          ),
          sizedBoxWithHeight(20),
          const AppTextFormField(
            name: "subject",
            hintText: "Subject",
          ),
          sizedBoxWithHeight(20),
          const AppTextFormField(
            name: "message",
            maxLines: 6,
            hintText: "Message",
          ),
          sizedBoxWithHeight(41),
        ],
      );
    } else if (widget.qrtype == "Whatsapp") {
      return Column(
        children: [
          Text(
            "WhatsApp",
            style: AppText.text24w700,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 36.h,
            ),
            child: const AppTextFormField(
              name: "whatsapp",
              hintText: "+27 082 345 6789",
            ),
          ),
          sizedBoxWithHeight(36),
        ],
      );
    } else if (widget.qrtype == "Location") {
      return Column(
        children: [
          Text(
            "Location",
            style: AppText.text24w700,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 36.h,
            ),
            child: const AppTextFormField(
              name: "Longitude",
              hintText: "Longitude",
            ),
          ),
          sizedBoxWithHeight(20),
          const AppTextFormField(
            name: "Latitude",
            hintText: "Latitude",
          ),
          sizedBoxWithHeight(36),
        ],
      );
    } else if (widget.qrtype == "Social Media") {
      return Column(
        children: [
          Text(
            "Social Media",
            style: AppText.text24w700,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 36.h,
            ),
            child: const AppTextFormField(
              name: "profilelink",
              hintText: "IG Profile Link",
            ),
          ),
          sizedBoxWithHeight(36),
        ],
      );
    } else if (widget.qrtype == "Wi-Fi") {
      return Column(
        children: [
          Text(
            "WiFi",
            style: AppText.text24w700,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 36.h,
            ),
            child: const AppTextFormField(
              name: "network",
              hintText: "Network Name (SSID)",
            ),
          ),
          sizedBoxWithHeight(29),
          Row(
            children: [
              Text(
                "Hidden Network",
                style: AppText.text17w600.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  setState(() {
                    hidenetwork = !hidenetwork;
                  });
                },
                child: Container(
                  height: 25.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(
                      7.r,
                    ),
                    border: Border.all(
                      color: AppColors.black,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: hidenetwork
                        ? Icon(
                            Icons.check,
                            size: 20.h,
                            color: AppColors.white,
                          )
                        : SizedBox(),
                  ),
                ),
              ),
            ],
          ),
          sizedBoxWithHeight(30),
          const AppTextFormField(
            name: "password",
            hintText: "Password",
          ),
          sizedBoxWithHeight(20),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
              border: Border.all(
                color: AppColors.greyColor.withOpacity(0.12),
                width: 1.r,
              ),
            ),
            child: Center(
              child: DropdownButton<String>(
                value: securityType,
                hint: Text(
                  "Security Type",
                  style: AppText.text15w400.copyWith(
                    color: AppColors.black,
                  ),
                ),
                icon: Padding(
                  padding: EdgeInsets.only(
                    right: 8.w,
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 30.h,
                    color: AppColors.black,
                  ),
                ),
                isExpanded: true,
                dropdownColor: AppColors.white,
                underline: const SizedBox(),
                items: ['None', 'WPA2', 'WPA3'].map((String items) {
                  return DropdownMenuItem(
                    alignment: Alignment.center,
                    value: items,
                    child: Center(
                      child: Text(
                        items,
                        style: AppText.text15w400.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    securityType = newValue!;
                  });
                },
              ),
            ),
          ),
          sizedBoxWithHeight(36),
        ],
      );
    } else if (widget.qrtype == "Event") {
      return Column(
        children: [
          Text(
            "Event",
            style: AppText.text24w700,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 36.h,
            ),
            child: const AppTextFormField(
              name: "title",
              hintText: "Event Title",
            ),
          ),
          sizedBoxWithHeight(20),
          const AppTextFormField(
            name: "eventLocation",
            hintText: "Event Location",
          ),
          sizedBoxWithHeight(20),
          Row(
            children: [
              const Expanded(
                child: AppTextFormField(
                  name: "startTime",
                  hintText: "Start Time",
                ),
              ),
              sizedBoxWithWidth(10),
              const Expanded(
                child: AppTextFormField(
                  name: "endTime",
                  hintText: "End Time",
                ),
              ),
            ],
          ),
          sizedBoxWithHeight(36),
        ],
      );
    } else if (widget.qrtype == "Virtual Card") {
      return Column(
        children: [
          Text(
            "Virtual Card",
            style: AppText.text24w700,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 36.h,
            ),
            child: const AppTextFormField(
              name: "firstname",
              hintText: "First Name",
            ),
          ),
          sizedBoxWithHeight(20),
          const AppTextFormField(
            name: "lastname",
            hintText: "Last Name",
          ),
          sizedBoxWithHeight(20),
          const AppTextFormField(
            name: "phone",
            hintText: "Phone",
          ),
          sizedBoxWithHeight(20),
          const AppTextFormField(
            name: "email",
            hintText: "Email",
          ),
          sizedBoxWithHeight(20),
          const AppTextFormField(
            name: "organization",
            hintText: "Organization",
          ),
          sizedBoxWithHeight(20),
          const AppTextFormField(
            name: "yourJob",
            hintText: "Your Job",
          ),
          sizedBoxWithHeight(50),
          const AppTextFormField(
            name: "street",
            hintText: "Street",
          ),
          sizedBoxWithHeight(20),
          const AppTextFormField(
            name: "city",
            hintText: "City",
          ),
          sizedBoxWithHeight(20),
          const AppTextFormField(
            name: "zip",
            hintText: "ZIP",
          ),
          sizedBoxWithHeight(20),
          const AppTextFormField(
            name: "state",
            hintText: "State/Province",
          ),
          sizedBoxWithHeight(20),
          const AppTextFormField(
            name: "country",
            hintText: "Country",
          ),
          sizedBoxWithHeight(20),
          const AppTextFormField(
            name: "web",
            hintText: "www.example.com",
          ),
          sizedBoxWithHeight(36),
        ],
      );
    }
    return const SizedBox();
  }
}

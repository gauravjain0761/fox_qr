import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fox/features/home_page/logic/home_controller.dart';
import 'package:fox/models/qr_types.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/shared/utils/color_picker.dart' as cp;
import 'package:fox/themes/app_text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'shrink_wrapping_tab_bar_view.dart';

class CreateQRPage extends StatefulWidget {
  final QrType qrtype;

  const CreateQRPage({
    super.key,
    required this.qrtype,
  });

  @override
  State<CreateQRPage> createState() => _CreateQRPageState();
}

class _CreateQRPageState extends State<CreateQRPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    mapController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final homecontroller = Provider.of<HomeController>(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.only(
                      top: 15.h,
                    ),
                    color: AppColors.yellowColor,
                    child: AppHeader(
                      color: AppColors.yellowColor,
                      leftWidget: InkWell(
                        onTap: () {
                          AppEnvironment.navigator.pop();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: 4.h,
                          ),
                          child: AppImage(
                            Images.arrowBackBlackFilled,
                            height: 35.r,
                            width: 35.r,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const ScrollPhysics(),
                    primary: false,
                    children: [
                      FormBuilder(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: _renderQrContainer(controller: homecontroller),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 33.w,
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
                            _qrTabButtons(controller: homecontroller),
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
                                      maxLength: 4,
                                      name: "custom size",
                                      hintText: "0000",
                                      controller:
                                          homecontroller.qrSizeController,
                                      textInputType: TextInputType.number,
                                      // inputFormatters: [
                                      //   LengthLimitingTextInputFormatter(4),
                                      // ],
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
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      sizedBoxWithHeight(30),
                      Visibility(
                        visible:
                            widget.qrtype.name == "Location" ? true : false,
                        child: SizedBox(
                          height: 400.h,
                          child: GoogleMap(
                            zoomGesturesEnabled: true,
                            zoomControlsEnabled: false,
                            gestureRecognizers: <
                                Factory<OneSequenceGestureRecognizer>>{
                              Factory<OneSequenceGestureRecognizer>(
                                () => EagerGestureRecognizer(),
                              ),
                            },
                            onMapCreated: _onMapCreated,
                            initialCameraPosition: CameraPosition(
                              target: _center,
                              zoom: 11.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Visibility(
                              visible: widget.qrtype.name == "Location"
                                  ? false
                                  : true,
                              child: Divider(
                                thickness: 0.8,
                                color: AppColors.textcolor,
                              ),
                            ),
                            sizedBoxWithHeight(30),
                            _qrDisplayImage(controller: homecontroller),
                            sizedBoxWithHeight(33),
                            _qrChooseImage(controller: homecontroller),
                            sizedBoxWithHeight(14),
                            Text(
                              "Maximum size 5 MB",
                              style: AppText.text10w400,
                            ),
                            sizedBoxWithHeight(39),
                            _qrTabBar(
                              controller: homecontroller,
                            ),
                          ],
                        ),
                      ),
                      ShrinkWrappingTabBarView(
                        tabController: _tabController,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: AppColors.yellowColor,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 15.h,
                              // vertical: 20.h,
                            ),
                            margin: EdgeInsets.symmetric(
                                  horizontal: 36.w,
                                ) +
                                EdgeInsets.only(
                                  top: 40.h,
                                ),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    homecontroller.chagecolorpickervisiblity();
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Colour",
                                        style: AppText.text17w600.copyWith(
                                          color: AppColors.black,
                                        ),
                                      ),
                                      Icon(
                                        Icons.add,
                                        color: AppColors.black,
                                      )
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: homecontroller.iscolorpickervisible,
                                  child: sizedBoxWithHeight(35),
                                ),
                                Visibility(
                                  visible: homecontroller.iscolorpickervisible,
                                  child: cp.ColorPicker(
                                    enableAlpha: false,
                                    pickerHsvColor:
                                        HSVColor.fromColor(Colors.white),

                                    portraitOnly: false,
                                    displayThumbColor: false,

                                    labelTypes: const [],
                                    //  paletteType: PaletteType.hueWheel,

                                    pickerColor: Colors.red, //default color
                                    onColorChanged: (Color color) {
                                      homecontroller.oncolorChange(
                                        color: color,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // second tab bar view widget
                          sizedBoxWithHeight(0),
                        ],
                      ),
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                        ),
                        child: Divider(
                          thickness: 0.8,
                          color: AppColors.textcolor,
                        ),
                      ),
                      sizedBoxWithHeight(30),
                      _qrSubmit(controller: homecontroller),
                      sizedBoxWithHeight(10),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _qrSubmit({required HomeController controller}) {
    return InkWell(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          controller.createqr(qrtype: widget.qrtype.id, context: context);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 36.w,
        ),
        padding: EdgeInsets.symmetric(
              vertical: 18.h,
            ) +
            EdgeInsets.only(
              left: 80.w,
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
              "Generate QR ",
              style: AppText.text20w600White,
            ),
            Icon(
              Icons.arrow_forward,
              color: AppColors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget _qrTabBar({required HomeController controller}) {
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
        onTap: (value) {
          controller.changecolortone(index: value);
        },
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

  Widget _qrChooseImage({required HomeController controller}) {
    return InkWell(
      onTap: () {
        controller.pickimagefromgallery(context: context);
      },
      child: Container(
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
    );
  }

  Widget _qrDisplayImage({required HomeController controller}) {
    return Container(
      height: 241.h,
      width: 241.w,
      padding: controller.imageFile == null
          ? const EdgeInsets.all(12)
          : const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          10.r,
        ),
      ),
      child: controller.imageFile == null
          ? DottedBorder(
              strokeWidth: 3, //thickness of dash/dots
              dashPattern: const [10, 10],
              color: AppColors.bordercolor,
              child: Center(
                  child: Text(
                "No Image",
                style: AppText.text17w600,
              )),
            )
          : Image.file(
              controller.imageFile!,
              fit: BoxFit.fill,
            ),
    );
  }

  Widget _qrTabButtons({required HomeController controller}) {
    return ToggleButtons(
      borderColor: Colors.transparent,
      isSelected: controller.isSelected,
      selectedBorderColor: Colors.transparent,
      selectedColor: AppColors.yellowColor,
      //  fillColor: AppColors.yellowColor,

      onPressed: (int index) {
        controller.changebuttonindex(index: index);
      },
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.black,
            ),
            color: controller.selectedbutton == 0
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
            color: controller.selectedbutton == 1
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
            color: controller.selectedbutton == 2
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
          style: AppText.text12w600,
        ),
        Text(
          subtitle,
          style: AppText.text8w400,
        )
      ],
    );
  }

  Widget _renderQrContainer({required HomeController controller}) {
    return Container(
      color: AppColors.yellowColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 36.w,
        ),
        child: _renderQrTypes(controller: controller),
      ),
    );
  }

  Widget _renderQrTypes({required HomeController controller}) {
    if (widget.qrtype.name == "Website") {
      return Column(
        children: [
          Text(
            "Website",
            style: AppText.text24w700,
          ),
          sizedBoxWithHeight(36),
          AppTextFormField(
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
                FormBuilderValidators.url(),
              ],
            ),
            name: "website",
            hintText: "Enter url here",
            controller: controller.emailController,
          ),
          sizedBoxWithHeight(36),
        ],
      );
    } else if (widget.qrtype.name == "Email") {
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
            child: AppTextFormField(
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ],
              ),
              name: "email",
              hintText: "email@address.foxtrot",
            ),
          ),
          sizedBoxWithHeight(20),
          AppTextFormField(
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
              ],
            ),
            name: "subject",
            hintText: "Subject",
          ),
          sizedBoxWithHeight(20),
          AppTextFormField(
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
              ],
            ),
            name: "message",
            maxLines: 6,
            hintText: "Message",
          ),
          sizedBoxWithHeight(41),
        ],
      );
    } else if (widget.qrtype.name == "Whatsapp") {
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
            child: AppTextFormField(
              name: "whatsapp",
              textInputType: TextInputType.phone,
              hintText: "+27 082 345 6789",
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(),
                ],
              ),
            ),
          ),
          sizedBoxWithHeight(36),
        ],
      );
    } else if (widget.qrtype.name == "Location") {
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
            child: AppTextFormField(
              textInputType: TextInputType.number,
              name: "Longitude",
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(),
                ],
              ),
              hintText: "Longitude",
            ),
          ),
          sizedBoxWithHeight(20),
          AppTextFormField(
            textInputType: TextInputType.number,
            name: "Latitude",
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
              ],
            ),
            hintText: "Latitude",
          ),
          sizedBoxWithHeight(36),
        ],
      );
    } else if (widget.qrtype.name == "Social Media") {
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
            child: AppTextFormField(
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(),
                ],
              ),
              name: "profilelink",
              hintText: "IG Profile Link",
            ),
          ),
          sizedBoxWithHeight(20),
          GridView.builder(
              shrinkWrap: true,
              itemCount: controller.icons.length,
              primary: false,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    controller.changeIconindex(index: index);
                  },
                  child: Container(
                    height: 69.h,
                    width: 69.w,
                    decoration: BoxDecoration(
                      color: index == controller.selectedicon
                          ? AppColors.black
                          : AppColors.yellowColor,
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        index == controller.selectedicon
                            ? const BoxShadow()
                            : BoxShadow(
                                color: AppColors.dropshadow,
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: const Offset(
                                  0,
                                  3,
                                ),
                              )
                      ],
                    ),
                    child: Center(
                      child: AppImage(
                        controller.icons.elementAt(
                          index,
                        ),
                        height: 38.h,
                        width: 38.w,
                        color: index == controller.selectedicon
                            ? AppColors.white
                            : AppColors.black,
                      ),
                    ),
                  ),
                );
              }),
          sizedBoxWithHeight(36),
        ],
      );
    } else if (widget.qrtype.name == "Wi-Fi") {
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
            child: AppTextFormField(
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(),
                ],
              ),
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
              const Spacer(),
              InkWell(
                onTap: () {
                  controller.showhidenetwork();
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
                    child: controller.hidenetwork
                        ? Icon(
                            Icons.check,
                            size: 20.h,
                            color: AppColors.white,
                          )
                        : const SizedBox(),
                  ),
                ),
              ),
            ],
          ),
          sizedBoxWithHeight(30),
          AppTextFormField(
            name: "password",
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
              ],
            ),
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
                value: controller.securityType,
                hint: Center(
                  child: Text(
                    "Security Type",
                    style: AppText.text15w400.copyWith(
                      color: AppColors.black,
                    ),
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
                  controller.assignSecuerityType(securityType: newValue!);
                },
              ),
            ),
          ),
          sizedBoxWithHeight(36),
        ],
      );
    } else if (widget.qrtype.name == "Event") {
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
            child: AppTextFormField(
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(),
                ],
              ),
              name: "title",
              hintText: "Event Title",
            ),
          ),
          sizedBoxWithHeight(20),
          AppTextFormField(
            name: "eventLocation",
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
              ],
            ),
            hintText: "Event Location",
          ),
          sizedBoxWithHeight(20),
          Row(
            children: [
              Expanded(
                child: AppTextFormField(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((selectedTime) {
                      if (selectedTime != null) {
                        controller.selectStartTime(timeOfDay: selectedTime);
                      }
                    });
                  },

                  controller: controller.startTimeController,
                  // enabled: false,
                  readOnly: true,
                  name: "startTime",
                  hintText: "Start Time",
                ),
              ),
              sizedBoxWithWidth(10),
              Expanded(
                child: AppTextFormField(
                  controller: controller.endTimeController,
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((selectedTime) {
                      if (selectedTime != null) {
                        controller.selectEndTime(timeOfDay: selectedTime);
                      }
                    });
                  },
                  readOnly: true,
                  name: "endTime",
                  hintText: "End Time",
                ),
              ),
            ],
          ),
          sizedBoxWithHeight(36),
        ],
      );
    } else if (widget.qrtype.name == "Virtual Card") {
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
            child: AppTextFormField(
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(),
                ],
              ),
              name: "firstname",
              hintText: "First Name",
            ),
          ),
          sizedBoxWithHeight(20),
          AppTextFormField(
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
              ],
            ),
            name: "lastname",
            hintText: "Last Name",
          ),
          sizedBoxWithHeight(20),
          AppTextFormField(
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
              ],
            ),
            textInputType: TextInputType.phone,
            name: "phone",
            hintText: "Phone",
          ),
          sizedBoxWithHeight(20),
          AppTextFormField(
            validator: FormBuilderValidators.compose(
              [FormBuilderValidators.required(), FormBuilderValidators.email()],
            ),
            textInputType: TextInputType.emailAddress,
            name: "email",
            hintText: "Email",
          ),
          sizedBoxWithHeight(20),
          AppTextFormField(
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
              ],
            ),
            name: "organization",
            hintText: "Organization",
          ),
          sizedBoxWithHeight(20),
          AppTextFormField(
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
              ],
            ),
            name: "yourJob",
            hintText: "Your Job",
          ),
          sizedBoxWithHeight(50),
          AppTextFormField(
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
              ],
            ),
            name: "street",
            hintText: "Street",
          ),
          sizedBoxWithHeight(20),
          AppTextFormField(
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
              ],
            ),
            name: "city",
            hintText: "City",
          ),
          sizedBoxWithHeight(20),
          AppTextFormField(
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
              ],
            ),
            textInputType: TextInputType.number,
            name: "zip",
            hintText: "ZIP",
          ),
          sizedBoxWithHeight(20),
          AppTextFormField(
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
              ],
            ),
            name: "state",
            hintText: "State/Province",
          ),
          sizedBoxWithHeight(20),
          AppTextFormField(
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
              ],
            ),
            name: "country",
            hintText: "Country",
          ),
          sizedBoxWithHeight(20),
          AppTextFormField(
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
                FormBuilderValidators.url(),
              ],
            ),
            textInputType: TextInputType.url,
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

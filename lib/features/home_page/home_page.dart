import 'package:flutter/material.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<QrTypes> qrtypes = [
    QrTypes(
      image: const Icon(
        Icons.link,
      ),
      title: "Website",
    ),
    QrTypes(
      image: const Icon(
        Icons.email_outlined,
      ),
      title: "Email",
    ),
    QrTypes(
      image: const Icon(
        Icons.phone_android_outlined,
      ),
      title: "Whatsapp",
    ),
    QrTypes(
      image: const Icon(
        Icons.location_on_outlined,
      ),
      title: "Location",
    ),
    QrTypes(
      image: const Icon(
        Icons.favorite_border,
      ),
      title: "Social Media",
    ),
    QrTypes(
      image: const Icon(
        Icons.wifi_sharp,
      ),
      title: "Wi-Fi",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const AppDrawer(),
      appBar: AppHeader(onDrawerTap: _handlerDrawer),
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: _renderBody(),
    );
  }

  void _handlerDrawer() {
    if (_scaffoldKey.currentState?.isEndDrawerOpen ?? false) {
      _scaffoldKey.currentState?.closeEndDrawer();
      return;
    }
    _scaffoldKey.currentState?.openEndDrawer();
  }

  Widget _renderBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        sizedBoxWithHeight(20),
        Text(
          'QR Type',
          style: AppText.text24w600.copyWith(color: AppColors.black),
        ),
        sizedBoxWithHeight(20),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: qrtypes.length,
            itemBuilder: (_, index) => _renderListItem(index: index),
          ),
        ),
      ],
    );
  }

  Widget _renderListItem({required int index}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
      decoration: BoxDecoration(
        color: AppColors.yellowColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.black, width: 2.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            qrtypes.elementAt(index).title,
            style: AppText.text24w600.copyWith(
              color: AppColors.black,
            ),
          ),
          CircleAvatar(
            radius: 24.r,
            backgroundColor: AppColors.black,
            child: qrtypes.elementAt(index).image,
          )
        ],
      ),
    );
  }
}

class QrTypes {
  final String title;
  final Icon image;
  QrTypes({
    required this.image,
    required this.title,
  });
}

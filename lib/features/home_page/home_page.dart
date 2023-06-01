import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fox/features/home_page/logic/home_controller.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/models/qr_types.dart' as qt;
import 'package:fox/themes/app_text.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Provider.of<HomeController>(context, listen: false)
        .getqrtypes(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: const AppDrawer(),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.h),
            child: AppHeader(onDrawerTap: _handlerDrawer)),
        backgroundColor: AppColors.appColor,
        resizeToAvoidBottomInset: false,
        body: _renderBody(),
      ),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        sizedBoxWithHeight(20),
        Center(
          child: Text(
            'QR Type',
            style: AppText.text24w700.copyWith(
              color: AppColors.black,
            ),
          ),
        ),
        sizedBoxWithHeight(40),
        Expanded(
          child: Consumer<HomeController>(builder: (context, c, _) {
            if (c.qrtypes == null) {
              Loader.show(context);
            } else if (c.qrtypes != null) {
              Loader.hide();
              return ListView.builder(
                shrinkWrap: true,
                itemCount: c.qrtypes!.qrTypes.length,
                itemBuilder: (_, index) => _renderListItem(
                  qrTypes: c.qrtypes!.qrTypes,
                  index: index,
                ),
              );
            }
            return const SizedBox();
          }),
        ),
      ],
    );
  }

  Widget _renderListItem(
      {required int index, required List<qt.QrType> qrTypes}) {
    return InkWell(
      onTap: () {
        _handleSend(
          qrtype: qrTypes.elementAt(index),
        );
      },
      child: Container(
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
              qrTypes.elementAt(index).name,
              style: AppText.text24w600.copyWith(
                color: AppColors.black,
              ),
            ),
            CircleAvatar(
              radius: 24.r,
              backgroundColor: AppColors.black,
              child: getqrImage(qrtype: qrTypes.elementAt(index).name),
            )
          ],
        ),
      ),
    );
  }

  void _handleSend({
    required qt.QrType qrtype,
  }) {
    AppEnvironment.navigator.pushNamed(
      GeneralRoutes.createqr,
      arguments: qrtype,
    );
  }

  Widget getqrImage({required String qrtype}) {
    if (qrtype == "Website") {
      return SvgPicture.asset(
        "assets/images/website.svg",
        color: AppColors.white,
      );
    } else if (qrtype == "Email") {
      return SvgPicture.asset(
        "assets/images/email.svg",
        color: AppColors.white,
      );
    } else if (qrtype == "Whatsapp") {
      return SvgPicture.asset(
        "assets/images/whatsapp.svg",
        color: AppColors.white,
      );
    } else if (qrtype == "Location") {
      return SvgPicture.asset(
        "assets/images/location.svg",
        color: AppColors.white,
      );
    } else if (qrtype == "Social Media") {
      return const Icon(
        Icons.favorite_border,
      );
    } else if (qrtype == "Wi-Fi") {
      return SvgPicture.asset(
        "assets/images/wi-fi.svg",
        color: AppColors.white,
      );
    } else if (qrtype == "Virtual Card") {
      return SvgPicture.asset(
        "assets/images/contact.svg",
        color: AppColors.white,
      );
    } else if (qrtype == "Event") {
      return SvgPicture.asset(
        "assets/images/event.svg",
        color: AppColors.white,
      );
    }
    return const SizedBox();
  }
}

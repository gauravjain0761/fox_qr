part of 'routes.dart';

class GeneralRoutes {
  /// leading string for general routes, this needs to be used when creating
  /// new route
  static const generalLeading = '/general-route';

  static const dummy = '$generalLeading/dummy';
  static const createqr = '$generalLeading/createqr';
  static const starterScreen = '$generalLeading/starter_screen';
  static const videoPlayer = '$generalLeading/video-player';
  static const search = '$generalLeading/search';
  static const appImageViewer = '$generalLeading/app-image-viewer';
  static const preferencesPage = '$generalLeading/preferences-page';
  static const privacyPolicy = '$generalLeading/privacy-policy';
  static const noInternet = '$generalLeading/no-internet';
  static const purshaseScreen = '$generalLeading/purchase-screen';
  static const homePageScreen = '$generalLeading/home-screen';
  static const pastQrScreen = '$generalLeading/past-qr-screen';
  static const imageEditor = '$generalLeading/image-editor';
  static const displayQRDetailsScreen =
      '$generalLeading/displat-details-screen';
  static const purchasenew = '$generalLeading/purchasenew';

  static final generalRoutes = <String>{
    dummy,
    starterScreen,
    videoPlayer,
    search,
    appImageViewer,
    preferencesPage,
    privacyPolicy,
    createqr,
    purchasenew,
  };

  static Widget getPage(String currentRoute, Object? args) {
    Widget child;
    switch (currentRoute) {
      case GeneralRoutes.starterScreen:
        child = const StarterScreen();
        break;
      case GeneralRoutes.dummy:
        child = const SizedBox();
        break;
      case GeneralRoutes.videoPlayer:
        if (CommonUtils.hasInvalidArgs<String>(args!)) {
          child = CommonUtils.misTypedArgsRoute<String>(args);
        } else {
          child = const SizedBox();
        }
        break;

      case GeneralRoutes.appImageViewer:
        if (CommonUtils.hasInvalidArgs<String>(args!)) {
          child = CommonUtils.misTypedArgsRoute<String>(args);
        } else {
          child = AppImageViewer(imageUrl: args as String);
        }
        break;

      case GeneralRoutes.preferencesPage:
        child = const SizedBox();
        break;

      case GeneralRoutes.purchasenew:
        child = const PurchaseNew();
        break;
      case GeneralRoutes.privacyPolicy:
        child = const SizedBox();
        break;
      case GeneralRoutes.noInternet:
        child = const NoInternet();
        break;
      case GeneralRoutes.purshaseScreen:
        child = const PurchaseScreen();
        break;
      case GeneralRoutes.homePageScreen:
        child = HomePage();
        break;
      case GeneralRoutes.pastQrScreen:
        child = const PastQrScreen();
        break;
      case GeneralRoutes.displayQRDetailsScreen:
        child = DisplayQRDetailsScreen(
          qrid: args as String,
        );
        break;
      case GeneralRoutes.createqr:
        child = CreateQRPage(
          qrtype: args as QrType,
        );
        break;
      case GeneralRoutes.imageEditor:
        if (CommonUtils.hasInvalidArgs<Uint8List>(args!)) {
          child = CommonUtils.misTypedArgsRoute<Uint8List>(args);
        } else {
          child = const SizedBox();
          // ImageEditor(
          //   appBar: AppColors.black,
          //   allowCamera: true,
          //   allowGallery: true,
          //   image: args as Uint8List,
          // );
        }
        break;
      default:
        child = const PageNotFound();
    }
    return child;
  }
}

import 'package:fox/shared/shared.dart';

const splashAnim = Duration(seconds: 1);
const animDuration = Duration(milliseconds: 250);
const debounceDuration = Duration(milliseconds: 400);
const staggeredAnimDuration = Duration(milliseconds: 375);

final drawerItems = <DrawerItem>[
  const DrawerItem(
    icon: Images.planImage,
    text: 'Plans & Prices',
    type: DrawerItemType.PLANS_AND_PRICES,
  ),
  const DrawerItem(
    icon: Images.photoLibraryImage,
    text: 'Past QR Codes',
    type: DrawerItemType.PAST_QR_CODES,
  ),
  const DrawerItem(
    icon: Images.termsImage,
    text: 'Terms Of Use',
    type: DrawerItemType.TERMS_OF_USE,
  ),
  const DrawerItem(
    icon: Images.privacyImage,
    text: 'Privacy Policy',
    type: DrawerItemType.PRIVACY_POLICY,
  ),
  const DrawerItem(
    icon: Images.contactImage,
    text: 'Contact Support',
    type: DrawerItemType.CONTACT_US,
  ),
];

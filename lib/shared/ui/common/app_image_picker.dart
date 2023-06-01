// import 'dart:io';
// import 'dart:typed_data';

// import 'package:fox/routes/routes.dart';
// import 'package:fox/themes/app_text.dart';
// import 'package:fox/shared/shared.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class AppImagePicker extends StatefulWidget {
//   final ValueChanged<File> onFileSelected;

//   const AppImagePicker({super.key, required this.onFileSelected});

//   @override
//   State<AppImagePicker> createState() => _AppImagePickerState();
// }

// class _AppImagePickerState extends State<AppImagePicker> {
//   File? mediaFile;
//   Uint8List? videoThumbnail;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: showBottomSheet,
//       child: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16.r),
//               color: AppColors.navBarColor,
//               image: _getImage(),
//             ),
//             height: 172.h,
//             width: 100.w,
//             padding: EdgeInsets.symmetric(horizontal: 8.w),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 if (mediaFile == null) ...{
//                   Icon(
//                     Icons.add_a_photo_rounded,
//                     size: 24.sp,
//                   ),
//                   sizedBoxWithHeight(8),
//                   Text(
//                     Strings.addImageOrVideo,
//                     style: AppText.text12w400,
//                     textAlign: TextAlign.center,
//                   ),
//                 },
//                 if (mediaFile != null && mediaFile!.path.isVideo) ...{
//                   GestureDetector(
//                     onTap: _handleVideoPlay,
//                     child: Icon(
//                       Icons.play_circle_rounded,
//                       size: 48.sp,
//                     ),
//                   ),
//                 }
//               ],
//             ),
//           ),
//           if (mediaFile != null) ...{
//             Positioned(
//               top: 0,
//               right: 0,
//               child: GestureDetector(
//                 onTap: _handleRemoveAsset,
//                 child: CircleAvatar(
//                   radius: 12.r,
//                   backgroundColor: AppColors.appColor,
//                   child: Icon(
//                     Icons.close_rounded,
//                     color: AppColors.white,
//                     size: 24.sp,
//                   ),
//                 ),
//               ),
//             ),
//           },
//         ],
//       ),
//     );
//   }

//   void showBottomSheet() {
//     if (mediaFile == null) {
//       context.showImagePickerDialog(
//         onFirstCta: _handleOpenCamera,
//         onSecondCta: _handleSelectImageOrVideo,
//       );
//     }
//   }

//   void _handleOpenCamera() async {
//     AppEnvironment.navigator.pop();

//     context.showImagePickerDialog(
//       firstCtaTitle: Strings.image,
//       secondCtaTitle: Strings.video,
//       onFirstCta: _handleCameraImageSelector,
//       onSecondCta: () => _handleCameraImageSelector(isImage: false),
//     );
//   }

//   void _handleSelectImageOrVideo() async {
//     AppEnvironment.navigator.pop();
//     final file = await context.pickFile();
//     if (file == null) {
//       context.showErrorSnackBar(Strings.pleaseSelectaFile);
//       return;
//     }
//     await setMediaFile(file);
//   }

//   Future<void> setMediaFile(File file) async {
//     mediaFile = file;

//     if (mediaFile!.path.isVideo) {
//       context.showLoadingIndicator();
//       context.removeLoadingIndicator();
//     }
//     widget.onFileSelected(mediaFile!);

//     setState(() {});
//   }

//   void _handleRemoveAsset() {
//     setState(() => mediaFile = null);
//   }

//   void _handleVideoPlay() {
//     AppEnvironment.navigator.pushNamed(
//       GeneralRoutes.videoPlayer,
//       arguments: mediaFile?.path,
//     );
//   }

//   DecorationImage? _getImage() {
//     if (mediaFile == null) {
//       return null;
//     }
//     if (mediaFile!.path.isVideo.not) {
//       return DecorationImage(image: FileImage(mediaFile!));
//     }

//     if (mediaFile!.path.isVideo && videoThumbnail != null) {
//       return DecorationImage(image: MemoryImage(videoThumbnail!));
//     }

//     return null;
//   }

//   void _handleCameraImageSelector({bool isImage = true}) async {
//     final picker = ImagePicker();

//     AppEnvironment.navigator.pop();

//     XFile? media;

//     if (isImage) {
//       media = await picker.pickImage(source: ImageSource.camera);
//     } else {
//       media = await picker.pickVideo(source: ImageSource.camera);
//     }

//     if (media == null) {
//       context.showErrorSnackBar(Strings.pleaseSelectaImageVideoFile);
//       return;
//     }
//     await setMediaFile(File(media.path));
//   }
// }

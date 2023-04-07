import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fox/shared/shared.dart';

class AppImageViewer extends StatelessWidget {
  final String imageUrl;

  const AppImageViewer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldColor,
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: InteractiveViewer(
              child: CachedNetworkImage(imageUrl: imageUrl),
            ),
          ),
        ),
      ),
    );
  }
}

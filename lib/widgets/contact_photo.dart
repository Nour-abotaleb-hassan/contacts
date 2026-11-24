import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';

class ContactPhoto extends StatelessWidget {
  const ContactPhoto({
    super.key,
    required this.imagePath,
    required this.width,
    required this.height,
    this.borderRadius = 16,
  });

  final String? imagePath;
  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: width,
        height: height,
        color: AppColors.background,
        child: imagePath == null
            ? Lottie.asset(AppAssets.imagePickerAnimation, fit: BoxFit.contain)
            : Image.file(
                File(imagePath!),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Lottie.asset(
                  AppAssets.imagePickerAnimation,
                  fit: BoxFit.contain,
                ),
              ),
      ),
    );
  }
}

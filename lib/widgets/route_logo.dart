import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text.dart';

class RouteLogo extends StatelessWidget {
  const RouteLogo({super.key, this.fontSize = 40});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      AppText.route,
      style: TextStyle(
        color: AppColors.cream,
        fontSize: fontSize,
        fontWeight: FontWeight.w300,
        letterSpacing: -2,
        height: 1,
      ),
    );
  }
}

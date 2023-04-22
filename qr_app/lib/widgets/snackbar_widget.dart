import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/theme.dart';

class AppSnackBarWidget extends SnackBar {
  final String text;
  final Duration duration;
  final Icon icon;

  AppSnackBarWidget({
    super.key,
    required this.text,
    required this.duration,
    required this.icon,
  }) : super(
          behavior: SnackBarBehavior.floating,
          backgroundColor: ThemeApp.primary,
          duration: duration,
          dismissDirection: DismissDirection.horizontal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          content: ListTile(
            leading: icon,
            title: Text(
              text,
              style: GoogleFonts.sora(color: ThemeApp.secondary),
            ),
          ),
        );
}

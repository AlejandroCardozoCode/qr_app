import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_app/provider/db_provider.dart';
import 'package:qr_app/theme/theme.dart';
import 'package:qr_app/widgets/widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DbProvider.db.database;
    return Scaffold(
      backgroundColor: ThemeApp.primary,
      appBar: AppBar(
        title: Text(
          'Scanner',
          style: GoogleFonts.sora(
            fontWeight: FontWeight.w200,
            color: ThemeApp.secondary,
            letterSpacing: 10,
          ),
        ),
        backgroundColor: ThemeApp.primary,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HomeContainer(),
              Text(
                "Tap to scan",
                style: GoogleFonts.sora(
                  color: ThemeApp.secondary,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const HomeRowWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

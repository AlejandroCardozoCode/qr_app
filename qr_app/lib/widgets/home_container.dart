import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_app/models/scan_model.dart';
import 'package:qr_app/provider/db_provider.dart';
import 'package:qr_app/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widget.dart';

class HomeContainer extends StatelessWidget {
  HomeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: NeumorphicButton(
        onPressed: () async {
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            "#000000",
            "Cancel",
            false,
            ScanMode.QR,
          );
          if (barcodeScanRes.contains("http")) {
            ScanModel scan = ScanModel(type: "web", value: barcodeScanRes);
            DbProvider.db.insertToDB(scan);
            Uri url = Uri.parse(barcodeScanRes);
            if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
              log("No se puede lanzar la url $url");
            }
          } else if (barcodeScanRes != "-1") {
            ScanModel scan = ScanModel(type: "text", value: barcodeScanRes);
            DbProvider.db.insertToDB(scan);
            ScaffoldMessenger.of(context).showSnackBar(
              AppSnackBarWidget(
                duration: const Duration(seconds: 10),
                text: "QR Text: \'$barcodeScanRes\' added to history",
                icon: Icon(Icons.info_outline),
              ),
            );
          }
        },
        style: ThemeApp.neumorphicStyle,
        child: const Image(
          fit: BoxFit.contain,
          image: AssetImage("assets/qrHomePage.png"),
        ),
      ),
    );
  }
}

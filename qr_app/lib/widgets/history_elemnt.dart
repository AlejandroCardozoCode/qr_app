import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_app/provider/db_provider.dart';
import 'package:qr_app/services/qr_service.dart';
import 'package:qr_app/widgets/app_button.dart';
import 'package:qr_app/widgets/widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/theme.dart';

class HistoryElementWidget extends StatelessWidget {
  final String name;
  final int id;
  final Function onDelete;
  const HistoryElementWidget({super.key, required this.name, required this.id, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    Color deleteButtonColor = Colors.black;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      height: 120,
      child: NeumorphicButton(
        onPressed: () async {
          Uint8List? imageData = await QRService().getQRImageFromText(name);
          showBottomSheetHistory(context, imageData);
        },
        style: ThemeApp.neumorphicStyle,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: NeumorphicButton(
                onPressed: () {
                  Future.delayed(const Duration(milliseconds: 300), () {
                    onDelete();
                  });
                },
                style: NeumorphicStyle(
                  color: ThemeApp.primary,
                  depth: -5,
                ),
                child: Icon(Icons.delete_outline, color: deleteButtonColor),
              ),
            ),
            Expanded(
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.sora(
                  color: ThemeApp.secondary,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showBottomSheetHistory(BuildContext context, Uint8List? imageData) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: ThemeApp.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Neumorphic(
                style: ThemeApp.neumorphicStyle,
                child: Container(
                  height: 200,
                  width: 200,
                  padding: const EdgeInsets.all(20),
                  child: Image(
                    image: MemoryImage(imageData!),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SelectableText(
                name,
                textAlign: TextAlign.center,
                style: GoogleFonts.sora(fontWeight: FontWeight.w200),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButtonWidget(
                      icon: const Icon(Icons.save),
                      label: "Save",
                      function: () async {
                        QRService().saveQRToGallery(imageData);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          AppSnackBarWidget(
                            text: "QR saved into gallery",
                            duration: const Duration(seconds: 2),
                            icon: const Icon(Icons.save),
                          ),
                        );
                      }),
                  AppButtonWidget(
                      icon: const Icon(Icons.arrow_outward),
                      label: "Open",
                      function: () async {
                        if (!name.contains("https")) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            AppSnackBarWidget(
                              text: "This is not an URL",
                              duration: Duration(seconds: 2),
                              icon: Icon(Icons.warning_amber),
                            ),
                          );
                          return;
                        }
                        QRService().openQRInBrowser(name);
                      }),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

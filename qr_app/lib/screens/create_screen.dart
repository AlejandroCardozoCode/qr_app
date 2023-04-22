import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_app/services/qr_service.dart';
import 'package:qr_app/theme/theme.dart';
import 'package:qr_app/widgets/widget.dart';
import 'package:qr_image_generator/qr_image_generator.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  String QRPath = "";
  Uint8List? imageData;
  void _setImage(String newPath) {
    setState(() {
      QRPath = newPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    String inputValue = "";
    return Scaffold(
      backgroundColor: ThemeApp.primary,
      appBar: const CreateAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Neumorphic(
                  style: ThemeApp.neumorphicStyle,
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: getImage(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      depth: -7,
                      color: ThemeApp.primary,
                    ),
                    child: TextField(
                      onChanged: (value) {
                        inputValue = value;
                      },
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sora(
                        fontWeight: FontWeight.w200,
                      ),
                      decoration: InputDecoration(
                        hintText: "Write your text",
                        border: InputBorder.none,
                        focusColor: ThemeApp.primary,
                        hintStyle: GoogleFonts.sora(
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: Text(
                    "Image will be displayed and saved into device gallery",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sora(fontWeight: FontWeight.w200),
                  ),
                ),
                SizedBox(
                  height: 70,
                  width: 70,
                  child: NeumorphicButton(
                    style: NeumorphicStyle(
                      color: ThemeApp.primary,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () async {
                      log(inputValue);
                      if (inputValue != "") {
                        QRService qrService = QRService();
                        try {
                          Uint8List? image = await qrService.getQRImageFromText(inputValue);
                          if (image != null) {
                            setState(() async {
                              imageData = image;
                              await qrService.saveQRToGallery(imageData!);
                            });
                          }
                          _setImage(QRPath);
                          ScaffoldMessenger.of(context).showSnackBar(
                            AppSnackBarWidget(
                              text: "QR saved into gallery",
                              duration: const Duration(seconds: 2),
                              icon: const Icon(Icons.save),
                            ),
                          );
                        } catch (e) {
                          log(e.toString());
                        }
                      }
                    },
                    child: const Icon(
                      Icons.save,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Image getImage() {
    if (imageData == null) {
      return Image(image: const AssetImage("assets/qrHomePage.png"));
    }

    return Image(
      image: MemoryImage(imageData!),
    );
  }
}

import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:url_launcher/url_launcher.dart';

class QRService {
  QRService();

  Future<Uint8List?> getQRImageFromText(String data) async {
    final response = await http.get(Uri.parse('http://api.qrserver.com/v1/create-qr-code/?data=${data}&size=500x500&format=png&bgcolor=edf1f4'));
    Uint8List? imageData = null;
    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
    return null;
  }

  saveQRToGallery(Uint8List imageData) async {
    await ImageGallerySaver.saveImage(Uint8List.fromList(imageData), quality: 60, name: "qr-code");
  }

  openQRInBrowser(String qrUrl) async {
    Uri url = Uri.parse(qrUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {}
  }
}

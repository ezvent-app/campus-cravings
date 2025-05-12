import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<String?> compressImageToBase64(
  File file, {
  int targetSize = 102400,
}) async {
  try {
    final originalBytes = await file.readAsBytes();
    final originalSize = originalBytes.length;

    int estimatedQuality =
        (targetSize / originalSize * 100).clamp(10, 95).toInt();

    final compressedBytes = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      quality: estimatedQuality,
    );

    if (compressedBytes != null) {
      return base64Encode(compressedBytes);
    } else {
      return null; // Compression failed
    }
  } catch (e) {
    print('Compression error: $e');
    return null;
  }
}

import 'package:flutter/services.dart';

class FilePicker {
  static const MethodChannel _channel = MethodChannel('file_picker_channel');

  static Future<String?> pickFile() async {
    try {
      final String? result = await _channel.invokeMethod('pickFile');
      return result;
    } on PlatformException catch (e) {
      print("Failed to pick file: ${e.message}");
      return null;
    }
  }
}

import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SciNote',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    openFilePicker(); // アプリ起動時にファイルダイアログを開く
  }

  // プラットフォームに応じてファイルダイアログを開く
  void openFilePicker() async {
    if (Platform.isIOS) {
      try {
        // MethodChannelを使用して、iOSのネイティブコードにファイル選択を依頼
        final String? filePath =
            await MethodChannel('file_picker_channel').invokeMethod('pickFile');
        if (filePath != null) {
          print("iOS File picked: $filePath");
        } else {
          print("No file selected.");
        }
      } on PlatformException catch (e) {
        print("Error: ${e.message}");
      }
    } else {
      print("This feature is only available on iOS.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Picker Example'),
      ),
      body: Center(
        child: Text('ファイルダイアログを開いています...'),
      ),
    );
  }
}

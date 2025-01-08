// lib/features/handwriting/presentation/pages/file_picker_page.dart

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerPage extends StatefulWidget {
  @override
  _FilePickerPageState createState() => _FilePickerPageState();
}

class _FilePickerPageState extends State<FilePickerPage> {
  String? _fileName;

  // ファイル選択メソッド
  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name; // 選択されたファイル名
      });
    } else {
      // ユーザーがファイルを選択しなかった場合
      setState(() {
        _fileName = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ファイル選択'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ファイル名の表示
            Text(
              _fileName ?? 'ファイルを選択してください',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            // ファイル選択ボタン
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('ファイルを選択'),
            ),
          ],
        ),
      ),
    );
  }
}

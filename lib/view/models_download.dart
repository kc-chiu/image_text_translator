import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class ModelsDownload extends StatelessWidget {
  final myStyle = TextStyle(fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    final downloading = context.watch<AppState>().downloading;
    final downloadError = context.watch<AppState>().downloadError;

    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              child: Text(
                //'The language models of English and Chinese needed for translation are not downloaded.',
                '沒有下載英譯中資料',
                style: myStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              child: Text(
                //'Please turn on WiFi and download the language models before proceeding.',
                '請連接 Wi-Fi 下載',
                style: myStyle,
              ),
            ),
          ],
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () => context.read<AppState>().downloadLanguageModels(),
            child: Text(
              //'Download',
              '下載',
            ),
          ),
        ),
        SizedBox(height: 20.0),
        downloading
            ? CircularProgressIndicator()
            : Container(
                alignment: Alignment.center,
                child: Text(
                  downloadError ?? '',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.red,
                  ),
                ),
              ),
      ],
    );
  }
}

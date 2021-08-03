import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/workspace.dart';
import 'view/models_download.dart';
import 'app_state.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AppState()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Show workspace or download screen
    // based on language models downloaded or not
    final modelsAreDownloaded = context.watch<AppState>().modelsAreDownloaded;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            //'Image Text Translator',
            '圖片文字翻譯器',
          ),
        ),
        body: FutureBuilder<bool>(
          future: modelsAreDownloaded,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              print('snapshot.data: ${snapshot.data}');
              return snapshot.data! ? WorkSpace() : ModelsDownload();
            } else if (snapshot.hasError) {
              return Text('Language Model Error');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

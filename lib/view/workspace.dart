import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class WorkSpace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imageFile = context.watch<AppState>().imageFile;
    final detectedText = context.watch<AppState>().detectedText;
    final translatedText = context.watch<AppState>().translatedText;

    return Column(
      children: [
        // Image box
        Row(
          children: [
            Expanded(child: Container()),
            // Image box
            Container(
              alignment: Alignment.center,
              color: Colors.grey[300],
              width: 130,
              height: 150,
              child: imageFile != null
                  ? Image.file(
                      imageFile,
                      fit: BoxFit.fill,
                    )
                  : Icon(
                      Icons.image,
                      size: 32,
                    ),
            ),
            // Button column
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Gallery
                  ElevatedButton(
                      onPressed: () =>
                          context.read<AppState>().transform(fromCamera: false),
                      child: Text(
                        //'Gallery',
                        '圖庫',
                      )),
                  // Camera
                  ElevatedButton(
                      onPressed: () =>
                          context.read<AppState>().transform(fromCamera: true),
                      child: Text(
                        //'Camera'.
                        '相機',
                      )),
                  // Disclaimer
                  ElevatedButton(
                      onPressed: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                      'THIS SERVICE MAY CONTAIN TRANSLATIONS POWERED BY GOOGLE. GOOGLE DISCLAIMS ALL WARRANTIES RELATED TO THE TRANSLATIONS, EXPRESS OR IMPLIED, INCLUDING ANY WARRANTIES OF ACCURACY, RELIABILITY, AND ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.'),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                      '此服务可能包含由 GOOGLE 提供支持的翻译。GOOGLE 对本翻译不提供任何明示或默示保证，包括对准确性或可靠性的任何保证，以及对适销性、针对特定用途的适用性和无侵权性的任何默示保证。'),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text('I understand'),
                                        Text('本人明白'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      child: Text(
                        // 'Disclaimer',
                        '免責聲明',
                      )),
                ],
              ),
            ),
          ],
        ),
        // Detected text
        Expanded(
          child: Column(
            children: [
              // Title bar
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  border: Border.all(),
                ),
                child: Text(
                  //'Image Text',
                  '圖片文字',
                ),
              ),
              // Text body
              Expanded(
                child: ListView(
                  children: [
                    detectedText != null
                        ? Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              detectedText,
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        : Text(''),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Translated text
        Expanded(
          child: Column(
            children: [
              // Title bar
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  border: Border.all(),
                ),
                child: Text(
                  //'Translate with Google',
                  'Google 翻譯',
                ),
              ),
              // Text body
              Expanded(
                child: ListView(
                  children: [
                    translatedText != null
                        ? Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              translatedText,
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        : Text(''),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Google translate badge
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset('images/color-regular.png'),
        ),
      ],
    );
  }
}

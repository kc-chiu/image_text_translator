import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'text_detection_repository.dart';

class GoogleMlKitTextDetectionRepository implements TextDetectionRepository {
  @override
  Future<String> detectText(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText recognisedText =
        await textDetector.processImage(inputImage);
    textDetector.close();
    return recognisedText.text;
  }
}

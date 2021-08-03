import 'dart:io';
import 'google_ml_kit_text_detection_repository.dart';

abstract class TextDetectionRepository {
  factory TextDetectionRepository() => GoogleMlKitTextDetectionRepository();

  Future<String> detectText(File imageFile);
}

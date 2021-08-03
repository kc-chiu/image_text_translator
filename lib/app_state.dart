import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'repository/repository.dart';

class AppState with ChangeNotifier {
  AppState() {
    _checkModelsDownload();
  }

  final _translationRepository = TranslationRepository();
  final _imagesRepository = ImagesRepository();
  final _textDetectionRepository = TextDetectionRepository();

  String? _downloadResults;
  String? get downloadResults => _downloadResults;

  bool _downloading = false;
  bool get downloading => _downloading;
  String? _downloadError;
  String? get downloadError => _downloadError;

  late Future<bool> _modelsAreDownloaded;
  Future<bool> get modelsAreDownloaded => _modelsAreDownloaded;

  File? _imageFile;
  File? get imageFile => _imageFile;
  String? _detectedText;
  String? get detectedText => _detectedText;
  String? _translatedText;
  String? get translatedText => _translatedText;

  Future<void> _checkModelsDownload() async {
    _modelsAreDownloaded = _translationRepository.checkModelsDownload();
  }

  Future<void> downloadLanguageModels() async {
    // Download only when connected with Wi-Fi
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi) {
      _downloading = true;
      notifyListeners();
      try {
        _downloadResults =
            await _translationRepository.downloadLanguageModels();
        if (_downloadResults == 'success') {
          _checkModelsDownload();
          notifyListeners();
        }
      } catch (e) {
        _downloading = false;
        _downloadError = '$e';
        notifyListeners();
      }
    } else {
      // _downloadError = 'No Wi-Fi detected';
      _downloadError = '沒有連接 Wi-Fi';
      notifyListeners();
    }
  }

  Future<void> transform({fromCamera = true}) async {
    // Get the image, extract text and translate
    final image = await _imagesRepository.fetchImage(fromCamera: fromCamera);
    if (image != null) {
      _imageFile = File(image.path);
      notifyListeners();
      if (_imageFile != null) {
        _detectedText = await _textDetectionRepository.detectText(_imageFile!);
        if (_detectedText != null) {
          notifyListeners();
          _translatedText =
              await _translationRepository.translate(_detectedText!);
          if (_translatedText != null) {
            notifyListeners();
          }
        }
      }
    }
  }
}

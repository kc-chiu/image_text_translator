import 'package:google_ml_kit/google_ml_kit.dart';
import 'translation_repository.dart';

class GoogleMlKitTranslationRepository implements TranslationRepository {
  final _languageModelManager = GoogleMlKit.nlp.translateLanguageModelManager();

  Future<bool> checkModelsDownload() async {
    final englishModelIsDownloaded =
        await _languageModelManager.isModelDownloaded('en');
    final chineseModelIsDownloaded =
        await _languageModelManager.isModelDownloaded('zh');
    return englishModelIsDownloaded && chineseModelIsDownloaded;
  }

  Future<String> downloadLanguageModels() async {
    try {
      await _languageModelManager.downloadModel('en');
      await _languageModelManager.downloadModel('zh');
    } catch (e) {
      throw Exception('$e');
    }
    return 'success';
  }

  Future<String> translate(String text) async {
    final onDeviceTranslator = GoogleMlKit.nlp.onDeviceTranslator(
        sourceLanguage: TranslateLanguage.ENGLISH,
        targetLanguage: TranslateLanguage.CHINESE);
    final result = await onDeviceTranslator.translateText(text);
    onDeviceTranslator.close();
    return result;
  }
}

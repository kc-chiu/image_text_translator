import 'google_ml_kit_translation_repository.dart';

abstract class TranslationRepository {
  factory TranslationRepository() => GoogleMlKitTranslationRepository();

  Future<bool> checkModelsDownload();

  Future<String> downloadLanguageModels();

  Future<String> translate(String text);
}

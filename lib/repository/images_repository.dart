import 'package:image_picker/image_picker.dart';
import 'image_picker_images_repository.dart';

abstract class ImagesRepository {
  factory ImagesRepository() => ImagePickerImagesRepository();

  Future<XFile?> fetchImage({bool fromCamera});
}

import 'package:image_picker/image_picker.dart';
import 'images_repository.dart';

class ImagePickerImagesRepository implements ImagesRepository {
  final _picker = ImagePicker();

  Future<XFile?> fetchImage({bool fromCamera = true}) async {
    ImageSource source;
    if (fromCamera) {
      source = ImageSource.camera;
    } else {
      source = ImageSource.gallery;
    }
    final image = await _picker.pickImage(source: source);
    return image;
  }
}

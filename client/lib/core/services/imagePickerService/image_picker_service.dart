import 'dart:io';

import 'package:donardiary/core/services/imageUploadService/image_upload_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePickerServiceProvider =
    AsyncNotifierProvider<ImagePickerNotifier, String?>(() {
  return ImagePickerNotifier();
});

class ImagePickerNotifier extends AsyncNotifier<String?> {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<String?> build() async {
    // Initial state - no image selected
    return null;
  }

  Future<void> pickFromGallery() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      return _handleImageResult(image);
    });
  }

  Future<void> pickFromCamera() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      return _handleImageResult(image);
    });
  }

  Future<String?> _handleImageResult(XFile? image) async {
    if (image != null) {
      final uplodedUrl = await ref
          .read(imageUploadProvider.notifier)
          .uploadImage(File(image.path));
      
      return uplodedUrl; // Return file path as String
    }
    return null; // Maintain null state if user cancels
  }

  void clearImage() {
    state = const AsyncValue.data(null);
  }
}

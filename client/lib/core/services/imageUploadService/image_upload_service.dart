import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ImageUploadNotifier extends AsyncNotifier<String?> {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<String?> build() async {
    return null;
  }

  
  Future<String?> uploadImage(File imageFile) async {

    state = const AsyncValue.loading();
    

    state = await AsyncValue.guard(() async {
      try {
        final ref = _storage
            .ref()
            .child('profile_images/${DateTime.now().millisecondsSinceEpoch}');
        
        final uploadTask = ref.putFile(imageFile);
        final snapshot = await uploadTask;
        final downloadUrl = await snapshot.ref.getDownloadURL();
        
        return downloadUrl;
      } catch (e) {
        print('Error uploading image: $e');
        throw Exception('Error uploading image: ${e.toString()}');
      }
      
    });
    return state.value;
  }
}


final imageUploadProvider = AsyncNotifierProvider<ImageUploadNotifier, String?>(
  () => ImageUploadNotifier(),
);
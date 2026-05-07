import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {

  final FirebaseStorage _storage =
      FirebaseStorage.instance;

  Future<String> uploadProfileImage({

    required File file,
    required String uid,

  }) async {

    try {

      Reference ref = _storage
          .ref()
          .child('profile_images')
          .child('$uid.jpg');

      UploadTask uploadTask =
      ref.putFile(file);

      TaskSnapshot snapshot =
      await uploadTask;

      String downloadUrl =
      await snapshot.ref.getDownloadURL();

      return downloadUrl;

    } catch (e) {

      throw Exception(
        'Image Upload Failed: $e',
      );
    }
  }
}
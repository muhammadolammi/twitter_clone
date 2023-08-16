import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/constants/appwrite_consts.dart';
import 'package:twitter_clone/core/provider.dart';

final storageApiProvider = Provider((ref) {
  final storage = ref.watch(appwriteStorgaeProvider);
  return StorageApi(storage: storage);
});

class StorageApi {
  final Storage _storage;
  StorageApi({required Storage storage}) : _storage = storage;

  Future<List<String>> uploadImage(List<File> files) async {
    List<String> imageLinks = [];
    for (final file in files) {
      final uploadedImage = await _storage.createFile(
        bucketId: AppWriteConstants.imagesBucket,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: file.path),
      );
      imageLinks.add(
        AppWriteConstants.imageUrl(uploadedImage.$id),
      );
    }
    return imageLinks;
  }
}

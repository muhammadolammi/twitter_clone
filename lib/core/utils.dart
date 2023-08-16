import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
  ));
}

String getName(String email) {
  String name = email.split('@')[0];

  return name;
}

Future<List<File>> getImages() async {
  List<File> images = [];
  ImagePicker picker = ImagePicker();
  final imageFiles = await picker.pickMultiImage();
  if (imageFiles.isNotEmpty) {
    for (var image in imageFiles) {
      images.add(File(image.path));
    }
  }
  return images;
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:multiple_images_picker/multiple_images_picker.dart';

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

Future<List> getImages() async {
  List images = [];
  ImagePicker picker = ImagePicker();
  final imageFiles = await picker.pickMultiImage();
  if (imageFiles.isNotEmpty || kIsWeb) {
    for (var image in imageFiles) {
      images.add(image.path);
    }
  } else if (imageFiles.isNotEmpty) {
    for (var image in imageFiles) {
      images.add(File(image.path));
    }
  }
  return images;
}

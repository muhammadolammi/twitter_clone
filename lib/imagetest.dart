import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:flutter/foundation.dart';

List<File> imagesFiles = [];
List<String> imageStrings = [];

Future<List<File>> getImageFiles() async {
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

Future<List<String>> getImageStrings() async {
  List<String> images = [];
  ImagePicker picker = ImagePicker();
  final imageFiles = await picker.pickMultiImage();
  if (imageFiles.isNotEmpty) {
    for (var image in imageFiles) {
      images.add(image.path);
    }
  }
  return images;
}

class showImages extends StatefulWidget {
  const showImages({super.key});

  @override
  State<showImages> createState() => _showImagesState();
}

class _showImagesState extends State<showImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Image'),
        centerTitle: true,
      ),
      body: Column(children: [
        CarouselSlider(
          items: kIsWeb
              ? imageStrings.map((string) => Image.network(string)).toList()
              : imagesFiles.map((file) => Image.file(file)).toList(),
          options: CarouselOptions(height: 300, enableInfiniteScroll: false),
        ),
        TextButton(
            onPressed: () async {
              imageStrings = await getImageStrings();
              setState(() {});
            },
            child: Text('Choose Image')),
      ]),
    );
  }
}

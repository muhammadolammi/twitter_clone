// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSlide extends StatefulWidget {
  final List<String> imageLinks;

  const CarouselSlide({
    Key? key,
    required this.imageLinks,
  }) : super(key: key);

  @override
  State<CarouselSlide> createState() => _CarouselSlideState();
}

class _CarouselSlideState extends State<CarouselSlide> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            CarouselSlider(
              items: widget.imageLinks.map((imageSrc) {
                return Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(25)),
                  margin: const EdgeInsets.all(10),
                  child: Image.network(
                    imageSrc,
                    fit: BoxFit.contain,
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 200,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _index = index;
                  });
                },
              ),
            ),
            // Row(
            //   children: widget.imageLinks.asMap().entries.map((e) {
            //     return Container(
            //       margin: EdgeInsets.symmetric(horizontal: 4),
            //       height: 12,
            //       width: 12,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: Pallete.whiteColor
            //             .withOpacity(_index == e.key ? 0.9 : 0.4),
            //       ),
            //     );
            //   }).toList(),
            // )
          ],
        )
      ],
    );
  }
}

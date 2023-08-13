import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/assets_consts.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/controller/auth_controller.dart';
import 'package:twitter_clone/theme/pallete.dart';

class TweetPage extends ConsumerStatefulWidget {
  static const routeId = '/tweetpage';
  const TweetPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TweetPageState();
}

class _TweetPageState extends ConsumerState<TweetPage> {
  final _tweetcontroller = TextEditingController();
  List images = [];

  @override
  void dispose() {
    _tweetcontroller.dispose();
    super.dispose();
  }

  void onPickImages() async {
    images = await getImages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(getCurrentUserDataProvider).value;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        actions: [
          RoundedSmallButton(
            onTap: () {},
            label: 'Tweet',
            backGroundColor: Pallete.blueColor,
            labelColor: Pallete.whiteColor,
          )
        ],
      ),
      body: userData == null
          ? const Loader()
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(userData.profilePic),
                          radius: 30,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _tweetcontroller,
                            style: const TextStyle(fontSize: 22),
                            decoration: const InputDecoration(
                              hintText: "What's Happening?",
                              hintStyle: TextStyle(
                                color: Pallete.greyColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                              border: InputBorder.none,
                            ),
                            maxLines: null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (images.isNotEmpty)
                      CarouselSlider(
                        items: images.map(
                          (imageSrc) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: kIsWeb
                                  ? Image.network(imageSrc.toString())
                                  : Image.file(imageSrc),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          height: 400,
                          enableInfiniteScroll: false,
                        ),
                      ),
                    Row(
                      children: [Text('data')],
                    )
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
            border: Border(
          top: BorderSide(
            color: Pallete.greyColor,
            width: 0.4,
          ),
        )),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(
              left: 15,
              right: 15,
            ),
            child: GestureDetector(
                onTap: onPickImages,
                child: SvgPicture.asset(AssetsConstants.galleryIcon)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(
              left: 15,
              right: 15,
            ),
            child: SvgPicture.asset(AssetsConstants.gifIcon),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(
              left: 15,
              right: 15,
            ),
            child: SvgPicture.asset(AssetsConstants.emojiIcon),
          ),
        ]),
      ),
    );
  }
}

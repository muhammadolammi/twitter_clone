import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/constants/assets_consts.dart';
import 'package:twitter_clone/theme/pallete.dart';

class UiConstants {
  static AppBar appbar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        color: Pallete.blueColor,
        height: 30,
      ),
      centerTitle: true,
    );
  }

  static List<Widget> bottomNavigationPages = [
    const Text('Tweet Page'),
    const Text('Search Page'),
    const Text('Notf Page'),
  ];
}

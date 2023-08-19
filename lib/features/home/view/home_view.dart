import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/tweet/view/create_tweet_page_view.dart';
import 'package:twitter_clone/theme/pallete.dart';

class HomeView extends ConsumerStatefulWidget {
  static const routeId = '/homeview';

  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final bottomNavigationPages = UiConstants.bottomNavigationPages;

  int _page = 0;
  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  void onTweetButtonTap() {
    Navigator.pushNamed(context, TweetPage.routeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiConstants.appbar(),
      body: IndexedStack(
        index: _page,
        children: bottomNavigationPages,
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _page,
        onTap: onPageChange,
        backgroundColor: Pallete.backgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: _page == 0
                ? SvgPicture.asset(
                    AssetsConstants.homeFilledIcon,
                    color: Pallete.whiteColor,
                  )
                : SvgPicture.asset(
                    AssetsConstants.homeOutlinedIcon,
                    color: Pallete.whiteColor,
                  ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsConstants.searchIcon,
              color: Pallete.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: _page == 2
                ? SvgPicture.asset(
                    AssetsConstants.notifFilledIcon,
                    color: Pallete.whiteColor,
                  )
                : SvgPicture.asset(
                    AssetsConstants.notifOutlinedIcon,
                    color: Pallete.whiteColor,
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onTweetButtonTap,
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
          size: 28,
        ),
      ),
    );
  }
}

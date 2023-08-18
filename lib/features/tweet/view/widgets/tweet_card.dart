import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/features/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweet/view/widgets/carousel_slider.dart';
import 'package:twitter_clone/features/tweet/view/widgets/hastags_links.dart';
import 'package:twitter_clone/models/tweetmodel.dart';
import 'package:twitter_clone/theme/theme.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../constants/assets_consts.dart';
import 'tweet_icon_button.dart';

class TweetCard extends ConsumerWidget {
  final Tweet tweet;
  const TweetCard({
    super.key,
    required this.tweet,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getUserDataProvider(tweet.uid)).when(
        data: (user) {
          return Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.profilePic),
                      radius: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Text ',
                                style: TextStyle(
                                  color: Pallete.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                              Text(
                                " @${user.name} ",
                                style: const TextStyle(
                                  color: Pallete.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                              Text(
                                "${timeago.format(tweet.tweetedAt, locale: 'en_short')} ",
                                style: const TextStyle(
                                  color: Pallete.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: HashTags_Links(text: tweet.text),
                          ),
                          if (tweet.tweetType == TweetType.image)
                            CarouselSlide(imageLinks: tweet.imageLinks),
                          const SizedBox(
                            height: 4,
                          ),
                          if (tweet.tweetType == TweetType.text &&
                              tweet.link.isNotEmpty)
                            AnyLinkPreview(
                              link: tweet.link,
                              displayDirection:
                                  UIDirection.uiDirectionHorizontal,
                            ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 10,
                              right: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TweetIconButton(
                                  onTap: () {},
                                  pathName: AssetsConstants.viewsIcon,
                                  text:
                                      '${tweet.commentIds.length + tweet.likes.length + tweet.reshareCount}',
                                ),
                                TweetIconButton(
                                  onTap: () {},
                                  pathName: AssetsConstants.commentIcon,
                                  text: tweet.commentIds.length.toString(),
                                ),
                                TweetIconButton(
                                  onTap: () {},
                                  pathName: AssetsConstants.likeOutlinedIcon,
                                  text: tweet.likes.length.toString(),
                                ),
                                TweetIconButton(
                                  onTap: () {},
                                  pathName: AssetsConstants.retweetIcon,
                                  text: tweet.reshareCount.toString(),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.share_outlined,
                                    size: 25,
                                  ),
                                ),
                                const SizedBox(
                                  height: 1,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Pallete.greyColor,
                ),
              ],
            ),
          );
        },
        error: (e, st) => ErrorText(error: e.toString()),
        loading: () => Container());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/tweet/view/controller/tweetcontroller.dart';
import 'package:twitter_clone/features/tweet/view/widgets/tweet_card.dart';

class TweetList extends ConsumerWidget {
  const TweetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(tweetListProvider).when(
          data: (tweets) {
            return ListView.builder(
                itemCount: tweets.length,
                itemBuilder: ((BuildContext context, int index) {
                  final tweet = tweets[index];
                  return TweetCard(tweet: tweet);
                }));
          },
          error: (e, st) => ErrorText(error: e.toString()),
          loading: () => const Loader(),
        );
  }
}

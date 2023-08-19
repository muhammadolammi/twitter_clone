import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/tweet/view/controller/tweetcontroller.dart';
import 'package:twitter_clone/features/tweet/view/widgets/tweet_card.dart';

import '../../../../constants/appwrite_consts.dart';
import '../../../../models/tweetmodel.dart';

class TweetList extends ConsumerWidget {
  const TweetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(tweetListProvider).when(
          data: (tweets) {
            return ref.watch(getLatestProvider).when(
                data: (data) {
                  print('data');
                  final newTweets = tweets;
                  if (data.events.contains(
                      'databases.*.collections.${AppWriteConstants.tweetCollectionId}.documents.*.create')) {
                    newTweets.add(Tweet.fromMap(data.payload));
                  }
                  return ListView.builder(
                      itemCount: tweets.length,
                      itemBuilder: ((BuildContext context, int index) {
                        final tweet = newTweets[index];
                        return TweetCard(tweet: tweet);
                      }));
                },
                error: (e, st) => ErrorText(error: e.toString()),
                loading: () {
                  print('loading');
                  return ListView.builder(
                      itemCount: tweets.length,
                      itemBuilder: ((BuildContext context, int index) {
                        final tweet = tweets[index];
                        return TweetCard(tweet: tweet);
                      }));
                });
          },
          error: (e, st) => ErrorText(error: e.toString()),
          loading: () => const Loader(),
        );
  }
}

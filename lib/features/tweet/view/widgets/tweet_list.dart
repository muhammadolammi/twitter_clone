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
                  if (data.events.contains(
                      'databases.*.collections.${AppWriteConstants.tweetCollectionId}.documents.*.create')) {
                    tweets.insert(0, Tweet.fromMap(data.payload));
                  } else if (data.events.contains(
                    'databases.*.collections.${AppWriteConstants.tweetCollectionId}.documents.*.update',
                  )) {
                    // get id of original tweet
                    final startingPoint =
                        data.events[0].lastIndexOf('documents.');
                    final endPoint = data.events[0].lastIndexOf('.update');
                    final tweetId =
                        data.events[0].substring(startingPoint + 10, endPoint);

                    var tweet =
                        tweets.where((element) => element.id == tweetId).first;

                    final tweetIndex = tweets.indexOf(tweet);
                    tweets.removeWhere((element) => element.id == tweetId);

                    tweet = Tweet.fromMap(data.payload);
                    tweets.insert(tweetIndex, tweet);
                  }

                  print('data');
                  print(data.events[0]);
                  print(tweets.length);

                  return ListView.builder(
                      itemCount: tweets.length,
                      itemBuilder: ((BuildContext context, int tweetIndex) {
                        final tweet = tweets[tweetIndex];
                        return TweetCard(tweet: tweet);
                      }));
                },
                error: (e, st) => ErrorText(error: e.toString()),
                loading: () {
                  print(tweets.length);

                  print('loading');

                  return ListView.builder(
                      itemCount: tweets.length,
                      itemBuilder: ((BuildContext context, int tweetIndex) {
                        final tweet = tweets[tweetIndex];
                        return TweetCard(tweet: tweet);
                      }));
                });
          },
          error: (e, st) => ErrorText(error: e.toString()),
          loading: () => const Loader(),
        );
  }
}

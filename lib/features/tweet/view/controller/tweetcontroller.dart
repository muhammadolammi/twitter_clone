import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/storage_api.dart';
import 'package:twitter_clone/apis/tweet_api.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/controller/auth_controller.dart';
import 'package:twitter_clone/models/tweetmodel.dart';

import '../../../../models/user_model.dart';

final tweetControllerProvider =
    StateNotifierProvider.autoDispose<TweetController, bool>((ref) {
  final tweetApi = ref.watch(tweetApiProvider);
  final storageApi = ref.watch(storageApiProvider);
  return TweetController(ref: ref, tweetApi: tweetApi, storageApi: storageApi);
});
final tweetListProvider = FutureProvider.autoDispose((ref) async {
  final tweetController = ref.watch(tweetControllerProvider.notifier);

  return tweetController.getTweets();
});

final getLatestProvider = StreamProvider.autoDispose((ref) {
  final tweetApi = ref.watch(tweetApiProvider);
  return tweetApi.getLatestTweets();
});

class TweetController extends StateNotifier<bool> {
  final Ref _ref;
  final TweetApi _tweetApi;
  final StorageApi _storageApi;
  TweetController(
      {required Ref ref,
      required TweetApi tweetApi,
      required StorageApi storageApi})
      : _ref = ref,
        _tweetApi = tweetApi,
        _storageApi = storageApi,
        super(false);
  void sharetweet({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {
    void shareImageTweet({
      required List<File> images,
      required String text,
      required BuildContext context,
    }) async {
      state = true;

      final user = _ref.watch(getCurrentUserDataProvider).value!;
      final imageLinks = await _storageApi.getImageLinks(images);

      Tweet tweet = Tweet(
          text: text,
          hashtags: getHashtags(text),
          link: getLink(text),
          imageLinks: imageLinks,
          uid: user.uid,
          tweetType: TweetType.image,
          tweetedAt: DateTime.now(),
          likes: const [],
          commentIds: const [],
          id: ID.unique(),
          retweetCount: 0,
          retweetedBy: '',
          repliedTo: '');
      final res = await _tweetApi.shareTweet(tweet);
      res.fold((l) => showSnackBar(content: l.message, context: context), (r) {
        Navigator.pop(context);
      });
      state = false;
    }

    void shareTextTweet({
      required String text,
      required BuildContext context,
    }) async {
      state = true;

      final user = _ref.watch(getCurrentUserDataProvider).value!;

      Tweet tweet = Tweet(
          text: text,
          hashtags: getHashtags(text),
          link: getLink(text),
          imageLinks: const [],
          uid: user.uid,
          tweetType: TweetType.text,
          tweetedAt: DateTime.now(),
          likes: const [],
          commentIds: const [],
          id: ID.unique(),
          retweetCount: 0,
          retweetedBy: '',
          repliedTo: '');
      final res = await _tweetApi.shareTweet(tweet);
      res.fold((l) => showSnackBar(content: l.message, context: context), (r) {
        Navigator.pop(context);
      });
      state = false;
    }

    if (text.isEmpty) {
      showSnackBar(context: context, content: 'Please input some text');
      return;
    } else if (images.isNotEmpty) {
      shareImageTweet(images: images, text: text, context: context);
    } else {
      shareTextTweet(text: text, context: context);
    }
  }

  void reshareTweet(
      {required Tweet tweet,
      required User currentUser,
      required BuildContext context}) async {
    final oldtweet = tweet.copyWith(
      retweetedBy: currentUser.name,
      reshareCount: tweet.retweetCount + 1,
    );
    final res = await _tweetApi.updatereshareCount(oldtweet);
    res.fold((l) => showSnackBar(content: l.message, context: context),
        (r) async {
      final newTweet = oldtweet.copyWith(
        retweetedBy: currentUser.name,
        tweetedAt: DateTime.now(),
        id: '${oldtweet.id}${oldtweet.retweetCount}',
      );
      final res2 = await _tweetApi.shareTweet(newTweet);
      res2.fold((l) => showSnackBar(content: l.message, context: context),
          (r) => showSnackBar(content: 'Retweeted', context: context));
    });
  }

  void likeTweet({required Tweet tweet, required User user}) async {
    List<String> likes = tweet.likes;
    if (tweet.likes.contains(user.uid)) {
      likes.remove(user.uid);
    } else {
      likes.add(user.uid);
    }
    tweet = tweet.copyWith(likes: likes);
    final res = await _tweetApi.likeTweet(tweet);
    res.fold((l) => null, (r) => null);
  }

  Future<List<Tweet>> getTweets() async {
    final tweetsList = await _tweetApi.getTweet();
    return tweetsList.map((tweet) => Tweet.fromMap(tweet.data)).toList();
  }

  String getLink(String text) {
    List<String> links = [];
    String link = '';

    List<String> wordsInSentence = text.split(" ");
    for (String word in wordsInSentence) {
      if (word.startsWith("https://") || word.startsWith('www.')) {
        links.add(word);
        link = links[0];
      }
    }
    return link;
  }

  List<String> getHashtags(String text) {
    List<String> wordsInSentence = text.split(" ");
    List<String> hashtags = [];
    for (String hashtag in wordsInSentence) {
      if (hashtag.startsWith("#")) {
        hashtags.add(hashtag);
      }
    }
    return hashtags;
  }
}

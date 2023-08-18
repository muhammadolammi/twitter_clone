import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/storage_api.dart';
import 'package:twitter_clone/apis/tweet_api.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/controller/auth_controller.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:twitter_clone/models/tweetmodel.dart';

final tweetControllerProvider =
    StateNotifierProvider<TweetController, bool>((ref) {
  final tweetApi = ref.watch(tweetApiProvider);
  final storageApi = ref.watch(storageApiProvider);
  return TweetController(ref: ref, tweetApi: tweetApi, storageApi: storageApi);
});
final tweetListProvider = FutureProvider((ref) async {
  final tweetController = ref.watch(tweetControllerProvider.notifier);

  return tweetController.getTweets();
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
          id: '',
          reshareCount: 0,
          retweetedBy: '',
          repliedTo: '');
      final res = await _tweetApi.shareTweet(tweet);
      res.fold((l) => showSnackBar(content: l.message, context: context),
          (r) => Navigator.popAndPushNamed(context, HomeView.routeId));
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
          id: '',
          reshareCount: 0,
          retweetedBy: '',
          repliedTo: '');
      final res = await _tweetApi.shareTweet(tweet);
      res.fold((l) => showSnackBar(content: l.message, context: context),
          (r) => Navigator.popAndPushNamed(context, HomeView.routeId));
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

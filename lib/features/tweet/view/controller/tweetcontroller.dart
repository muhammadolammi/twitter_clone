import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/tweet_api.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/controller/auth_controller.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:twitter_clone/models/tweetmodel.dart';

final tweetControllerProvider =
    StateNotifierProvider<TweetController, bool>((ref) {
  final tweetApi = ref.watch(tweetApiProvider);
  return TweetController(ref: ref, tweetApi: tweetApi);
});

class TweetController extends StateNotifier<bool> {
  final Ref _ref;
  final TweetApi _tweetApi;
  TweetController({required Ref ref, required TweetApi tweetApi})
      : _ref = ref,
        _tweetApi = tweetApi,
        super(false);
  List<String> getLinks(String text) {
    List<String> links = [];

    List<String> wordsInSentence = text.split(" ");
    for (String word in wordsInSentence) {
      if (word.startsWith("https://") || word.startsWith("www.")) {
        links.add(word);
      }
    }
    return links;
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

  void sharetweet({
    required List images,
    required String text,
    required BuildContext context,
  }) {
    void shareImageTweet({
      required List images,
      required String text,
      required BuildContext context,
    }) {}
    void shareTextTweet({
      required List images,
      required String text,
      required BuildContext context,
    }) async {
      final user = _ref.read(getCurrentUserDataProvider).value!;

      state = true;
      final hashtags = getHashtags(text);
      final links = getLinks(text);
      final Tweet tweet = Tweet(
        text: text,
        commentIds: const [],
        hashtags: hashtags,
        id: '',
        imageLinks: const [],
        likes: const [],
        links: links,
        repliedTo: '',
        reshareCount: 0,
        retweetedBy: '',
        tweetType: TweetType.text,
        tweetedAt: DateTime.now(),
        uid: user.uid,
      );
      final res = await _tweetApi.shareTweet(tweet);
      res.fold((l) => showSnackBar(context: context, content: l.message),
          (r) => null);
      Navigator.popAndPushNamed(context, HomeView.routeId);
      state = false;
    }

    if (text.isEmpty) {
      showSnackBar(context: context, content: 'Please add some text');
      return;
    }
    if (images.isNotEmpty) {
      shareImageTweet(images: images, text: text, context: context);
    } else {
      shareTextTweet(images: images, text: text, context: context);
    }
  }
}

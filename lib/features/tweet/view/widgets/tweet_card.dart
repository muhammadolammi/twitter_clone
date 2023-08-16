import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:twitter_clone/models/tweetmodel.dart';

class TweetCard extends ConsumerWidget {
  final Tweet tweet;
  const TweetCard({
    required this.tweet,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

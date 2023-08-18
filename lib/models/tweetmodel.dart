// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

import '../core/tweet_type_enum.dart';

@immutable
class Tweet {
  final String text;
  final List<String> hashtags;
  final String link;
  final List<String> imageLinks;
  final String uid;
  final TweetType tweetType;
  final DateTime tweetedAt;
  final List<String> likes;
  final List<String> commentIds;
  final String id;
  final int reshareCount;
  final String retweetedBy;
  final String repliedTo;
  const Tweet({
    required this.text,
    required this.hashtags,
    required this.link,
    required this.imageLinks,
    required this.uid,
    required this.tweetType,
    required this.tweetedAt,
    required this.likes,
    required this.commentIds,
    required this.id,
    required this.reshareCount,
    required this.retweetedBy,
    required this.repliedTo,
  });

  Tweet copyWith({
    String? text,
    List<String>? hashtags,
    String? link,
    List<String>? imageLinks,
    String? uid,
    TweetType? tweetType,
    DateTime? tweetedAt,
    List<String>? likes,
    List<String>? commentIds,
    String? id,
    int? reshareCount,
    String? retweetedBy,
    String? repliedTo,
  }) {
    return Tweet(
      text: text ?? this.text,
      hashtags: hashtags ?? this.hashtags,
      link: link ?? this.link,
      imageLinks: imageLinks ?? this.imageLinks,
      uid: uid ?? this.uid,
      tweetType: tweetType ?? this.tweetType,
      tweetedAt: tweetedAt ?? this.tweetedAt,
      likes: likes ?? this.likes,
      commentIds: commentIds ?? this.commentIds,
      id: id ?? this.id,
      reshareCount: reshareCount ?? this.reshareCount,
      retweetedBy: retweetedBy ?? this.retweetedBy,
      repliedTo: repliedTo ?? this.repliedTo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'hashtags': hashtags,
      'link': link,
      'imageLinks': imageLinks,
      'uid': uid,
      'tweetType': tweetType.type,
      'tweetedAt': tweetedAt.millisecondsSinceEpoch,
      'likes': likes,
      'commentIds': commentIds,
      'reshareCount': reshareCount,
      'retweetedBy': retweetedBy,
      'repliedTo': repliedTo,
    };
  }

  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      text: map['text'] as String,
      hashtags: List<String>.from((map['hashtags'] ?? []) as List<dynamic>)
          .cast<String>(), // Cast each element to String
      link: map['link'] as String, // Cast each element to String
      imageLinks: List<String>.from((map['imageLinks'] ?? []) as List<dynamic>)
          .cast<String>(), // Cast each element to String
      uid: map['uid'] as String,
      tweetType: (map['tweetType'] as String)
          .toTweetTypeEnum(), // Make sure to define and implement this conversion correctly
      tweetedAt: DateTime.fromMillisecondsSinceEpoch(map['tweetedAt'] as int),
      likes: List<String>.from((map['likes'] ?? []) as List<dynamic>)
          .cast<String>(), // Cast each element to String
      commentIds: List<String>.from((map['commentIds'] ?? []) as List<dynamic>)
          .cast<String>(), // Cast each element to String
      id: map['\$id'] as String,
      reshareCount: map['reshareCount'] as int,
      retweetedBy: map['retweetedBy'] as String,
      repliedTo: map['repliedTo'] as String,
    );
  }
// In this code, I've added .cast<String>() to each of the List.from statements. This is necessary because the .from method expects an iterable of a specific type, and sometimes the type inference might not be accurate when working with dynamic types. Casting the elements of the list explicitly should ensure that you're dealing with a list of strings.

  // factory Tweet.fromMap(Map<String, dynamic> map) {
  //   return Tweet(
  //     text: map['text'] as String,
  //     hashtags: List<String>.from((map['hashtags'] as List<String>)),
  //     links: List<String>.from((map['links'] as List<String>)),
  //     imageLinks: List<String>.from((map['imageLinks'] as List<String>)),
  //     uid: map['uid'] as String,
  //     tweetType: (map['tweetType'] as String).toTweetTypeEnum(),
  //     tweetedAt: DateTime.fromMillisecondsSinceEpoch(map['tweetedAt'] as int),
  //     likes: List<String>.from((map['likes'] as List<String>)),
  //     commentIds: List<String>.from((map['commentIds'] as List<String>)),
  //     id: map['\$id'] as String,
  //     reshareCount: map['reshareCount'] as int,
  //     retweetedBy: map['retweetedBy'] as String,
  //     repliedTo: map['repliedTo'] as String,
  //   );
  // }

  @override
  String toString() {
    return 'Tweet(text: $text, hashtags: $hashtags, link: $link, imageLinks: $imageLinks, uid: $uid, tweetType: $tweetType, tweetedAt: $tweetedAt, likes: $likes, commentIds: $commentIds, id: $id, reshareCount: $reshareCount, retweetedBy: $retweetedBy, repliedTo: $repliedTo)';
  }

  @override
  bool operator ==(covariant Tweet other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        listEquals(other.hashtags, hashtags) &&
        other.link == link &&
        listEquals(other.imageLinks, imageLinks) &&
        other.uid == uid &&
        other.tweetType == tweetType &&
        other.tweetedAt == tweetedAt &&
        listEquals(other.likes, likes) &&
        listEquals(other.commentIds, commentIds) &&
        other.id == id &&
        other.reshareCount == reshareCount &&
        other.retweetedBy == retweetedBy &&
        other.repliedTo == repliedTo;
  }

  @override
  int get hashCode {
    return text.hashCode ^
        hashtags.hashCode ^
        link.hashCode ^
        imageLinks.hashCode ^
        uid.hashCode ^
        tweetType.hashCode ^
        tweetedAt.hashCode ^
        likes.hashCode ^
        commentIds.hashCode ^
        id.hashCode ^
        reshareCount.hashCode ^
        retweetedBy.hashCode ^
        repliedTo.hashCode;
  }
}

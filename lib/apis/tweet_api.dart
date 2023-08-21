import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../core/core.dart';
import 'package:appwrite/models.dart' as model;

import '../provider/provider.dart';

import '../constants/appwrite_consts.dart';
import '../models/tweetmodel.dart';

final tweetApiProvider = Provider((ref) {
  final db = ref.watch(appwriteDatabaseProvider);
  final realtime = ref.watch(appwriteRealtimeProvider);
  return TweetApi(db: db, realtime: realtime);
});

abstract class ITweetApi {
  FutureEither<Document> shareTweet(Tweet tweet);
  FutureEither<Document> updatereshareCount(Tweet tweet);

  FutureEither<Document> likeTweet(Tweet tweet);
  Future<List<Document>> getTweet();
  Stream<RealtimeMessage> getLatestTweets();
}

class TweetApi implements ITweetApi {
  final Databases _db;
  final Realtime _realtime;

  TweetApi({required Databases db, required Realtime realtime})
      : _db = db,
        _realtime = realtime;

  @override
  FutureEither<Document> shareTweet(Tweet tweet) async {
    try {
      final document = await _db.createDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.tweetCollectionId,
          documentId: tweet.id,
          data: tweet.toMap());
      return Either.right(document);
    } on AppwriteException catch (e, st) {
      return Either.left(
          Failure(e.message ?? 'Some Unexpected Error Occured', st));
    } catch (e, st) {
      return Either.left(Failure(e.toString(), st));
    }
  }

  @override
  Future<List<Document>> getTweet() async {
    final document = await _db.listDocuments(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.tweetCollectionId,
        queries: [Query.orderDesc('tweetedAt')]);
    return document.documents;
  }

  @override
  Stream<RealtimeMessage> getLatestTweets() {
    return _realtime.subscribe([
      'databases.${AppWriteConstants.databaseId}.collections.${AppWriteConstants.tweetCollectionId}.documents'
    ]).stream;
  }

  @override
  FutureEither<Document> likeTweet(Tweet tweet) async {
    try {
      final document = await _db.updateDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.tweetCollectionId,
          documentId: tweet.id,
          data: {
            'likes': tweet.likes,
          });
      return Either.right(document);
    } on AppwriteException catch (e, st) {
      return Either.left(
          Failure(e.message ?? 'Some Unexpected Error Occured', st));
    } catch (e, st) {
      return Either.left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEither<Document> updatereshareCount(Tweet tweet) async {
    try {
      final document = await _db.updateDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.tweetCollectionId,
          documentId: tweet.id,
          data: {
            'retweetCount': tweet.retweetCount,
          });
      return Either.right(document);
    } on AppwriteException catch (e, st) {
      return Either.left(
          Failure(e.message ?? 'Some Unexpected Error Occured', st));
    } catch (e, st) {
      return Either.left(Failure(e.toString(), st));
    }
  }
}

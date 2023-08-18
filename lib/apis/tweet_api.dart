import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/core/provider.dart';

import '../constants/appwrite_consts.dart';
import '../models/tweetmodel.dart';

final tweetApiProvider = Provider((ref) {
  final db = ref.watch(appwriteDatabaseProvider);
  return TweetApi(db: db);
});

abstract class ITweetApi {
  FutureEither<Document> shareTweet(Tweet tweet);
  Future<List<Document>> getTweet();
}

class TweetApi implements ITweetApi {
  final Databases _db;
  TweetApi({required Databases db}) : _db = db;

  @override
  FutureEither<Document> shareTweet(Tweet tweet) async {
    try {
      final document = await _db.createDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.tweetCollectionId,
          documentId: ID.unique(),
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
        collectionId: AppWriteConstants.tweetCollectionId);
    return document.documents;
  }
}

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/provider/provider.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:fpdart/fpdart.dart';

final userApiProvider = Provider((ref) {
  final db = ref.watch(appwriteDatabaseProvider);
  return UserApi(db: db);
});

abstract class IUserApi {
  FutureEitherVoid saveUserData({required User userModel});
  Future<model.Document> getUserDetails({required userId});
}

class UserApi implements IUserApi {
  final Databases _db;
  UserApi({required Databases db}) : _db = db;

  @override
  FutureEitherVoid saveUserData({required User userModel}) async {
    try {
      final document = await _db.createDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.userCollectionId,
          documentId: userModel.uid,
          data: userModel.toMap());
      return Either.right(document);
    } on AppwriteException catch (e, st) {
      return Either.left(
          Failure(e.message ?? 'Some Unexpected Error Occured', st));
    } catch (e, st) {
      return Either.left(Failure(e.toString(), st));
    }
  }

  @override
  Future<model.Document> getUserDetails({required userId}) {
    return _db.getDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.userCollectionId,
        documentId: userId);
  }
}

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/core/provider.dart';

final authApiProvider = Provider((ref) {
  final account = ref.watch(appWriteAccountProvider);
  return AuthApi(account: account);
});

abstract class IAuthApi {
  FutureEither<model.User> signup({
    required String password,
    required String email,
  });

  FutureEither<model.Session> logIn({
    required String password,
    required String email,
  });
  Future<model.User?> currentUserAccount();
}

class AuthApi implements IAuthApi {
  final Account _account;

  AuthApi({required Account account}) : _account = account;
  @override
  Future<model.User?> currentUserAccount() async {
    try {
      return await _account.get();
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  FutureEither<model.User> signup({
    required String password,
    required String email,
  }) async {
    try {
      final account = await _account.create(
          userId: ID.unique(), email: email, password: password);
      return Either.right(account);
    } on AppwriteException catch (e, stackTrace) {
      return Either.left(
          Failure(e.message ?? 'An Unexpected Errror Occured', stackTrace));
    } catch (e, stackTrace) {
      return Either.left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<model.Session> logIn(
      {required String password, required String email}) async {
    try {
      final session =
          await _account.createEmailSession(email: email, password: password);
      return Either.right(session);
    } on AppwriteException catch (e, stackTrace) {
      return Either.left(
          Failure(e.message ?? 'An Unexpected Error Occured', stackTrace));
    } catch (e, stackTrace) {
      return Either.left(Failure(e.toString(), stackTrace));
    }
  }
}

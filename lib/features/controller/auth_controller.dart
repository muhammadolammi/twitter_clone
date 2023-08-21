import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/apis/user_api.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/veiws/login_view.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:appwrite/models.dart' as model;
import 'package:twitter_clone/models/user_model.dart';

final getCurrentUserDataProvider = FutureProvider((ref) async {
  final userId = ref.watch(currentUserAccountProvider).asData?.value?.$id;
  final getUserData = ref.watch(getUserDataProvider(userId));
  return getUserData.asData?.value;
});

final getUserDataProvider = FutureProvider.family((ref, String? userId) async {
  final authController = ref.watch(authControllerProvider.notifier);

  return authController.getUserData(userId: userId);
});

final currentUserAccountProvider = FutureProvider((ref) async {
  final accountStatus = ref.watch(authControllerProvider.notifier);
  return accountStatus.currentUserAccount();
});

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  final authApi = ref.watch(authApiProvider);
  final userApi = ref.watch(userApiProvider);
  return AuthController(authApi: authApi, userApi: userApi);
});

class AuthController extends StateNotifier<bool> {
  final AuthApi _authApi;
  final UserApi _userApi;
  AuthController({required AuthApi authApi, required UserApi userApi})
      : _authApi = authApi,
        _userApi = userApi,
        super(false);

  Future<model.User?> currentUserAccount() => _authApi.currentUserAccount();

  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authApi.signup(password: password, email: email);
    state = false;
    res.fold((l) => showSnackBar(context: context, content: l.message),
        (r) async {
      User user = User(
          name: getName(email),
          email: email,
          uid: r.$id,
          profilePic: '',
          bannerPic: '',
          bio: '',
          followers: const [],
          following: const [],
          isTwitterBlue: false);
      final r2 = await _userApi.saveUserData(userModel: user);
      r2.fold((l) => showSnackBar(content: l.message, context: context), (r) {
        showSnackBar(context: context, content: 'Account Created');
        Navigator.pushNamed(context, LoginView.routeId);
      });
    });
  }

  void logIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authApi.logIn(password: password, email: email);
    state = false;
    res.fold((l) => showSnackBar(context: context, content: l.message), (r) {
      showSnackBar(context: context, content: 'Logged In Succesful');
      Navigator.pushNamed(context, HomeView.routeId);
    });
  }

  Future<User> getUserData({required userId}) async {
    final document = await _userApi.getUserDetails(userId: userId);
    final updatedUser = User.fromMap(document.data);
    return updatedUser;
  }
}

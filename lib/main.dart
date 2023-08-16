import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/auth/veiws/login_view.dart';
import 'package:twitter_clone/features/auth/veiws/signup_view.dart';
import 'package:twitter_clone/features/controller/auth_controller.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:twitter_clone/features/tweet/view/tweet_page_view.dart';
import 'package:twitter_clone/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.demangleStackTrace = (StackTrace stack) {
    // Trace and Chain are classes in package:stack_trace
    if (stack is Trace) {
      return stack.vmTrace;
    }
    if (stack is Chain) {
      return stack.toTrace().vmTrace;
    }
    return stack;
  };
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountStatus = ref.watch(currentUserAccountProvider);
    return MaterialApp(
      routes: {
        LoginView.routeId: (context) => const LoginView(),
        SignUpView.routeId: (context) => const SignUpView(),
        HomeView.routeId: (context) => const HomeView(),
        TweetPage.routeId: (context) => const TweetPage(),
      },
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      // home: showImages(),
      home: accountStatus.when(
        data: (user) {
          if (user != null) {
            return const HomeView();
          }
          return const SignUpView();
        },
        error: (error, st) {
          return ErrorPage(
            error: error.toString(),
          );
        },
        loading: () => const LoadingPage(),
      ),
    );
  }
}

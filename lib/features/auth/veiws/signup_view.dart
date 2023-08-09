import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/auth/veiws/login_view.dart';
import 'package:twitter_clone/features/controller/auth_controller.dart';
import 'package:twitter_clone/features/widgets/auth_textfield.dart';
import 'package:twitter_clone/theme/theme.dart';

class SignUpView extends ConsumerStatefulWidget {
  static String routeId = 'signUpRoute';

  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appBar = UiConstants.appbar();
  final _email_controller = TextEditingController();
  final _password_controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email_controller.dispose();
    _password_controller.dispose();
  }

  void onSignUp() {
    final res = ref.read(authControllerProvider.notifier);
    return res.signUp(
        email: _email_controller.text,
        password: _password_controller.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appBar,
      body: isLoading
          ? const Loader()
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(children: [
                    //textfield 1
                    AuthField(
                      controller: _email_controller,
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    //textfield 2
                    AuthField(
                      controller: _password_controller,
                      hintText: 'Password',
                    ),

                    const SizedBox(
                      height: 40,
                    ),
                    //button
                    Align(
                      alignment: Alignment.topRight,
                      child: RoundedSmallButton(onTap: onSignUp, label: 'Done'),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    // text span
                    RichText(
                      text: TextSpan(
                          text: "Already have an account?",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: ' Login',
                              style: const TextStyle(
                                color: Pallete.blueColor,
                                fontSize: 16,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, LoginView.routeId);
                                },
                            ),
                          ]),
                    )
                  ]),
                ),
              ),
            ),
    );
  }
}

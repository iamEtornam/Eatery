import 'package:eatery/components/custom_buttons.dart';
import 'package:eatery/components/custom_color.dart';
import 'package:eatery/components/custom_text.dart';
import 'package:eatery/components/custom_textfield.dart';
import 'package:eatery/components/squared_checkbox.dart';
import 'package:eatery/features/auth/auth_provider.dart';
import 'package:eatery/features/auth/auth_repository.dart';
import 'package:eatery/resources/resources.dart';
import 'package:eatery/router.dart';
import 'package:eatery/services/injection_container.dart';
import 'package:eatery/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  Widget _child = const SizedBox();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth >= 480) {
          _child = Row(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2,
                height: MediaQuery.sizeOf(context).height,
                child: Image.asset(
                  Images.loginBg,
                  fit: BoxFit.cover,
                ),
              ),
              const LoginFormWidget(),
            ],
          );
        } else {
          // If screen size is < 480
          _child = const SafeArea(
            child: Column(
              children: [
                LoginFormWidget(),
              ],
            ),
          );
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeInOutExpo,
          child: _child,
        );
        // if the screen width >= 480 i.e Wide Screen
      }),
    );
  }
}

final _authRepository = getIt.get<AuthRepository>();
final _authProvider = ChangeNotifierProvider<AuthProvider>(
    (ref) => AuthProvider(_authRepository));

class LoginFormWidget extends ConsumerStatefulWidget {
  const LoginFormWidget({super.key});
  @override
  ConsumerState<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends ConsumerState<LoginFormWidget> {
  final isCheckedListner = ValueNotifier(false);
  final formKey = GlobalKey<FormState>();
  final emailTextEditController = TextEditingController();
  final passwordTextEditController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = ref.read(_authProvider);
    return Expanded(
      child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(25),
            children: [
              Image.asset(
                Images.eateryLogo,
                width: 80,
                height: 80,
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(child: EateryTitle(text: 'Welcome to Eatery')),
              const SizedBox(
                height: 17,
              ),
              EateryTextField(
                textController: emailTextEditController,
                placeholderText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                label: 'Email address',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              EateryTextField(
                textController: passwordTextEditController,
                placeholderText: 'Enter your password',
                isPassword: true,
                maxLines: 1,
                label: 'Password',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () =>
                          context.pushNamed(RoutesName.passwordReset),
                      child: const Text(
                        'Forgot your password? Reset here',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                            decorationColor: EateryColor.main),
                      ))),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  ValueListenableBuilder<bool>(
                      valueListenable: isCheckedListner,
                      builder: (context, isChecked, child) {
                        return SquaredCheckbox(
                            isChecked: isChecked,
                            activeColor: EateryColor.secondary,
                            onTap: (x) => isCheckedListner.value = x);
                      }),
                  const SizedBox(width: 10),
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                            text: 'By continuing, you’re agreeing to our ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Satoshi'),
                            children: [
                          WidgetSpan(
                              child: InkWell(
                            onTap: () {},
                            child: Text(
                              'Terms & conditions',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: EateryColor.main),
                            ),
                          )),
                          TextSpan(
                            text: ' and ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          WidgetSpan(
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                'Privacy Policy.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: EateryColor.main),
                              ),
                            ),
                          )
                        ])),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              PrimaryButton(
                label: 'Login',
                onPressed: () async {
                  if (formKey.currentState!.validate() &&
                      isCheckedListner.value) {
                    await authProvider.login(
                        email: emailTextEditController.text,
                        password: passwordTextEditController.text);
                    if (!mounted) return;
                    if (authProvider.user != null) {
                      showAlert(context,
                          message: authProvider.message!,
                          alertType: ToastificationType.success);

                      context.goNamed(RoutesName.home);
                    } else {
                      if (authProvider.message == 'Email not confirmed') {
                        context.goNamed(RoutesName.otp,queryParameters: {
                          'email': emailTextEditController.text
                        });
                      }
                      showAlert(context,
                          message:
                              authProvider.message ?? 'Something went wrong',
                          alertType: ToastificationType.error);
                    }
                  } else if (!isCheckedListner.value) {
                    showAlert(context,
                        message: 'Please accept terms and conditions',
                        alertType: ToastificationType.warning);
                  } else {
                    showAlert(context, message: 'Check all the fields');
                  }
                },
              ),
              const SizedBox(height: 20),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () => context.pushNamed(RoutesName.register),
                      child: const Text(
                        'No account? Create one here',
                        textAlign: TextAlign.right,
                      ))),
              const SizedBox(height: 20),
            ],
          )),
    );
  }
}

import 'package:eatery/components/custom_buttons.dart';
import 'package:eatery/components/custom_text.dart';
import 'package:eatery/components/custom_textfield.dart';
import 'package:eatery/resources/resources.dart';
import 'package:flutter/material.dart';

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
                child: Image.asset(Images.loginBg,fit: BoxFit.cover,),
              ),
              const LoginFormWidget(),
            ],
          );
        } else {
          // If screen size is < 480
          _child = const Column(
            children: [
              LoginFormWidget(),
            ],
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

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final formKey = GlobalKey<FormState>();
  final emailTextEditController = TextEditingController();
  final passwordTextEditController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(25),
            children: [
              Image.asset(
                Images.eateryLogo,
                width: 120,
                height: 120,
              ),
              const SizedBox(
                height: 25,
              ),
              const Center(child: EateryTitle(text: 'Welcome to Eatery')),
              const SizedBox(
                height: 25,
              ),
              EateryTextField(
                textController: emailTextEditController,
                placeholderText: 'Enter your email',
                label: 'Email address',
              ),
              const SizedBox(height: 15),
              EateryTextField(
                textController: passwordTextEditController,
                placeholderText: 'Enter your password',
                label: 'Password',
              ),
              const SizedBox(
                height: 35,
              ),
              PrimaryButton(
                label: 'Login',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                  } else {}
                },
              )
            ],
          )),
    );
  }
}

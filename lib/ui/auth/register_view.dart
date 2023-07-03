import 'package:eatery/components/custom_buttons.dart';
import 'package:eatery/components/custom_color.dart';
import 'package:eatery/components/custom_text.dart';
import 'package:eatery/components/custom_textfield.dart';
import 'package:eatery/components/squared_checkbox.dart';
import 'package:eatery/resources/resources.dart';
import 'package:eatery/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2,
                height: MediaQuery.sizeOf(context).height,
                child: const RegisterFormWidget(),
              ),
            ],
          );
        } else {
          // If screen size is < 480
          _child = const Column(
            children: [
              Expanded(child: RegisterFormWidget()),
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

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({super.key});

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  bool isChecked = false;
  final formKey = GlobalKey<FormState>();
  final emailTextEditController = TextEditingController();
  final nameTextEditController = TextEditingController();
  final resturantNameTextEditController = TextEditingController();
  final passwordTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
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
              const Center(child: EateryTitle(text: 'Create a new account')),
              const SizedBox(
                height: 17,
              ),
              EateryTextField(
                textController: nameTextEditController,
                placeholderText: 'Enter your name',
                label: 'Full name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              EateryTextField(
                textController: resturantNameTextEditController,
                placeholderText: 'Enter your restuarant name',
                label: 'Restuarant name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid Restuarant name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              EateryTextField(
                textController: emailTextEditController,
                keyboardType: TextInputType.emailAddress,
                placeholderText: 'Enter your email',
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
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  SquaredCheckbox(
                    isChecked: isChecked,
                    activeColor: EateryColor.secondary,
                    onTap: (x) => setState(() => isChecked = x),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                            text: 'By continuing, you’re agreeing to our ',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Satoshi'),
                            children: [
                          WidgetSpan(
                              child: InkWell(
                            onTap: () {},
                            child: Text(
                              'Terms & conditions',
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                                .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          WidgetSpan(
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                'Privacy Policy.',
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                label: 'Create account',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.goNamed(RoutesName.home);
                  } else {}
                },
              ),
              const SizedBox(height: 20),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () => context.pushNamed(RoutesName.auth),
                      child: const Text(
                        'Already have an account? Login',
                        textAlign: TextAlign.right,
                      ))),
              const SizedBox(height: 20),
            ],
          )),
    );
  }
}

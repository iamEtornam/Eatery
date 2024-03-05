import 'package:eatery/components/custom_buttons.dart';
import 'package:eatery/components/custom_text.dart';
import 'package:eatery/components/custom_textfield.dart';
import 'package:eatery/features/auth/auth_provider.dart';
import 'package:eatery/features/auth/auth_repository.dart';
import 'package:eatery/resources/resources.dart';
import 'package:eatery/router.dart';
import 'package:eatery/services/injection_container.dart';
import 'package:eatery/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PasswordResetView extends StatefulWidget {
  const PasswordResetView({super.key});

  @override
  State<PasswordResetView> createState() => _PasswordResetViewState();
}

class _PasswordResetViewState extends State<PasswordResetView> {
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
                child: const PasswordResetFormWidget(),
              ),
            ],
          );
        } else {
          // If screen size is < 480
          _child = const SafeArea(
            child: Column(
              children: [
                Expanded(child: PasswordResetFormWidget()),
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

class PasswordResetFormWidget extends ConsumerStatefulWidget {
  const PasswordResetFormWidget({super.key});

  @override
  ConsumerState<PasswordResetFormWidget> createState() =>
      _PasswordResetFormWidgetState();
}

class _PasswordResetFormWidgetState
    extends ConsumerState<PasswordResetFormWidget> {
  final formKey = GlobalKey<FormState>();
  final emailTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = ref.read(_authProvider);
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
              const Center(
                  child: EateryTitle(text: 'Reset your Eatery password')),
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
              const SizedBox(
                height: 25,
              ),
              PrimaryButton(
                label: 'Reset',
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await authProvider.forgotPassword(
                        email: emailTextEditController.text);
                    if (!context.mounted) return;

                    showAlert(context,
                        message: authProvider.message!,
                        alertType: ToastificationType.success);

                    context.goNamed(RoutesName.auth);
                  } else {
                    showAlert(context,
                        message: 'Check the email address',
                        alertType: ToastificationType.warning);
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          )),
    );
  }
}

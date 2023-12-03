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
import 'package:supabase/supabase.dart';

class OptVerifyView extends StatelessWidget {
  const OptVerifyView({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    Widget child = const SizedBox();

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth >= 480) {
          child = Row(
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
                child: OptVerifyFormWidget(
                  email: email,
                ),
              ),
            ],
          );
        } else {
          // If screen size is < 480
          child = SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: OptVerifyFormWidget(
                    email: email,
                  ),
                ),
              ],
            ),
          );
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeInOutExpo,
          child: child,
        );
        // if the screen width >= 480 i.e Wide Screen
      }),
    );
  }
}

final _authRepository = getIt.get<AuthRepository>();
final _authProvider = ChangeNotifierProvider<AuthProvider>(
    (ref) => AuthProvider(_authRepository));

class OptVerifyFormWidget extends ConsumerStatefulWidget {
  const OptVerifyFormWidget({super.key, required this.email});

  final String email;

  @override
  ConsumerState<OptVerifyFormWidget> createState() =>
      _OptVerifyFormWidgetState();
}

class _OptVerifyFormWidgetState extends ConsumerState<OptVerifyFormWidget> {
  final formKey = GlobalKey<FormState>();
  final otpTextEditController = TextEditingController();

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
                  child: EateryTitle(text: 'Enter OTP sent to your email')),
              const SizedBox(
                height: 17,
              ),
              EateryTextField(
                textController: otpTextEditController,
                placeholderText: 'Enter OTP',
                keyboardType: TextInputType.text,
                label: 'OTP sent to your email',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid OTP';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              PrimaryButton(
                label: 'Verify',
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await authProvider.verifyOTP(
                        email: widget.email,
                        otp: otpTextEditController.text.trim(),
                        type: OtpType.signup);
                    if (!mounted) return;
                    if (authProvider.user != null) {
                      showAlert(context,
                          message: authProvider.message!,
                          alertType: ToastificationType.success);

                      context.goNamed(RoutesName.completeProfile);
                    } else {
                      showAlert(context,
                          message:
                              authProvider.message ?? 'Something went wrong',
                          alertType: ToastificationType.error);
                    }
                  } else {
                    showAlert(context,
                        message: 'Check the OTP',
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

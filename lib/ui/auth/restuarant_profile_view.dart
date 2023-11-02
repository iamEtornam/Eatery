import 'dart:io';

import 'package:eatery/components/custom_bottomsheet.dart';
import 'package:eatery/components/custom_buttons.dart';
import 'package:eatery/components/custom_color.dart';
import 'package:eatery/components/custom_textfield.dart';
import 'package:eatery/resources/resources.dart';
import 'package:eatery/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class RestaurantProfileView extends StatefulWidget {
  const RestaurantProfileView({super.key});

  @override
  State<RestaurantProfileView> createState() => _RestaurantProfileViewState();
}

class _RestaurantProfileViewState extends State<RestaurantProfileView> {
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
                child: const RestaurantLogo(),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2,
                height: MediaQuery.sizeOf(context).height,
                child: const BasicInfo(),
              ),
            ],
          );
        } else {
          // If screen size is < 480
          _child = const Column(
            children: [
              RestaurantLogo(),
              BasicInfo(),
            ],
          );
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeInOutExpo,
          child: Column(
            children: [
              const SizedBox(
                height: kToolbarHeight,
              ),
              Expanded(child: _child),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 4,
                child: PrimaryButton(
                  label: 'Save',
                  onPressed: () {
                    context.goNamed(RoutesName.home);
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
        // if the screen width >= 480 i.e Wide Screen
      }),
    );
  }
}

class BasicInfo extends StatefulWidget {
  const BasicInfo({super.key});

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  final formKey = GlobalKey<FormState>();
  final restaurantNameTextEditController = TextEditingController();
  final restaurantLocationTextEditController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          EateryTextField(
            textController: restaurantNameTextEditController,
            placeholderText: 'Enter your restaurant name',
            label: 'Restaurant name',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a valid Restaurant name';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          EateryTextField(
            textController: restaurantNameTextEditController,
            placeholderText: 'Enter your restaurant name',
            label: 'Restaurant name',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a valid Restaurant name';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class RestaurantLogo extends StatefulWidget {
  const RestaurantLogo({super.key});

  @override
  State<RestaurantLogo> createState() => _RestaurantLogoState();
}

class _RestaurantLogoState extends State<RestaurantLogo> {
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(25),
      children: [
        Center(
          child: SizedBox(
            width: 180,
            height: 180,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: imageFile != null
                      ? Image.file(
                          imageFile!,
                          width: 180,
                          height: 180,
                          fit: BoxFit.fill,
                        )
                      : CircleAvatar(
                          radius: 60,
                          backgroundColor: EateryColor.grey2.withOpacity(.3),
                          child: SvgPicture.asset(Vectors.camera),
                        ),
                ),
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.black38,
                ),
                Align(
                  alignment: Alignment.center,
                  child: FloatingActionButton.small(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    onPressed: () async {
                      final res = await showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return CustomBottomsheet(
                                title: 'Options',
                                onCloseAction: () => Navigator.of(context).pop(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      onTap: () => Navigator.of(context).pop(ImageSource.camera),
                                      contentPadding: EdgeInsets.zero,
                                      leading: SvgPicture.asset(
                                        Vectors.camera,
                                      ),
                                      title: Text(
                                        'Camera',
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                            ),
                                      ),
                                    ),
                                    const Divider(),
                                    ListTile(
                                      onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                                      contentPadding: EdgeInsets.zero,
                                      leading: SvgPicture.asset(
                                        Vectors.gallery,
                                      ),
                                      title: Text(
                                        'Gallery',
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                            ),
                                      ),
                                    ),
                                  ],
                                ));
                          });

                      if (res == null) return;
                      final xFile = await ImagePicker().pickImage(source: res, imageQuality: 60);
                      if (xFile == null) return;
                      if (!mounted) return;

                      try {
                        setState(() {
                          imageFile = File(xFile.path);
                        });

                        //   void Function() cancel = BotToast.showAttachedWidget(
                        //     attachedBuilder: (_) => const MizormorLoader(
                        //       message: 'Checking one or two things... Please hang tight 😉',
                        //     ),
                        //     enableSafeArea: true,
                        //     onlyOne: true,
                        //     allowClick: false,
                        //     ignoreContentClick: true,
                        //     backgroundColor: const Color.fromRGBO(0, 0, 0, .5),
                        //     target: Offset(
                        //         FractionalOffset.bottomCenter.dx, FractionalOffset.bottomCenter.dy),
                        //   );
                        //   File? compressedPhoto =
                        //       await compressImagesFlutter.compressImage(xFile.path, quality: 50);

                        //   final upload =
                        //       await uploadRepository.uploadAvatar(compressedPhoto!, isUser: true);
                        //   if (!mounted) return;
                        //   cancel();
                        //   if (upload) {
                        //     showSuccess(context, 'User profile picture updated', title: 'Success');
                        //   } else {
                        //     showError(context, 'Failed to upload user profile picture');
                        //   }
                      } catch (e) {
                        if (!mounted) return;

                        // showError(context, '$e');
                      }
                    },
                    elevation: 0,
                    child: Center(
                      child: SvgPicture.asset(
                        Vectors.camera,
                        width: 20,
                        height: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 35,
        ),
      ],
    );
  }
}

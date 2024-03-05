import 'dart:io';

import 'package:eatery/components/custom_bottomsheet.dart';
import 'package:eatery/components/custom_buttons.dart';
import 'package:eatery/components/custom_color.dart';
import 'package:eatery/components/custom_textfield.dart';
import 'package:eatery/features/auth/auth_provider.dart';
import 'package:eatery/features/auth/auth_repository.dart';
import 'package:eatery/resources/resources.dart';
import 'package:eatery/router.dart';
import 'package:eatery/services/injection_container.dart';
import 'package:eatery/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

final _authRepository = getIt.get<AuthRepository>();
final _authProvider = ChangeNotifierProvider<AuthProvider>(
    (ref) => AuthProvider(_authRepository));

class RestaurantProfileView extends ConsumerStatefulWidget {
  const RestaurantProfileView({super.key});

  @override
  ConsumerState<RestaurantProfileView> createState() =>
      _RestaurantProfileViewState();
}

class _RestaurantProfileViewState extends ConsumerState<RestaurantProfileView> {
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
                child: const BasicInfo(),
              ),
            ],
          );
        } else {
          // If screen size is < 480
          _child = const SafeArea(
            child: Column(
              children: [
                Expanded(child: BasicInfo()),
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

class BasicInfo extends ConsumerStatefulWidget {
  const BasicInfo({super.key});

  @override
  ConsumerState<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends ConsumerState<BasicInfo> {
  final formKey = GlobalKey<FormState>();
  final restaurantNameTextEditController = TextEditingController();
  final restaurantLocationTextEditController = TextEditingController();
  final restaurantCoordinatesTextEditController =
      TextEditingController(text: '1233,1322');
  XFile? imageFile;
  double latitude = 0.0;
  double longitude = 0.0;

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
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: imageFile != null
                          ? Image.file(
                              File(imageFile!.path),
                              width: 180,
                              height: 180,
                              fit: BoxFit.fill,
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundColor:
                                  EateryColor.grey2.withOpacity(.3),
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
                                    onCloseAction: () =>
                                        Navigator.of(context).pop(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          onTap: () => Navigator.of(context)
                                              .pop(ImageSource.camera),
                                          contentPadding: EdgeInsets.zero,
                                          leading: SvgPicture.asset(
                                            Vectors.camera,
                                          ),
                                          title: Text(
                                            'Camera',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                ),
                                          ),
                                        ),
                                        const Divider(),
                                        ListTile(
                                          onTap: () => Navigator.of(context)
                                              .pop(ImageSource.gallery),
                                          contentPadding: EdgeInsets.zero,
                                          leading: SvgPicture.asset(
                                            Vectors.gallery,
                                          ),
                                          title: Text(
                                            'Gallery',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ));
                              });

                          if (res == null) return;
                          final xFile = await ImagePicker()
                              .pickImage(source: res, imageQuality: 60);
                          if (xFile == null) return;
                          if (!context.mounted) return;

                          setState(() {
                            imageFile = xFile;
                          });
                        },
                        elevation: 0,
                        child: Center(
                          child: SvgPicture.asset(
                            Vectors.camera,
                            width: 20,
                            height: 20,
                            colorFilter: Colors.black.asSvgColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
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
              textController: restaurantLocationTextEditController,
              placeholderText: 'Enter your restaurant location',
              label: 'Restaurant location',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a valid Restaurant location';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () async {
                developerLog('hello');
                try {
                  final location = Location();

                  // bool serviceEnabled;
                  // PermissionStatus permissionGranted;

                  // serviceEnabled = await location.serviceEnabled();
                  // if (!serviceEnabled) {
                  //   serviceEnabled = await location.requestService();
                  //   if (!serviceEnabled) {
                  //     return;
                  //   }
                  // }

                  // permissionGranted = await location.hasPermission();
                  // if (permissionGranted == PermissionStatus.denied) {
                  //   permissionGranted = await location.requestPermission();
                  //   if (permissionGranted != PermissionStatus.granted) {
                  //     return;
                  //   }
                  // }

                  final locationData = await location.getLocation();
                  developerLog(locationData.toString());
                  setState(() {
                    latitude = locationData.latitude!;
                    longitude = locationData.longitude!;
                    restaurantCoordinatesTextEditController.text =
                        '$latitude, $longitude';
                  });
                } catch (e) {
                  developerLog(e.toString());
                }
              },
              child: EateryTextField(
                enabled: false,
                textController: restaurantCoordinatesTextEditController,
                placeholderText: 'Enter your restaurant coordinates',
                label: 'Restaurant coordinates',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid Restaurant coordinates';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(
              height: 25,
            ),
            PrimaryButton(
              label: 'Save',
              onPressed: () async {
                if (formKey.currentState!.validate() && imageFile != null) {
                  final saved = await authProvider.updateRestaurantProfile(
                      restaurantLocation:
                          restaurantLocationTextEditController.text,
                      restaurantName: restaurantLocationTextEditController.text,
                      username: restaurantNameTextEditController.text,
                      restaurantLogo: imageFile!,
                      restaurantLatLng: (
                        latitude: latitude,
                        longitude: longitude
                      ));
                  if (!context.mounted) return;
                  if (saved) {
                    showAlert(context,
                        message: authProvider.message!,
                        alertType: ToastificationType.success);

                    context.goNamed(RoutesName.home);
                  } else {
                    showAlert(context,
                        message: authProvider.message ?? 'Something went wrong',
                        alertType: ToastificationType.error);
                  }
                } else if (imageFile == null) {
                  showAlert(context,
                      message: 'Please upload restaurant logo',
                      alertType: ToastificationType.warning);
                } else {
                  showAlert(context,
                      message: 'Check the fields',
                      alertType: ToastificationType.warning);
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

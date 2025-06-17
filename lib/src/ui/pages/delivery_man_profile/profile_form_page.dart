import 'dart:developer' as dev;
import 'dart:developer';

import 'package:campuscravings/src/controllers/user_controller.dart';
import 'package:campuscravings/src/src.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../constants/storageHelper.dart';
import '../../../controllers/location_controller.dart';

@RoutePage()
class ProfileFormPage extends ConsumerStatefulWidget {
  final bool newUser;
  final String? password;
  final String? email;
  final String? uniName;
  const ProfileFormPage({
    this.password,
    this.email,
    this.uniName,
    super.key,
    required this.newUser,
  });

  @override
  ConsumerState createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends ConsumerState<ProfileFormPage> {
  final List<String> _roles = ['Student', 'Faculty'];
  late String _selectedRole;
  HttpAPIServices services = HttpAPIServices();
  File? image;
  Position? _locationData;

  @override
  void initState() {
    super.initState();
    getLocation();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedRole = _roles.first;
      if (!widget.newUser) {
        _loadUserProfile();
      }
    });
  }

  getLocation() async {
    _locationData = await Get.find<LocationController>().getCurrentLocation();
    dev.log(
      ".............user current Lat ${_locationData!.latitude.toString()} long ${_locationData!.latitude.toString()}",
    );
  }

  Future<void> _loadUserProfile() async {
    // Set isLoading to true in the provider
    ref.read(signUpProvider.notifier).state = {
      ...ref.read(signUpProvider),
      'isLoading': true,
    };
    try {
      final user = ref.watch(userControllerProvider)?.userInfo;
      ref.read(signUpProvider.notifier).state = {
        ...ref.read(signUpProvider),
        'firstName': user?.firstName,
        'lastName': user?.lastName,
        'phoneNumber': user?.phoneNumber,
        'networkImage': user?.imgUrl,
        'isLoading': false, // Reset isLoading
      };
    } catch (e) {
      showToast(context: context, "Failed to load profile");
      ref.read(signUpProvider.notifier).state = {
        ...ref.read(signUpProvider),
        'isLoading': false, // Reset isLoading on error
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final isIOS = Platform.isIOS;
    final signUpState = ref.watch(signUpProvider); // Watch the provider state

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Dimensions.paddingSizeLarge,
                      bottom: Dimensions.paddingSizeDefault,
                    ),
                    child: Row(
                      children: [
                        if (!widget.newUser)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeDefault,
                            ),
                            child: IconButton(
                              onPressed: () => context.maybePop(),
                              icon: Icon(
                                isIOS
                                    ? Icons.arrow_back_ios_new
                                    : Icons.arrow_back,
                                size: 28,
                              ),
                            ),
                          )
                        else
                          width(25),
                        Padding(
                          padding: EdgeInsets.only(
                            top: widget.newUser ? 12 : 4,
                          ),
                          child: Text(
                            widget.newUser
                                ? locale.profileSetUp
                                : locale.editProfile,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeExtraLarge,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        height(50),
                        Center(
                          child: InkWellButtonWidget(
                            onTap: () async {
                              FilePickerResult? result = await FilePicker
                                  .platform
                                  .pickFiles(type: FileType.image);

                              if (result != null) {
                                Uint8List? fileBytes =
                                    result.files.single.bytes;
                                String? path = result.files.single.path;

                                if (kIsWeb) {
                                  if (fileBytes != null) {
                                    setState(() {
                                      image = null;
                                    });

                                    String base64Image = base64Encode(
                                      fileBytes,
                                    );
                                    ref.read(signUpProvider.notifier).state = {
                                      ...ref.read(signUpProvider),
                                      'imgBase64': base64Image,
                                    };
                                  }
                                } else {
                                  if (path != null) {
                                    File file = File(path);
                                    setState(() {
                                      image = file;
                                    });

                                    final base64Image =
                                        await compressImageToBase64(file);

                                    if (base64Image != null) {
                                      ref
                                          .read(signUpProvider.notifier)
                                          .state = {
                                        ...ref.read(signUpProvider),
                                        'imgBase64':
                                            'data:image/${result.files.single.extension};base64,$base64Image',
                                      };

                                      log(
                                        "Base64 Length: ${base64Image.length}",
                                      );
                                    } else {
                                      log("Image compression failed.");
                                    }
                                  }
                                }
                              } else {
                                showToast(
                                  context: context,
                                  "Image not selected",
                                );
                              }
                            },
                            child: SizedBox(
                              width: 64,
                              height: 64,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            image != null
                                                ? FileImage(image!)
                                                : signUpState['networkImage'] !=
                                                    null
                                                ? NetworkImage(
                                                  signUpState['networkImage'],
                                                )
                                                : const NetworkImage(
                                                      'https://images.app.goo.gl/him1uAKDAzpZeGW29',
                                                    )
                                                    as ImageProvider,
                                      ),
                                      color: Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: SvgAssets(
                                      'edit',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        height(50),
                        CustomTextField(
                          textInputAction: TextInputAction.next,
                          label:
                              widget.newUser
                                  ? 'Enter First Name*'
                                  : locale.firstName,
                          initialValue: signUpState['firstName'],
                          onChanged: (value) {
                            ref.read(signUpProvider.notifier).state = {
                              ...signUpState,
                              'firstName': value,
                            };
                          },
                        ),
                        height(16),
                        CustomTextField(
                          textInputAction: TextInputAction.next,
                          label:
                              widget.newUser
                                  ? "Enter Last Name*"
                                  : locale.lastName,
                          initialValue: signUpState['lastName'],
                          onChanged: (value) {
                            ref.read(signUpProvider.notifier).state = {
                              ...signUpState,
                              'lastName': value,
                            };
                          },
                        ),
                        height(16),
                        CustomTextField(
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number,
                          label:
                              widget.newUser
                                  ? "Enter Phone Number*"
                                  : locale.phoneNumber,
                          initialValue: signUpState['phoneNumber'],
                          onChanged: (value) {
                            ref.read(signUpProvider.notifier).state = {
                              ...signUpState,
                              'phoneNumber': value,
                            };
                          },
                        ),
                        height(16),
                        // Padding(
                        //   padding: EdgeInsets.only(bottom: 3),
                        //   child: Text(
                        //     widget.newUser ? locale.selectRole : locale.role,
                        //     style: Theme.of(context).textTheme.bodySmall,
                        //   ),
                        // ),
                        // DropDownWidget(
                        //   universitiesList: _roles,
                        //   onChange: (value) {
                        //     setState(() {
                        //       _selectedRole = value!;
                        //     });
                        //   },
                        //   hintText: locale.selectRole,
                        // ),
                        height(12),
                        if (widget.newUser)
                          Row(
                            children: [
                              Consumer(
                                builder: (context, ref, child) {
                                  final isActive = ref.watch(
                                    registerForDeliveryProvider,
                                  );
                                  return Transform.scale(
                                    scale: 1.3,
                                    child: Checkbox(
                                      value: isActive,
                                      onChanged:
                                          (value) =>
                                              ref
                                                  .read(
                                                    registerForDeliveryProvider
                                                        .notifier,
                                                  )
                                                  .state = value!,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          5.0,
                                        ),
                                      ),
                                      side: WidgetStateBorderSide.resolveWith(
                                        (states) => const BorderSide(
                                          width: 1.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              width(7),
                              Text(
                                widget.newUser
                                    ? "Also Register as a Delivery Person"
                                    : locale.registerDelivery,
                                style: TextStyle(
                                  fontSize: Dimensions.fontSizeSmall,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff6C7278),
                                ),
                              ),
                            ],
                          ),
                        height(18),
                        Consumer(
                          builder: (context, ref, child) {
                            final isActive = ref.watch(
                              registerForDeliveryProvider,
                            );
                            final signUpNotifer = ref.watch(signUpProvider);
                            return RoundedButtonWidget(
                              btnTitle:
                                  widget.newUser
                                      ? locale.register
                                      // : isActive
                                      // ? locale.next
                                      : locale.save,
                              isLoading: signUpNotifer['isLoading'] ?? false,
                              onTap:
                                  widget.newUser
                                      ? () async {
                                        ref
                                            .read(signUpProvider.notifier)
                                            .state = {
                                          ...signUpNotifer,
                                          'isLoading': true,
                                        };
                                        try {
                                          final confirmPassword =
                                              widget.password;
                                          final email = widget.email;
                                          final university = widget.uniName;
                                          print(
                                            'image: ${signUpNotifer['imgBase64']}',
                                          );
                                          if (signUpNotifer['firstName']!
                                              .isEmpty) {
                                            showToast(
                                              context: context,
                                              "First name is required",
                                            );
                                            return;
                                          }
                                          if (signUpNotifer['lastName']!
                                              .isEmpty) {
                                            showToast(
                                              context: context,
                                              "Last name is required",
                                            );
                                            return;
                                          }
                                          if (signUpNotifer['phoneNumber']!
                                              .isEmpty) {
                                            showToast(
                                              context: context,
                                              "Phone number is required",
                                            );
                                            return;
                                          }

                                          List<Placemark> placemarks =
                                              await placemarkFromCoordinates(
                                                _locationData!.latitude,
                                                _locationData!.longitude,
                                              );

                                          final response = await services.postAPI(
                                            url: '/auth/register/email',
                                            map: {
                                              "firstName":
                                                  signUpNotifer['firstName'],
                                              'universityName': university,
                                              "lastName":
                                                  signUpNotifer['lastName'],
                                              "phoneNumber":
                                                  signUpNotifer['phoneNumber'],
                                              "isCustomer": true,
                                              "isDelivery":
                                                  isActive, //for webhook later make this false
                                              "email": email,
                                              "imgUrl":
                                                  signUpNotifer['imgBase64'],
                                              "status": "active",
                                              "password": confirmPassword,
                                              "authMethod": "email",
                                              "deviceType":
                                                  Platform.isAndroid
                                                      ? "android"
                                                      : "ios",
                                              "addresses": [
                                                {
                                                  "address":
                                                      "${placemarks.first.locality.toString()}, ${placemarks.first.country.toString()}",
                                                  "coordinates": {
                                                    "type": "Point",
                                                    "coordinates": [
                                                      _locationData!.latitude,
                                                      _locationData!.longitude,
                                                    ],
                                                  },
                                                },
                                              ],

                                              "deviceId":
                                                  "dACC68I_SsOeP95zx5KyRc:APA91bGSili2JR9h6TnbhNUPoKeN1QsxDqpjOwNfJy_sCMgjhC-whoow8sOmXb-KlYbYZ_Qp8gl7c-EWTf1zK87rG8aWPHFmI7WuQ78qppVc_J9HJ7kagsnvDQg-5bFCtO0UJs2JZHHq",
                                            },
                                          );

                                          final data = jsonDecode(
                                            response.body,
                                          );
                                          log("JSON $data");
                                          if (response.statusCode == 201) {
                                            if (context.mounted) {
                                              context.pushRoute(
                                                OtpRoute(
                                                  email: email,
                                                  isRyder: isActive,
                                                ),
                                              );
                                            }
                                            final userId = data['user']['_id'];
                                            StorageHelper().saveUserId(userId);
                                          } else {
                                            showToast(
                                              data['message'] ??
                                                  'Registration failed.',
                                              context: context,
                                            );
                                          }
                                        } catch (e) {
                                          showToast(
                                            "Something went wrong. Try again.",
                                            context: context,
                                          );
                                        } finally {
                                          ref
                                              .read(signUpProvider.notifier)
                                              .state = {
                                            ...signUpNotifer,
                                            'isLoading': false,
                                          };
                                        }
                                      }
                                      : () async {
                                        try {
                                          if (signUpNotifer['firstName']!
                                              .isEmpty) {
                                            showToast(
                                              context: context,
                                              "First name is required",
                                            );
                                            return;
                                          }
                                          if (signUpNotifer['lastName']!
                                              .isEmpty) {
                                            showToast(
                                              context: context,
                                              "Last name is required",
                                            );
                                            return;
                                          }
                                          if (signUpNotifer['phoneNumber']!
                                              .isEmpty) {
                                            showToast(
                                              context: context,
                                              "Phone number is required",
                                            );
                                            return;
                                          }
                                          if (signUpNotifer['imgBase64']!
                                                  .isEmpty &&
                                              signUpNotifer['networkImage']!
                                                  .isEmpty) {
                                            showToast(
                                              context: context,
                                              "Image is required",
                                            );
                                            return;
                                          }
                                          ref
                                              .read(signUpProvider.notifier)
                                              .state = {
                                            ...signUpNotifer,
                                            'isLoading': true,
                                          };
                                          final response = await services.patchAPI(
                                            url: '/user/updateUser',
                                            map: {
                                              "firstName":
                                                  signUpNotifer['firstName'],
                                              "lastName":
                                                  signUpNotifer['lastName'],
                                              "imgUrl":
                                                  !signUpNotifer['imgBase64']
                                                          .isEmpty
                                                      ? signUpNotifer['imgBase64']
                                                      : signUpNotifer['networkImage'],
                                            },
                                          );
                                          final data = jsonDecode(
                                            response.body,
                                          );
                                          if (response.statusCode == 201 ||
                                              response.statusCode == 200) {
                                            // if (context.mounted) {
                                            //   context.maybePop();
                                            // }
                                            context.router.pushAndPopUntil(
                                              const MainRoute(),
                                              predicate: (_) => false,
                                            );
                                            showToast(
                                              "Profile updated successfully",
                                              context: context,
                                            );

                                            ref
                                                .read(
                                                  userControllerProvider
                                                      .notifier,
                                                )
                                                .updateBasicInfo(
                                                  firstName:
                                                      signUpNotifer['firstName'],
                                                  lastName:
                                                      signUpNotifer['lastName'],
                                                  phoneNumber:
                                                      signUpNotifer['phoneNumber'],
                                                  imgUrl:
                                                      data["userInfo"]["imgUrl"],
                                                );
                                          } else {
                                            showToast(
                                              data['message'] ??
                                                  'Registration failed.',
                                              context: context,
                                            );
                                          }
                                        } catch (e) {
                                          showToast(
                                            "Something went wrong. Try again.",
                                            context: context,
                                          );
                                        } finally {
                                          ref
                                              .read(signUpProvider.notifier)
                                              .state = {
                                            ...signUpNotifer,
                                            'isLoading': false,
                                          };
                                        }
                                      },
                              // : isActive
                              // ? () => context.pushRoute(
                              //   const StudentProfileDetailsRoute(),
                              // )
                              // : null,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Show loader when isLoading is true
          // if (signUpState['isLoading'] == true)
          //   const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

final registerForDeliveryProvider = StateProvider<bool>((ref) => false);
final signUpProvider = StateProvider<Map<String, dynamic>>(
  (ref) => {
    'firstName': '',
    'lastName': '',
    'phoneNumber': '',
    'isLoading': false,
    'imgBase64': '',
    'networkImage': '',
  },
);

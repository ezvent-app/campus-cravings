import 'package:campuscravings/src/src.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import '../../../constants/storageHelper.dart';

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
  HttpApiServices services = HttpApiServices();
  File? image;

  @override
  void initState() {
    _selectedRole = _roles.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final isIOS = Platform.isIOS;
    return Scaffold(
      body: SafeArea(
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
                            isIOS ? Icons.arrow_back_ios_new : Icons.arrow_back,
                            size: 28,
                          ),
                        ),
                      )
                    else
                      width(25),
                    Padding(
                      padding: EdgeInsets.only(top: widget.newUser ? 12 : 4),
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
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(type: FileType.image);

                          if (result != null) {
                            Uint8List? fileBytes = result.files.single.bytes;
                            String? path = result.files.single.path;

                            if (kIsWeb) {
                              if (fileBytes != null) {
                                setState(() {
                                  image = null;
                                });

                                String base64Image = base64Encode(fileBytes);
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

                                final bytes = await file.readAsBytes();
                                String base64Image = base64Encode(bytes);
                                ref.read(signUpProvider.notifier).state = {
                                  ...ref.read(signUpProvider),
                                  'imgBase64': base64Image,
                                };
                              }
                            }
                          } else {
                            showToast(context: context, "Image not selected");
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
                                child: SvgAssets('edit', width: 20, height: 20),
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
                              ? locale.enterFirstName
                              : locale.firstName,
                      onChanged: (value) {
                        final firstName = ref.read(signUpProvider);
                        ref.read(signUpProvider.notifier).state = {
                          ...firstName,
                          'firstName': value,
                        };
                      },
                    ),
                    height(16),
                    CustomTextField(
                      textInputAction: TextInputAction.next,
                      label:
                          widget.newUser
                              ? locale.enterLastName
                              : locale.lastName,
                      onChanged: (value) {
                        final lastName = ref.read(signUpProvider);
                        ref.read(signUpProvider.notifier).state = {
                          ...lastName,
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
                              ? locale.enterPhoneNumber
                              : locale.phoneNumber,
                      onChanged: (value) {
                        final phoneNumber = ref.read(signUpProvider);
                        ref.read(signUpProvider.notifier).state = {
                          ...phoneNumber,
                          'phoneNumber': value,
                        };
                      },
                    ),
                    height(16),
                    Padding(
                      padding: EdgeInsets.only(bottom: 3),
                      child: Text(
                        widget.newUser ? locale.selectRole : locale.role,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    DropDownWidget(
                      universitiesList: _roles,
                      onChange: (value) {
                        setState(() {
                          _selectedRole = value!;
                        });
                      },
                      hintText: locale.selectRole,
                    ),
                    height(12),
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
                                  borderRadius: BorderRadius.circular(5.0),
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
                              ? locale.registerForDelivery
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
                        final isActive = ref.watch(registerForDeliveryProvider);
                        final registerData = ref.watch(registerProvider);
                        var signUpNotifer = ref.watch(signUpProvider);
                        return RoundedButtonWidget(
                          btnTitle:
                              widget.newUser
                                  ? locale.register
                                  : isActive
                                  ? locale.next
                                  : locale.save,

                          isLoading: signUpNotifer['isLoading'] ?? false,
                          onTap:
                              widget.newUser
                                  ? () async {
                                    ref.read(signUpProvider.notifier).state = {
                                      ...signUpNotifer,
                                      'isLoading': true,
                                    };
                                    try {
                                      final confirmPassword = widget.password;
                                      final email = widget.email;
                                      final university = widget.uniName;
                                      print(
                                        'image: ${signUpNotifer['imgBase64']}',
                                      );
                                      if (signUpNotifer['firstName']!.isEmpty) {
                                        showToast(
                                          context: context,
                                          "First name is required",
                                        );
                                        return;
                                      }
                                      if (signUpNotifer['lastName']!.isEmpty) {
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
                                      final response = await services.postAPI(
                                        url: '/auth/register/email',
                                        map: {
                                          "firstName":
                                              signUpNotifer['firstName'],
                                          'universityName': university,
                                          "lastName": signUpNotifer['lastName'],
                                          "phoneNumber":
                                              signUpNotifer['phoneNumber'],
                                          "isCustomer": true,
                                          "isDelivery": isActive,
                                          "email": email,
                                          "imgUrl": signUpNotifer['imgBase64'],
                                          "status": "active",
                                          "password": confirmPassword,
                                          "authMethod": "email",
                                          "deviceType":
                                              Platform.isAndroid
                                                  ? "android"
                                                  : "ios",
                                          "deviceId":
                                              "dACC68I_SsOeP95zx5KyRc:APA91bGSili2JR9h6TnbhNUPoKeN1QsxDqpjOwNfJy_sCMgjhC-whoow8sOmXb-KlYbYZ_Qp8gl7c-EWTf1zK87rG8aWPHFmI7WuQ78qppVc_J9HJ7kagsnvDQg-5bFCtO0UJs2JZHHq",
                                        },
                                      );

                                      final data = jsonDecode(response.body);
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
                                  : isActive
                                  ? () => context.pushRoute(
                                    const StudentProfileDetailsRoute(),
                                  )
                                  : null,
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
  },
);

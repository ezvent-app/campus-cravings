import 'dart:developer';

import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/src.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

@RoutePage()
class DeliverySetupPage extends ConsumerStatefulWidget {
  final String? aboutYou;
  final String? batchYear;
  final List<String>? majors;
  final List<String>? minors;
  final List<String>? clubs;
  const DeliverySetupPage({
    super.key,
    this.aboutYou,
    this.batchYear,
    this.majors,
    this.minors,
    this.clubs,
  });

  @override
  ConsumerState<DeliverySetupPage> createState() => _DeliverySetupPageState();
}

class _DeliverySetupPageState extends ConsumerState<DeliverySetupPage> {
  bool _isLoading = false;
  bool _isImageUploaded = false;

  @override
  Widget build(BuildContext context) {
    HttpAPIServices services = HttpAPIServices();
    print("args: ${widget.aboutYou}");
    final locale = AppLocalizations.of(context)!;

    return BaseWrapper(
      label: locale.deliveryProfile,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              hintText: locale.ssn,
              label: locale.socialSecurityNumber,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.number,
              maxLength: 9,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(9),
              ],
              onChanged:
                  (value) =>
                      ref.read(deliverySetupProvider.notifier).state = {
                        ...ref.read(deliverySetupProvider),
                        'securityNumber': value,
                      },
            ),
            height(16),
            Padding(
              padding: EdgeInsets.only(bottom: 3),
              child: Text(
                locale.nationalID,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            _isImageUploaded
                ? OutlinedButton(
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(type: FileType.image);

                    if (result != null) {
                      Uint8List? fileBytes = result.files.single.bytes;
                      String? path = result.files.single.path;

                      if (kIsWeb) {
                        if (fileBytes != null) {
                          String base64Image = base64Encode(fileBytes);
                          ref.read(deliverySetupProvider.notifier).state = {
                            ...ref.read(deliverySetupProvider),
                            'imgBase64': base64Image,
                          };
                          setState(() {
                            _isImageUploaded = true;
                          });
                        }
                      } else {
                        if (path != null) {
                          File file = File(path);
                          final base64Image = await compressImageToBase64(file);

                          if (base64Image != null) {
                            ref.read(deliverySetupProvider.notifier).state = {
                              ...ref.read(deliverySetupProvider),
                              'imgBase64':
                                  'data:image/${result.files.single.extension};base64,$base64Image',
                            };
                            log("Base64 Length: ${base64Image.length}");
                          } else {
                            log("Image compression failed.");
                          }

                          setState(() {
                            _isImageUploaded = true;
                          });
                        }
                      }
                    } else {
                      showToast(context: context, "Image not selected");
                    }
                  }, // optional: disable after upload or keep the same logic
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: Colors.green),
                    foregroundColor: Colors.green,
                  ),
                  child: const Text(
                    "Image Uploaded ✅",
                    style: TextStyle(color: Colors.green),
                  ),
                )
                : OutlinedButton(
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(type: FileType.image);

                    if (result != null) {
                      Uint8List? fileBytes = result.files.single.bytes;
                      String? path = result.files.single.path;

                      if (kIsWeb) {
                        if (fileBytes != null) {
                          String base64Image = base64Encode(fileBytes);
                          ref.read(deliverySetupProvider.notifier).state = {
                            ...ref.read(deliverySetupProvider),
                            'imgBase64': base64Image,
                          };
                          setState(() {
                            _isImageUploaded = true;
                          });
                        }
                      } else {
                        if (path != null) {
                          File file = File(path);
                          final base64Image = await compressImageToBase64(file);

                          if (base64Image != null) {
                            ref.read(deliverySetupProvider.notifier).state = {
                              ...ref.read(deliverySetupProvider),
                              'imgBase64':
                                  'data:image/${result.files.single.extension};base64,$base64Image',
                            };
                            log("Base64 Length: ${base64Image.length}");
                          } else {
                            log("Image compression failed.");
                          }

                          setState(() {
                            _isImageUploaded = true;
                          });
                        }
                      }
                    } else {
                      showToast(context: context, "Image not selected");
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    foregroundColor: const Color(0xff525252),
                    side: const BorderSide(color: Color(0xff525252)),
                  ),
                  child: Text(locale.uploadCaptureImage),
                ),

            Row(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final deliveryProvider = ref.watch(deliveryProfileProvider);
                    return Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        value: deliveryProvider.isAgree,
                        onChanged:
                            (value) => ref
                                .read(deliveryProfileProvider.notifier)
                                .updateTermsAndConditions(value!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        side: WidgetStateBorderSide.resolveWith(
                          (states) =>
                              const BorderSide(width: 1.0, color: Colors.grey),
                        ),
                      ),
                    );
                  },
                ),
                Text(
                  'I agree with the ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                InkWellButtonWidget(
                  onTap: () {},
                  child: Text(
                    locale.termsConditions,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            height(16),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: locale.disclaimer,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(color: AppColors.black),
                  ),
                  TextSpan(
                    text: locale.socialSecurityInfo,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: locale.privacyPolicy,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.black,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  TextSpan(
                    text: '.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            height(24),
            Consumer(
              builder: (context, ref, child) {
                final deliveryProvider = ref.watch(deliveryProfileProvider);
                return RoundedButtonWidget(
                  isLoading: _isLoading,
                  btnTitle: locale.next,
                  onTap:
                      deliveryProvider.isAgree
                          ? () async {
                            setState(() {
                              _isLoading = true;
                            });

                            final securityNumber =
                                ref.read(
                                  deliverySetupProvider,
                                )["securityNumber"];
                            final imgBase64 =
                                ref.read(deliverySetupProvider)["imgBase64"];

                            if (securityNumber.isEmpty) {
                              setState(() => _isLoading = false);
                              showToast(context: context, "Please enter SSN.");
                              return;
                            }

                            if (securityNumber.length != 9) {
                              setState(() => _isLoading = false);
                              showToast(
                                context: context,
                                "SSN must be exactly 9 digits.",
                              );
                              return;
                            }

                            if (imgBase64.isEmpty) {
                              setState(() => _isLoading = false);
                              showToast(
                                context: context,
                                "Please upload your National ID or proof of work permission.",
                              );
                              return;
                            }

                            final response = await services.postAPI(
                              url: '/rider/riderRegistration',
                              map: {
                                "SSN": securityNumber,
                                "national_id_image_url": imgBase64,
                                "bio": widget.aboutYou,
                                "batch_year": widget.batchYear,
                                "majors": widget.majors,
                                "monirs": widget.minors,
                                "club_organizations": widget.clubs,
                                "location": {
                                  "lat": 37.7749,
                                  "lng": -122.4194,
                                }, // Replace with actual GPS
                              },
                            );

                            final data = jsonDecode(response.body);
                            final riderId = data['data']['user'];

                            String successUrl =
                                'http://restaurantmanager.campuscravings.co/$riderId?verified=true';
                            String failureUrl =
                                'http://restaurantmanager.campuscravings.co/login';

                            if (response.statusCode == 201 ||
                                response.statusCode == 200) {
                              StorageHelper().saveRiderId(riderId);
                              StorageHelper().saveRiderProfileComplete(true);

                              // Show loader before hitting onboarding API
                              setState(() => _isLoading = true);

                              RiderPayoutRepo repo = RiderPayoutRepo();
                              await repo.generateOnboardingLink(
                                riderId,
                                successUrl,
                                failureUrl,
                                context,
                              );

                              setState(
                                () => _isLoading = false,
                              ); // Stop loader after onboarding API
                            } else if (response.statusCode == 400) {
                              setState(() => _isLoading = false);
                              showToast(
                                context: context,
                                "You are already registered as a rider!",
                              );
                            } else {
                              setState(() => _isLoading = false);
                              showToast(
                                context: context,
                                "Something went wrong",
                              );
                            }
                          }
                          : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

final deliverySetupProvider = StateProvider<Map<String, dynamic>>(
  (ref) => {"securityNumber": '', "imgBase64": ''},
);

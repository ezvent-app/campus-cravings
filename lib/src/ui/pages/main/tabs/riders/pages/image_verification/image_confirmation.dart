import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/repository/rider_delivery_repo/delivery_repository.dart';
import 'package:campuscravings/src/src.dart';

class ImageConfirmationPage extends StatefulWidget {
  final XFile image;

  const ImageConfirmationPage({super.key, required this.image});

  @override
  State<ImageConfirmationPage> createState() => _ImageConfirmationPageState();
}

class _ImageConfirmationPageState extends State<ImageConfirmationPage> {
  bool _isLoading = false;

  Future<String> convertImageToBase64() async {
    final bytes = await File(widget.image.path).readAsBytes();
    return base64Encode(bytes);
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.confirmation,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.black,
      body: Column(
        children: [
          Center(
            child: Image.file(
              File(widget.image.path),
              width: double.infinity,
              height: size.height * 0.7,
              fit: BoxFit.cover,
            ),
          ),
          height(30),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final outerContext = context; // Capture outer context
                    showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return StatefulBuilder(
                          builder: (context, setStateDialog) {
                            return SimpleDialog(
                              contentPadding: EdgeInsets.all(30),
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    PngAsset("happy", width: 160, height: 160),
                                    Text(
                                      locale.deliveryComplete,
                                      style:
                                          Theme.of(
                                            dialogContext,
                                          ).textTheme.titleMedium,
                                    ),
                                    height(10),
                                    Text(
                                      locale.thankYouDeliveringOrderGreatJob,
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(
                                            dialogContext,
                                          ).textTheme.bodyMedium,
                                    ),
                                    height(30),
                                    RoundedButtonWidget(
                                      btnTitle: locale.ok,
                                      isLoading: _isLoading,
                                      onTap: () async {
                                        setStateDialog(() {
                                          _isLoading = true;
                                        });

                                        String? riderOrderId =
                                            StorageHelper().getRiderOrderId();
                                        String base64Image =
                                            await convertImageToBase64();
                                        RiderDelvieryRepo repo =
                                            RiderDelvieryRepo();
                                        final response = await repo
                                            .orderAcceptedByRider(
                                              riderOrderId!,
                                              {
                                                "image_url": base64Image,
                                                "status": "delivered",
                                              },
                                            );

                                        setStateDialog(() {
                                          _isLoading = false;
                                        });

                                        if (response.message ==
                                            'Order updated successfully') {
                                          Navigator.pop(dialogContext);
                                          StorageHelper().saveRiderOrderId(
                                            null,
                                          );
                                          outerContext.router.pushAndPopUntil(
                                            const MainRoute(),
                                            predicate: (_) => false,
                                          );
                                        } else {
                                          print("Failed to deliver order.");
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  ),
                  child: Text(
                    locale.submit,
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(color: Colors.black),
                  ),
                ),
                width(10),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(color: Colors.white),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  ),
                  child: Text(
                    locale.retry,
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:developer';

import 'package:campuscravings/src/src.dart';

class ImageCaptureScreen extends StatelessWidget {
  const ImageCaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.imageVerification,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.black,
      body: CameraAwesomeBuilder.awesome(
        onMediaCaptureEvent: (mediaCapture) async {
          mediaCapture.captureRequest.when(
            single: (singleCaptureRequest) async {
              final file = singleCaptureRequest.file;
              if (file != null) {
                log("Captured file path: ${file.path}");

                final exists = await File(file.path).exists();
                if (exists) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              ImageConfirmationPage(image: XFile(file.path)),
                    ),
                  );
                }
              }
            },
          );
        },

        saveConfig: SaveConfig.photo(),

        topActionsBuilder: (state) => SizedBox(),
        middleContentBuilder: (state) => SizedBox(),
        theme: AwesomeTheme(bottomActionsBackgroundColor: Colors.transparent),
        bottomActionsBuilder:
            (state) => AwesomeBottomActions(
              state: state,
              left: SizedBox(),
              right: FlashButtonWidget(state: state),
            ),
      ),
    );
  }
}

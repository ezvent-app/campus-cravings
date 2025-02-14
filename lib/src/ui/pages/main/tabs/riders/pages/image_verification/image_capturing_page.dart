import 'package:campus_cravings/main.dart';
import 'package:campus_cravings/src/src.dart';

class ImageCaptureScreen extends StatefulWidget {
  /// Default Constructor
  const ImageCaptureScreen({super.key});

  @override
  State<ImageCaptureScreen> createState() => _ImageCaptureScreenState();
}

class _ImageCaptureScreenState extends State<ImageCaptureScreen> {
  late CameraController controller;
  late XFile _image;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // Capture image and navigate to the confirmation screen
  Future<void> _captureImage() async {
    try {
      final image = await controller.takePicture();
      setState(() {
        _image = image;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageConfirmationPage(image: _image),
        ),
      );
      print("Captured");
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.imageVerification,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          CameraPreview(controller),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: _captureImage,
                    child: PngAsset(
                      "Shutter",
                      width: 72,
                      height: 72,
                    ),
                  ),
                  width(100),
                  PngAsset(
                    "Flash",
                    width: 48,
                    height: 48,
                  ),
                  width(20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

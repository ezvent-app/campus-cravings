import 'package:campuscravings/src/src.dart';

class FlashButtonWidget extends StatelessWidget {
  final CameraState state;
  final AwesomeTheme? theme;
  final Widget Function(FlashMode) iconBuilder;
  final void Function(SensorConfig, FlashMode) onFlashTap;

  FlashButtonWidget({
    super.key,
    required this.state,
    this.theme,
    Widget Function(FlashMode)? iconBuilder,
    void Function(SensorConfig, FlashMode)? onFlashTap,
  }) : iconBuilder = ((flashMode) {
         final String icon;
         switch (flashMode) {
           case FlashMode.none:
             icon = 'flash_off';
             break;
           case FlashMode.on:
             icon = 'flash_on';
             break;
           case FlashMode.auto:
             icon = 'flash_auto';
             break;
           case FlashMode.always:
             icon = 'Flash';
             break;
         }
         return Padding(
           padding: const EdgeInsets.only(right: 5),
           child: Column(children: [SvgAssets(icon)]),
         );
       }),
       onFlashTap =
           ((sensorConfig, flashMode) => sensorConfig.switchCameraFlash());

  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? AwesomeThemeProvider.of(context).theme;
    return StreamBuilder<SensorConfig>(
      stream: state.sensorConfig$,
      builder: (_, sensorConfigSnapshot) {
        if (!sensorConfigSnapshot.hasData) {
          return const SizedBox.shrink();
        }
        final sensorConfig = sensorConfigSnapshot.requireData;
        return StreamBuilder<FlashMode>(
          stream: sensorConfig.flashMode$,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox.shrink();
            }

            return AwesomeOrientedWidget(
              rotateWithDevice: theme.buttonTheme.rotateWithCamera,
              child: theme.buttonTheme.buttonBuilder(
                iconBuilder(snapshot.requireData),
                () => onFlashTap(sensorConfig, snapshot.requireData),
              ),
            );
          },
        );
      },
    );
  }
}

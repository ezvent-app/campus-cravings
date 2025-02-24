import 'package:campuscravings/src/src.dart';

class CustomAppBar extends ConsumerWidget {
  final String label;
  const CustomAppBar({super.key, this.label = ''});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isIOS = Platform.isIOS;
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 32),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: IconButton(
              onPressed: () => context.maybePop(),
              icon:
                  isIOS
                      ? Icon(Icons.arrow_back_ios, size: 28)
                      : Icon(Icons.arrow_back, size: 28),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }
}

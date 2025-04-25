import 'package:campuscravings/src/src.dart';

class BaseWrapper extends ConsumerWidget {
  final String label;
  final Widget child;
  final bool hasHorizontalPadding;
  const BaseWrapper({
    super.key,
    this.label = '',
    required this.child,
    this.hasHorizontalPadding = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),

      body: Column(
        children: [
          CustomAppBar(label: label),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: hasHorizontalPadding ? 25 : 0,
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:campuscravings/src/src.dart';

class ProductDescriptionWidget extends ConsumerStatefulWidget {
  final String description;
  const ProductDescriptionWidget({super.key,required this.description});

  @override
  ConsumerState createState() => _ProductDescriptionWidgetState();
}

class _ProductDescriptionWidgetState
    extends ConsumerState<ProductDescriptionWidget> {
  // final String description =
  //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: widget.description.length > 14
                  ? !_expanded
                  ? '${widget.description.substring(0, widget.description.length >= 150 ? 151 : widget.description.length)}...'
                  : widget.description
                  : widget.description,
              style: const TextStyle(
                fontFamily: 'SofiaPro',
                fontSize: 12,
                height: 1.5,
                color: Color(0xFF7D7D78),
              ),
            ),
            if (widget.description.length > 40)
              TextSpan(
                text:
                    ' ${locale.read} ${_expanded ? locale.less : locale.more}',
                style: const TextStyle(
                  fontFamily: 'SofiaPro',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accent,
                ),
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          _expanded = !_expanded;
                        });
                      },
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:campuscravings/src/src.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final bool dismissOnTapOutside;
  final bool obscureText;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int maxLines;
  final TextEditingController? controller;
  final EdgeInsets? contentPadding;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final Function(dynamic)? onSubmitted;
  final String? initialValue;

  const CustomTextField({
    this.initialValue,
    super.key,
    this.textInputType,
    this.textInputAction,
    this.label,
    this.controller,
    this.onSubmitted,
    this.onChanged,
    this.dismissOnTapOutside = true,
    this.obscureText = false,
    this.hintText,
    this.hintStyle,
    this.style,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
    this.contentPadding,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ??
        TextEditingController(text: widget.initialValue ?? "");
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue &&
        widget.controller == null) {
      _controller.text = widget.initialValue ?? "";
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(
              widget.label!,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        TextFormField(
          controller: _controller,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          obscureText: widget.obscureText,
          keyboardType: widget.textInputType,
          textInputAction: widget.textInputAction,
          onTapOutside: (event) {
            if (widget.dismissOnTapOutside) {
              FocusScope.of(context).unfocus();
            }
          },
          style:
              widget.style ??
              Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: AppColors.black),
          maxLines: widget.maxLines,
          obscuringCharacter: "*",
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle:
                widget.hintStyle ??
                Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: AppColors.hintColor),
            suffixIcon: widget.suffixIcon,
            contentPadding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              borderSide: const BorderSide(
                color: AppColors.textFieldBorder,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              borderSide: const BorderSide(
                color: AppColors.textFieldBorder,
                width: 1.5,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              maxWidth: 50,
              maxHeight: 50,
            ),
            prefixIcon: widget.prefixIcon,
          ),
        ),
      ],
    );
  }
}

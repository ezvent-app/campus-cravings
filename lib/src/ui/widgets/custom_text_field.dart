import 'package:campus_cravings/src/src.dart';

class CustomTextField extends ConsumerWidget {
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
  const CustomTextField({
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
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(label!, style: Theme.of(context).textTheme.bodySmall),
          ),
        TextFormField(
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          obscureText: obscureText,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          onTapOutside: (event) {
            if (dismissOnTapOutside) {
              FocusScope.of(context).unfocus();
            }
          },
          style:
              style ??
              Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: AppColors.black),
          maxLines: maxLines,
          obscuringCharacter: "*",
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle:
                hintStyle ??
                Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: AppColors.hintColor),
            suffixIcon: suffixIcon,
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
            prefixIcon: prefixIcon,
          ),
        ),
      ],
    );
  }
}

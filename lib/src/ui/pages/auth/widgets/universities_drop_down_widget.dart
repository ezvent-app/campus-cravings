import 'package:campus_cravings/src/src.dart';

class UniversityDropDownWidget extends StatelessWidget {
  const UniversityDropDownWidget({
    super.key,
    required this.universitiesList,
    required this.onChange,
  });

  final List universitiesList;
  final Function(dynamic) onChange;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        hintText: 'Select University',
        hintStyle: TextStyle(
          fontSize: Dimensions.fontSizeDefault,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: AppColors.textFieldBorder, width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: AppColors.textFieldBorder, width: 1.5)),
        prefixIconConstraints:
            const BoxConstraints(maxWidth: 50, maxHeight: 50),
      ),
      items: universitiesList
          .map((i) => DropdownMenuItem(
              value: i,
              child: Text(
                i,
                style: TextStyle(
                  fontSize: Dimensions.fontSizeDefault,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              )))
          .toList(),
      onChanged: onChange,
    );
  }
}

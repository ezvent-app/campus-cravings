import 'package:campuscravings/src/src.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    super.key,
    required this.universitiesList,
    required this.onChange,
    required this.hintText,
  });

  final List universitiesList;
  final Function(dynamic) onChange;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.textFieldBorder, width: 1.5),
          color: AppColors.white,
        ),
        child: DropdownButtonFormField(
          style: Theme.of(context).textTheme.bodyMedium,
          icon: Icon(Icons.keyboard_arrow_down),
          borderRadius: BorderRadius.circular(10),
          dropdownColor: AppColors.background,
          elevation: 0,
          alignment: AlignmentDirectional.centerStart,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
          items: universitiesList
              .map(
                (i) => DropdownMenuItem(
                  value: i,
                  child: Text(
                    i,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.black,
                        ),
                  ),
                ),
              )
              .toList(),
          onChanged: onChange,
        ),
      ),
    );
  }
}

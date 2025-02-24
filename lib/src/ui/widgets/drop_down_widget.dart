import 'package:campus_cravings/src/src.dart';

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
    return Builder(
      builder: (context) {
        return DropdownButtonFormField(
          style: Theme.of(context).textTheme.bodyMedium,
          icon: Icon(Icons.keyboard_arrow_down),
          borderRadius: BorderRadius.circular(10),
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.all(15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.textFieldBorder,
                width: 1.5,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.textFieldBorder,
                width: 1.5,
              ),
            ),
          ),
          items:
              universitiesList
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
        );
      },
    );
  }
}

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
          decoration: InputDecoration(
            hintText: hintText,
          ),
          items: universitiesList
              .map((i) => DropdownMenuItem(
                    value: i,
                    child: Text(
                      i,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.black),
                    ),
                  ))
              .toList(),
          onChanged: onChange,
        );
      },
    );
  }
}

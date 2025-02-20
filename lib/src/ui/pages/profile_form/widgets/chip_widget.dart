import 'package:campus_cravings/src/src.dart';

class ChipWrapWidget extends StatelessWidget {
  final List<String> items;
  final Function(String) onRemove;

  const ChipWrapWidget({
    required this.items,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children:
          items
              .map(
                (i) => InkWell(
                  onTap: () => onRemove(i),
                  child: Chip(
                    labelPadding: EdgeInsets.zero,
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          i,
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: AppColors.black),
                        ),

                        Icon(Icons.clear, size: 16),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }
}

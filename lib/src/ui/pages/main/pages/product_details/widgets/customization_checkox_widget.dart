import 'package:campuscravings/src/models/product_item_detail_model.dart';

import '../../../../../../src.dart';

class CustomizationCheckboxWidget extends ConsumerStatefulWidget {
  final List<CustomizationModel> customizations;

  const CustomizationCheckboxWidget({required this.customizations, super.key});

  @override
  ConsumerState<CustomizationCheckboxWidget> createState() =>
      _ConsumerCustomizationCheckboxWidgetState();
}

class _ConsumerCustomizationCheckboxWidgetState
    extends ConsumerState<CustomizationCheckboxWidget> {
  final List<CustomizationModel> _selectedCustomizations = [];

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final cartNotifier = ref.read(cartItemsProvider.notifier);
    return Column(
      children: [
        height(20),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25, right: 15),
              child: Text(
                "Customization",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: AppColors.black),
              ),
            ),
            Expanded(
              child: Text(
                "add toppings to your meal",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        ...List.generate(widget.customizations.length, (index) {
          final customization = widget.customizations[index];
          final isSelected = _selectedCustomizations.contains(customization);

          return CheckboxListTile(
            title: Text('${customization.name} (+\$${customization.price})'),
            value: isSelected,
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  _selectedCustomizations.add(customization);
                } else {
                  _selectedCustomizations.remove(customization);
                }

                cartNotifier.updateCustomization(
                  index,
                  _selectedCustomizations,
                );
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          );
        }),
      ],
    );
  }
}

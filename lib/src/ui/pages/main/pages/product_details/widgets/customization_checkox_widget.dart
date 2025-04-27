import 'package:campuscravings/src/models/product_item_detail_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../src.dart';

class CustomizationCheckboxWidget extends StatefulWidget {
  final List<CustomizationModel> customizations;

  const CustomizationCheckboxWidget({
    required this.customizations,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomizationCheckboxWidget> createState() => _CustomizationCheckboxWidgetState();
}

class _CustomizationCheckboxWidgetState extends State<CustomizationCheckboxWidget> {
  final List<CustomizationModel> _selectedCustomizations = [];

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
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
            Expanded(child: Text(
                "add toppings to your meal",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        ...widget.customizations.map((CustomizationModel customization) {
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
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          );
        })
      ],
    );
  }
}

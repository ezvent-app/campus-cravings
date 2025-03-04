import 'package:campuscravings/src/constants/config.dart';
import 'package:campuscravings/src/src.dart';
import 'package:flutter/material.dart';

class SortByModel {
  final String title;
  final int index;

  SortByModel({required this.title, required this.index});
}

List<SortByModel> sortByList = [
  SortByModel(title: 'Relevance (default)', index: 0),
  SortByModel(title: 'Fast Delivery', index: 1),
  SortByModel(title: 'Distance', index: 2),
];

void showSortBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allows custom height
    builder: (context) {
      int selectedIndex = 0; // Default selection inside bottom sheet

      return StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height(20),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Sort by",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: sortByList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final sort = sortByList[index];
                      bool isSelected = selectedIndex == sort.index;
                      return ListTile(
                        title: Text(
                          sort.title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: InkWellButtonWidget(
                          onTap: () {
                            setState(() {
                              selectedIndex = sort.index;
                            });
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: isSelected ? Colors.black : Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: isSelected
                                ? Center(
                                    child: Container(
                                      width: 5,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

import 'package:campus_cravings/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SizeSelectorWidget extends ConsumerStatefulWidget {
  const SizeSelectorWidget({super.key});

  @override
  ConsumerState createState() => _SizeSelectorWidgetState();
}

class _SizeSelectorWidgetState extends ConsumerState<SizeSelectorWidget> {
  int _selectedSize = 0;
  final List<ProductSize> sizes = const [
    ProductSize(label: 'Size M', value: 0),
    ProductSize(label: 'Size L', value: 4),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25, right: 15),
              child: Text(
                'Size',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Choose anyone from the options',
                style: TextStyle(
                    color: Color(0xff878E9B),
                    fontSize: 15,
                    fontWeight: FontWeight.w400
                ),
              ),
            ),
          ],
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: sizes.length,
          padding: const EdgeInsets.only(top: 10),
          itemBuilder: (context, index) {
            final size = sizes[index];
            return InkWell(
              onTap: (){
                setState(() {
                  _selectedSize = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _selectedSize == index ? AppColors.accent : AppColors.dividerColor,
                          width: _selectedSize == index ? 6 : 1,
                        )
                      ),
                    ),
                    Text(
                      size.label,
                      style: const TextStyle(
                          color: Color(0xff2E3138)
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '+${size.value.toStringAsFixed(2)}\$',
                      style: const TextStyle(
                        color: Color(0xff2E3138)
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: AppColors.dividerColor,
              height: 0,
              endIndent: 25,
              indent: 25,
            );
          },
        ),
      ],
    );
  }
}

class ProductSize{
  final String label;
  final double value;
  
  const ProductSize({
   required this.label, 
   required this.value, 
  });
}

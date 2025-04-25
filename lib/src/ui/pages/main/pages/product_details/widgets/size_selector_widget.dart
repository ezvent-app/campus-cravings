import 'package:campuscravings/src/controllers/product_details_controller.dart';
import 'package:campuscravings/src/src.dart';
import 'package:get/get.dart';

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
    final locale = AppLocalizations.of(context)!;
    final cartNotifier = ref.read(cartItemsProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25, right: 15),
              child: Text(
                locale.size,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: AppColors.black),
              ),
            ),
            Expanded(
              child: Text(
                locale.chooseAnyoneFromTheOptions,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        GetBuilder<ProductDetailsController>(
          builder: (controller) {
            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.productItemDetailModel?.sizes.length ?? 0,
              padding: const EdgeInsets.only(top: 10),
              itemBuilder: (context, index) {
                final size = controller.productItemDetailModel?.sizes[index];
                return InkWellButtonWidget(
                  onTap: () {
                    setState(() {
                      _selectedSize = index;
                      cartNotifier.selectSize(index, size.id);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 25,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                                  _selectedSize == index
                                      ? AppColors.accent
                                      : AppColors.dividerColor,
                              width: _selectedSize == index ? 6 : 1,
                            ),
                          ),
                        ),
                        Text(
                          size!.name,
                          style: const TextStyle(color: Color(0xff2E3138)),
                        ),
                        const Spacer(),
                        Text(
                          '\$+${size.price.toStringAsFixed(2)}',
                          style: const TextStyle(color: Color(0xff2E3138)),
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
            );
          },
        ),
      ],
    );
  }
}

class ProductSize {
  final String label;
  final double value;

  const ProductSize({required this.label, required this.value});
}

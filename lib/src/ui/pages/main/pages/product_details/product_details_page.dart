import 'package:campuscravings/src/controllers/product_details_controller.dart';
import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/pages/main/pages/product_details/widgets/customization_checkox_widget.dart';
import 'package:campuscravings/src/ui/widgets/custom_network_image.dart';
import 'package:get/get.dart';

@RoutePage()
class ProductDetailsPage extends ConsumerStatefulWidget {
  final List<double> restCoordinates;
  const ProductDetailsPage({super.key, required this.restCoordinates});

  @override
  ConsumerState createState() => _ProductDetailsPageState();
}

PageController _pageController = PageController();
int _selectedIndex = 0;

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    // Get.find<ProductDetailsController>().getProductDetails();
    final locale = AppLocalizations.of(context)!;
    final isIOS = Platform.isIOS;
    final cartItems = ref.watch(cartItemsProvider);
    final cartItemsNotifier = ref.read(cartItemsProvider.notifier);

    return GetBuilder<ProductDetailsController>(
      initState: (state) {
        Get.find<ProductDetailsController>().getProductDetails();
      },
      builder: (controller) {
        if (controller.isLoading) {
          return Scaffold(
            body: SafeArea(
              child: Center(child: CircularProgressIndicator.adaptive()),
            ),
          );
        } else if (controller.isLoading == false &&
            controller.productItemDetailModel == null) {
          return Scaffold(
            appBar: AppBar(title: Text("Product Details"), centerTitle: true),
            body: Center(child: Text('Product Details Not Found')),
          );
        }
        controller.getTotalPrice();
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          // Image Carousel
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(12),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: 350,
                              child: PageView.builder(
                                physics: BouncingScrollPhysics(),
                                controller: _pageController,
                                itemCount:
                                    controller
                                        .productItemDetailModel
                                        ?.images
                                        .length,
                                onPageChanged: (index) {
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                },
                                itemBuilder: (context, index) {
                                  return CustomNetworkImage(
                                    controller
                                        .productItemDetailModel!
                                        .images[index], // Replace with actual asset reference
                                    fit: BoxFit.fitWidth,
                                  );
                                },
                              ),
                            ),
                          ),

                          // Safe Area for Navigation & Cart
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      isIOS
                                          ? Icons.arrow_back_ios
                                          : Icons.arrow_back,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      context.maybePop();
                                    },
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    icon: CartCounterWidget(
                                      count: cartItems.length,
                                      color: AppColors.dividerColor,
                                    ),
                                    onPressed: () {
                                      context.pushRoute(CartTabRoute());
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Swipe Indicator Dots
                          Positioned(
                            bottom: 20,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                controller
                                    .productItemDetailModel!
                                    .images
                                    .length,
                                (index) {
                                  bool isSelected = _selectedIndex == index;
                                  return AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white),
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : Colors.transparent,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${controller.productItemDetailModel?.category.name}',
                                          style: TextStyle(
                                            color: Color(0xff27261E),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "${controller.productItemDetailModel?.name}",
                                          style: TextStyle(
                                            color: Color(0xff27261E),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    QuantitySelectorWidget(
                                      quantity: controller.productQuantity,
                                      price:
                                          controller
                                              .productItemDetailModel
                                              ?.price ??
                                          0,
                                      onQuantityDecrementChanged: () {
                                        controller.decrementProductQuantity();
                                      },
                                      onQuantityIncrementChanged: () {
                                        controller.incrementProductQuantity();
                                      },
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              locale.calories,
                                              style: TextStyle(
                                                color: Color(0xff27261E),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                SvgAssets(
                                                  'calories',
                                                  height: 16,
                                                  width: 16,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 5,
                                                    left: 5,
                                                  ),
                                                  child: Text(
                                                    '${controller.productItemDetailModel?.calories} ${locale.kCal}',
                                                    style: TextStyle(
                                                      color: Color(0xff27261E),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              locale.time,
                                              style: TextStyle(
                                                color: Color(0xff27261E),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                SvgAssets(
                                                  'clock',
                                                  height: 16,
                                                  width: 16,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 5,
                                                    left: 5,
                                                  ),
                                                  child: Text(
                                                    "${controller.productItemDetailModel?.estimatedPreparationTime}${locale.m}",
                                                    style: TextStyle(
                                                      color: Color(0xff27261E),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ProductDescriptionWidget(
                                  description:
                                      '${controller.productItemDetailModel?.description}',
                                ),
                              ],
                            ),
                          ),
                          if (controller
                              .productItemDetailModel!
                              .sizes
                              .isNotEmpty)
                            SizeSelectorWidget(),

                          if (controller
                              .productItemDetailModel!
                              .customization
                              .isNotEmpty)
                            CustomizationCheckboxWidget(
                              customizations:
                                  controller
                                      .productItemDetailModel!
                                      .customization,
                            ),

                          Padding(
                            padding: EdgeInsets.only(
                              left: 25,
                              right: 25,
                              bottom: 25,
                            ),
                            child: CustomTextField(
                              maxLines: 3,
                              hintText: locale.noteToRestaurant,
                              hintStyle: TextStyle(color: Color(0xff9E9E9E)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${controller.productQuantity} ${locale.items}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          '\$ ${controller.totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (controller
                                  .productItemDetailModel!
                                  .sizes
                                  .isNotEmpty &&
                              cartItemsNotifier.selectedSizeId.isEmpty) {
                            showToast(
                              'Please select a size first',
                              context: context,
                            );
                            return;
                          }

                          ref
                              .read(cartItemsProvider.notifier)
                              .addItem(
                                CartItem(
                                  price:
                                      controller.productItemDetailModel!.price,
                                  restCoordinates: widget.restCoordinates,
                                  sizePrice:
                                      cartItemsNotifier.selectedSizePrice,
                                  size: cartItemsNotifier.selectedSizeId,
                                  customization: List.from(
                                    controller.selectedCustomizations,
                                  ),
                                  image:
                                      controller
                                          .productItemDetailModel!
                                          .images
                                          .first,
                                  id:
                                      controller.productItemDetailModel?.id ??
                                      '',
                                  name:
                                      controller.productItemDetailModel?.name ??
                                      '',
                                  totalPrice: controller.totalPrice,
                                  quantity: controller.productQuantity,
                                ),
                              );
                          showToast("Added to cart", context: context);
                        },
                        label: Text(locale.addToCart),
                        icon: SvgAssets("shopping-cart", width: 16, height: 16),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.background,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

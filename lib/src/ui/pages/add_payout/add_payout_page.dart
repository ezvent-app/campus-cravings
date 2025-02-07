import 'package:campus_cravings/src/src.dart';

@RoutePage()
class AddPayoutPage extends ConsumerStatefulWidget {
  const AddPayoutPage({super.key});

  @override
  ConsumerState createState() => _AddPayoutPageState();
}

class _AddPayoutPageState extends ConsumerState<AddPayoutPage> {
  final paymentMethods = ['card', 'venmo', 'venmo', 'venmo', 'venmo'];
  final List<String> _banks = ['Bank of America'];
  late String _selectedBank;

  @override
  void initState() {
    _selectedBank = _banks.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: IconButton(
                      onPressed: () => context.maybePop(),
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 28,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      locale.addPayoutDetails,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: SizedBox(
                height: 67,
                width: double.infinity,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeExtraLarge),
                  scrollDirection: Axis.horizontal,
                  itemCount: paymentMethods.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      width(13),
                  itemBuilder: (BuildContext context, int index) {
                    final category = paymentMethods[index];
                    return Column(
                      children: [
                        Container(
                          width: 60,
                          height: 50,
                          padding: const EdgeInsets.all(
                              Dimensions.paddingSizeDefault),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusDefault),
                            border: Border.all(
                              color: index == 0
                                  ? Colors.black
                                  : AppColors.textFieldBorder,
                            ),
                          ),
                          child: PngAsset(
                            'payment_${category.toLowerCase()}_icon',
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text(locale.selectBank,
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                  DropDownWidget(
                      universitiesList: _banks,
                      onChange: (value) {
                        setState(() {
                          _selectedBank = value!;
                        });
                      },
                      hintText: locale.selectBank),
                  height(16),
                  CustomTextField(label: locale.fullName),
                  height(16),
                  CustomTextField(label: locale.accountNumber),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: RoundedButtonWidget(
                btnTitle: locale.save,
                onTap: () => context.pushRoute(const MainRoute()),
              ),
            ),
            height(40)
          ],
        ),
      ),
    );
  }
}

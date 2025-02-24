import 'package:campuscravings/src/src.dart';

@RoutePage()
class AddPayoutPage extends ConsumerStatefulWidget {
  const AddPayoutPage({super.key});

  @override
  ConsumerState createState() => _AddPayoutPageState();
}

class _AddPayoutPageState extends ConsumerState<AddPayoutPage> {
  final paymentMethods = ['wallet', 'pp', 'apple'];
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
      appBar: AppBar(
        title: Text(
          locale.addPayoutDetails,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeExtraLarge,
          vertical: 8,
        ),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 67,
              width: double.infinity,
              child: Consumer(
                builder: (context, ref, child) {
                  final selectedIndex = ref.watch(paymentSetupProvider);
                  return ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: paymentMethods.length,
                    separatorBuilder:
                        (BuildContext context, int index) => width(13),
                    itemBuilder: (BuildContext context, int index) {
                      final category = paymentMethods[index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(
                          Dimensions.radiusDefault,
                        ),
                        onTap: () {
                          final fullName = ref.read(paymentSetupProvider);
                          ref.read(paymentSetupProvider.notifier).state = {
                            ...fullName,
                            'paymentMethod': category,
                            'selectedIndex': index,
                          };
                        },
                        child: Container(
                          width: 80,
                          height: 67,
                          padding: const EdgeInsets.all(
                            Dimensions.paddingSizeDefault,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radiusDefault,
                            ),
                            border: Border.all(
                              color:
                                  index == selectedIndex["selectedIndex"]
                                      ? Colors.black
                                      : AppColors.textFieldBorder,
                            ),
                          ),
                          child: SvgAssets(category),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 3),
              child: Text(
                locale.selectBank,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            DropDownWidget(
              universitiesList: _banks,
              onChange: (value) {
                setState(() {
                  _selectedBank = value!;
                });

                final bank = ref.read(paymentSetupProvider);
                ref.read(paymentSetupProvider.notifier).state = {
                  ...bank,
                  'bank': value,
                };
              },
              hintText: locale.selectBank,
            ),

            CustomTextField(
              label: locale.fullName,
              textInputAction: TextInputAction.next,

              onChanged: (value) {
                final fullName = ref.read(paymentSetupProvider);
                ref.read(paymentSetupProvider.notifier).state = {
                  ...fullName,
                  'name': value,
                };
              },
            ),
            CustomTextField(
              label: locale.accountNumber,
              onChanged: (value) {
                final accountNumber = ref.read(paymentSetupProvider);
                ref.read(paymentSetupProvider.notifier).state = {
                  ...accountNumber,
                  'number': value,
                };
              },
            ),
            height(MediaQuery.of(context).size.height * .3),
            Consumer(
              builder: (context, ref, child) {
                final payout = ref.watch(paymentSetupProvider);
                return RoundedButtonWidget(
                  btnTitle: locale.save,
                  onTap:
                      payout['paymentMethod']!.isNotEmpty &&
                              payout['bank']!.isNotEmpty &&
                              payout['name']!.isNotEmpty &&
                              payout['number']!.isNotEmpty
                          ? () {
                            context.pushRoute(const MainRoute());
                            ref.read(paymentSetupProvider.notifier).state = {
                              'paymentMethod': '',
                              'bank': '',
                              'name': '',
                              'number': '',
                            };
                          }
                          : null,
                );
              },
            ),
            height(40),
          ],
        ),
      ),
    );
  }
}

final paymentSetupProvider = StateProvider<Map<String, dynamic>>(
  (ref) => {
    'paymentMethod': '',
    'bank': '',
    'name': '',
    'number': '',
    'selectedIndex': 0,
  },
);

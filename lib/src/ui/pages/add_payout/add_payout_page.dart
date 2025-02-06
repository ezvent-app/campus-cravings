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
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 32),
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
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      'Add Payout Details',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: SizedBox(
                height: 67,
                width: double.infinity,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  scrollDirection: Axis.horizontal,
                  itemCount: paymentMethods.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(width: 13),
                  itemBuilder: (BuildContext context, int index) {
                    final category = paymentMethods[index];
                    return Column(
                      children: [
                        Container(
                          width: 80,
                          height: 67,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
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
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text(
                      'Select Bank',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.lightText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    items: _banks.map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    value: _selectedBank,
                    onChanged: (value) {
                      setState(() {
                        _selectedBank = value!;
                      });
                    },
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconEnabledColor: AppColors.primary,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: AppColors.textFieldBorder, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: AppColors.textFieldBorder, width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const CustomTextField(label: 'Full Name'),
                  const SizedBox(height: 16),
                  const CustomTextField(label: 'Account Number'),
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 48,
              margin: const EdgeInsets.only(left: 25, right: 25, bottom: 32),
              child: ElevatedButton(
                onPressed: () {
                  context.pushRoute(const MainRoute());
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.background, // Splash color
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

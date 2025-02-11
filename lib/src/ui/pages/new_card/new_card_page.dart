import 'package:campus_cravings/src/src.dart';

@RoutePage()
class NewCardPage extends ConsumerStatefulWidget {
  const NewCardPage({super.key});

  @override
  ConsumerState createState() => _NewCardPageState();
}

class _NewCardPageState extends ConsumerState<NewCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 15),
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
                          child: Text('Add New Card',
                              style: Theme.of(context).textTheme.titleMedium),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 45),
                    child: Column(
                      children: [
                        CustomTextField(
                          label: 'Full Name',
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          label: 'Card Number',
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(5),
                            child: PngAsset('mastercard_icon',
                                height: 30, width: 18),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                                child: CustomTextField(
                              label: 'Expires',
                            )),
                            SizedBox(width: 16),
                            Expanded(
                                child: CustomTextField(
                              label: 'CVV',
                            )),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 48,
              margin: const EdgeInsets.only(left: 25, right: 25, bottom: 36),
              child: ElevatedButton(
                onPressed: () {
                  context.maybePop();
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

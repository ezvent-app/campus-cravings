import 'package:campus_cravings/src/src.dart';

@RoutePage()
class NewCardPage extends StatelessWidget {
  const NewCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
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
                          child: Text(locale.addNewCard,
                              style: Theme.of(context).textTheme.titleMedium),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 45),
                    child: Column(
                      children: [
                        CustomTextField(
                          label: locale.fullName,
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          label: locale.cardNumber,
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
                              label: locale.expires,
                            )),
                            SizedBox(width: 16),
                            Expanded(
                                child: CustomTextField(
                              label: locale.cvv,
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
                child: Text(
                  locale.save,
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

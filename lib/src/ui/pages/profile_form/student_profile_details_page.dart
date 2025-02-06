import 'package:campus_cravings/src/src.dart';

@RoutePage()
class ProfileFormPage extends ConsumerStatefulWidget {
  final bool newUser;
  const ProfileFormPage({super.key, required this.newUser});

  @override
  ConsumerState createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends ConsumerState<ProfileFormPage> {
 

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: Dimensions.paddingSizeLarge,
                  bottom: Dimensions.paddingSizeDefault),
              child: Row(
                children: [
                  if (!widget.newUser)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault),
                      child: IconButton(
                        onPressed: () => context.maybePop(),
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 28,
                        ),
                      ),
                    )
                  else
                    width(25),
                  Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Text(
                      locale.studentProfileDetails,
                      style: const TextStyle(
                          fontSize: Dimensions.fontSizeExtraLarge,
                          fontWeight: FontWeight.w800),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  height(50),
                  CustomTextField(
                    label: locale.batchYear,
                  ),
                  height(16),
                  CustomTextField(
                    label: locale.yourMajors,
                  ),
                  height(16),
                  CustomTextField(
                    label: locale.yourMinors,
                  ),
                  height(16),
                  CustomTextField(
                    label: locale.clubsOrganizations,
                  ),
                  height(16),
                  CustomTextField(
                    label: locale.aboutYou,
                  ),
                  height(18),
                  RoundedButtonWidget(
                      btnTitle: locale.next,
                      onTap: () =>
                          context.pushRoute(const DeliverySetupRoute())),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

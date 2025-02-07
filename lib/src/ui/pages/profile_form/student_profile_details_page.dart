import 'package:campus_cravings/src/src.dart';

@RoutePage()
class StudentProfileDetailsPage extends ConsumerStatefulWidget {
  const StudentProfileDetailsPage({super.key});

  @override
  ConsumerState createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends ConsumerState<StudentProfileDetailsPage> {
  List majors = [];
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault,
                    ),
                    child: Text(
                      locale.studentProfileDetails,
                      style: Theme.of(context).textTheme.titleMedium,
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
                    onSubmitted: (value) => setState(() => majors.add(value)),
                  ),
                  height(5),
                  Wrap(
                    children: majors
                        .map((i) => Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: InputChip(
                                label: Text(
                                  i,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: AppColors.black),
                                ),
                                onDeleted: () =>
                                    setState(() => majors.remove(i)),
                              ),
                            ))
                        .toList(),
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

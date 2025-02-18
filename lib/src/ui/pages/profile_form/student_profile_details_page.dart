import 'package:campus_cravings/src/src.dart';

@RoutePage()
class StudentProfileDetailsPage extends ConsumerStatefulWidget {
  const StudentProfileDetailsPage({super.key});

  @override
  ConsumerState createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends ConsumerState<StudentProfileDetailsPage> {
  List<String> majors = [];
  List<String> minors = [];
  List<String> clubs = [];

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          locale.studentProfileDetails,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeExtraLarge),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height(50),
            CustomTextField(
              label: locale.batchYear,
            ),
            height(16),
            CustomTextField(
              hintText: locale.search,
              label: locale.yourMajors,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  setState(() => majors.add(value));
                }
              },
            ),
            height(5),
            Wrap(
              spacing: 8,
              children: majors
                  .map((i) => Chip(
                        labelPadding: EdgeInsets.zero,
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              i,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AppColors.black),
                            ),
                            InkWell(
                              onTap: () => setState(() => majors.remove(i)),
                              child: Icon(Icons.clear, size: 16),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            height(16),
            CustomTextField(
              hintText: locale.search,
              label: locale.yourMinors,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  setState(() => minors.add(value));
                }
              },
            ),
            height(5),
            Wrap(
              spacing: 8,
              children: minors
                  .map((i) => Chip(
                        labelPadding: EdgeInsets.zero,
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              i,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AppColors.black),
                            ),
                            InkWell(
                              onTap: () => setState(() => minors.remove(i)),
                              child: Icon(Icons.clear, size: 16),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            height(16),
            CustomTextField(
              hintText: locale.search,
              label: locale.clubsOrganizations,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  setState(() => clubs.add(value));
                }
              },
            ),
            height(5),
            Wrap(
              spacing: 8,
              children: clubs
                  .map((i) => Chip(
                        labelPadding: EdgeInsets.zero,
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              i,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AppColors.black),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                clubs.remove(i);
                              }),
                              child: Icon(Icons.clear, size: 16),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            height(16),
            CustomTextField(
              hintText: locale.whatDoYouWantKnowAboutYou,
              label: locale.aboutYou,
              maxLines: 2,
            ),
            height(18),
            RoundedButtonWidget(
                btnTitle: locale.next,
                onTap: () => context.pushRoute(const DeliverySetupRoute())),
          ],
        ),
      ),
    );
  }
}

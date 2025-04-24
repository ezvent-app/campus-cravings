import 'package:campuscravings/src/src.dart';

@RoutePage()
class StudentProfileDetailsPage extends ConsumerWidget {
  const StudentProfileDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          locale.studentProfileDetails,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeExtraLarge,
        ),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height(50),
            CustomTextField(
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.number,
              label: locale.batchYear,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  ref.read(studentProfileProvider.notifier).state["batchYear"] =
                      value;
                }
              },
            ),
            height(16),
            CustomTextField(
              hintText: locale.search,
              label: locale.yourMajors,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  final majors = ref.read(majorsProvider);
                  ref.read(majorsProvider.notifier).state = [...majors, value];
                }
              },
            ),
            height(5),
            Consumer(
              builder: (context, ref, child) {
                final majors = ref.watch(majorsProvider);
                return ChipWrapWidget(
                  items: majors,
                  onRemove: (item) {
                    ref.read(majorsProvider.notifier).state =
                        majors.where((i) => i != item).toList();
                  },
                );
              },
            ),
            height(16),
            CustomTextField(
              hintText: locale.search,
              label: locale.yourMinors,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  final minors = ref.watch(minorsProvider);

                  ref.read(minorsProvider.notifier).state = [...minors, value];
                }
              },
            ),
            height(5),
            Consumer(
              builder: (context, ref, child) {
                final minors = ref.watch(minorsProvider);
                return ChipWrapWidget(
                  items: minors,
                  onRemove: (item) {
                    ref.read(minorsProvider.notifier).state =
                        minors.where((i) => i != item).toList();
                  },
                );
              },
            ),
            height(16),
            CustomTextField(
              hintText: locale.search,
              label: locale.clubsOrganizations,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  final clubs = ref.watch(clubsProvider);
                  ref.read(clubsProvider.notifier).state = [...clubs, value];
                }
              },
            ),
            height(5),
            Consumer(
              builder: (context, ref, child) {
                final clubs = ref.watch(clubsProvider);
                return ChipWrapWidget(
                  items: clubs,
                  onRemove: (item) {
                    ref.read(clubsProvider.notifier).state =
                        clubs.where((i) => i != item).toList();
                  },
                );
              },
            ),

            height(16),
            CustomTextField(
              hintText: locale.whatDoYouWantKnowAboutYou,
              label: locale.aboutYou,
              maxLines: 2,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  ref.read(studentProfileProvider.notifier).state["aboutYou"] =
                      value;
                }
              },
            ),
            height(18),
            Consumer(
              builder: (context, ref, child) {
                return RoundedButtonWidget(
                  btnTitle: locale.next,
                  onTap: () {
                    final aboutYou =
                        ref.read(studentProfileProvider)["aboutYou"];
                    final batchYear =
                        ref.read(studentProfileProvider)["batchYear"];
                    final majors = ref.read(majorsProvider);
                    final minors = ref.read(minorsProvider);
                    final clubs = ref.read(clubsProvider);

                    if (aboutYou.isEmpty ||
                        batchYear.isEmpty ||
                        majors.isEmpty ||
                        minors.isEmpty ||
                        clubs.isEmpty) {
                      showToast(
                        "Please Enter Proper Information",
                        context: context,
                      );
                      return;
                    }
                    context.pushRoute(
                      DeliverySetupRoute(
                        aboutYou: aboutYou,
                        batchYear: batchYear,
                        majors: majors,
                        minors: minors,
                        clubs: clubs,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

final studentProfileProvider = StateProvider<Map<String, dynamic>>(
  (ref) => {"batchYear": "", "aboutYou": ""},
);

final majorsProvider = StateProvider<List<String>>((ref) => []);
final minorsProvider = StateProvider<List<String>>((ref) => []);
final clubsProvider = StateProvider<List<String>>((ref) => []);

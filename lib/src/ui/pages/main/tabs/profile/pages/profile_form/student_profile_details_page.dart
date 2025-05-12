import 'package:campuscravings/src/src.dart';

@RoutePage()
class StudentProfileDetailsPage extends ConsumerStatefulWidget {
  const StudentProfileDetailsPage({super.key});

  @override
  ConsumerState<StudentProfileDetailsPage> createState() =>
      _StudentProfileDetailsPageState();
}

class _StudentProfileDetailsPageState
    extends ConsumerState<StudentProfileDetailsPage> {
  late final TextEditingController _majorController;
  late final FocusNode _majorFocusNode;

  late final TextEditingController _minorController;
  late final FocusNode _minorFocusNode;

  late final TextEditingController _clubController;
  late final FocusNode _clubFocusNode;

  @override
  void initState() {
    super.initState();

    _majorController = TextEditingController();
    _majorFocusNode = FocusNode();
    _majorFocusNode.addListener(() {
      if (!_majorFocusNode.hasFocus) {
        final value = _majorController.text.trim();
        final majors = ref.read(majorsProvider);
        if (value.isNotEmpty && !majors.contains(value)) {
          ref.read(majorsProvider.notifier).state = [...majors, value];
          _majorController.clear();
        }
      }
    });

    _minorController = TextEditingController();
    _minorFocusNode = FocusNode();
    _minorFocusNode.addListener(() {
      if (!_minorFocusNode.hasFocus) {
        final value = _minorController.text.trim();
        final minors = ref.read(minorsProvider);
        if (value.isNotEmpty && !minors.contains(value)) {
          ref.read(minorsProvider.notifier).state = [...minors, value];
          _minorController.clear();
        }
      }
    });

    _clubController = TextEditingController();
    _clubFocusNode = FocusNode();
    _clubFocusNode.addListener(() {
      if (!_clubFocusNode.hasFocus) {
        final value = _clubController.text.trim();
        final clubs = ref.read(clubsProvider);
        if (value.isNotEmpty && !clubs.contains(value)) {
          ref.read(clubsProvider.notifier).state = [...clubs, value];
          _clubController.clear();
        }
      }
    });
  }

  @override
  void dispose() {
    _majorController.dispose();
    _majorFocusNode.dispose();
    _minorController.dispose();
    _minorFocusNode.dispose();
    _clubController.dispose();
    _clubFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final majors = ref.watch(majorsProvider);
    final minors = ref.watch(minorsProvider);
    final clubs = ref.watch(clubsProvider);

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
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height(10),
            CustomTextField(
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.number,
              maxLength: 4,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
              label: "Batch Year*",
              onChanged: (value) {
                if (value.isNotEmpty) {
                  ref.read(studentProfileProvider.notifier).state["batchYear"] =
                      value;
                }
              },
            ),
            height(16),
            CustomTextField(
              controller: _majorController,
              focusNode: _majorFocusNode,
              hintText: locale.search,
              label: "Your Major(s)*",
            ),
            height(5),
            ChipWrapWidget(
              items: majors,
              onRemove: (item) {
                ref.read(majorsProvider.notifier).state =
                    majors.where((i) => i != item).toList();
              },
            ),
            height(16),
            CustomTextField(
              controller: _minorController,
              focusNode: _minorFocusNode,
              hintText: locale.search,
              label: "Your Minor(s)*",
            ),
            height(5),
            ChipWrapWidget(
              items: minors,
              onRemove: (item) {
                ref.read(minorsProvider.notifier).state =
                    minors.where((i) => i != item).toList();
              },
            ),
            height(16),
            CustomTextField(
              controller: _clubController,
              focusNode: _clubFocusNode,
              hintText: locale.search,
              label: "Clubs or organizations*",
            ),
            height(5),
            ChipWrapWidget(
              items: clubs,
              onRemove: (item) {
                ref.read(clubsProvider.notifier).state =
                    clubs.where((i) => i != item).toList();
              },
            ),
            height(16),
            CustomTextField(
              hintText: locale.whatDoYouWantKnowAboutYou,
              label: "About You (Bio)*",
              maxLines: 2,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  ref.read(studentProfileProvider.notifier).state["aboutYou"] =
                      value;
                }
              },
            ),
            height(25),
            RoundedButtonWidget(
              btnTitle: locale.next,
              onTap: () {
                final aboutYou = ref.read(studentProfileProvider)["aboutYou"];
                final batchYear = ref.read(studentProfileProvider)["batchYear"];
                final majors = ref.read(majorsProvider);
                final minors = ref.read(minorsProvider);
                final clubs = ref.read(clubsProvider);

                if (batchYear.isEmpty) {
                  showToast("Please enter batch year.", context: context);
                  return;
                }

                final parsedYear = int.tryParse(batchYear);
                final currentYear = DateTime.now().year;

                if (parsedYear == null ||
                    batchYear.length != 4 ||
                    parsedYear < 1950 ||
                    parsedYear > currentYear) {
                  showToast(
                    "Please enter a valid batch year (1950–$currentYear).",
                    context: context,
                  );
                  return;
                }

                if (majors.isEmpty) {
                  showToast(
                    "Please Enter Major and press done to save.",
                    context: context,
                  );
                  return;
                }
                if (minors.isEmpty) {
                  showToast(
                    "Please Enter minor and press done to save.",
                    context: context,
                  );
                  return;
                }
                if (clubs.isEmpty) {
                  showToast(
                    "Please Enter clubs or Organization and press done to save.",
                    context: context,
                  );
                  return;
                }
                if (aboutYou.isEmpty) {
                  showToast("Please Enter bio.", context: context);
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
            ),
            height(30),
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

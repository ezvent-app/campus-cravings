import 'dart:developer' as dev;

import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/controllers/location_controller.dart';
import 'package:campuscravings/src/src.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

@RoutePage()
class StudentProfileDetailsPage extends ConsumerStatefulWidget {
  const StudentProfileDetailsPage({super.key});

  @override
  ConsumerState<StudentProfileDetailsPage> createState() =>
      _StudentProfileDetailsPageState();
}

class _StudentProfileDetailsPageState
    extends ConsumerState<StudentProfileDetailsPage> {
  bool _isLoading = false;
  OverlayEntry? _dropdownOverlay;
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _fieldKey = GlobalKey();

  late final TextEditingController _majorController;
  late final FocusNode _majorFocusNode;

  late final TextEditingController _minorController;
  late final FocusNode _minorFocusNode;

  late final TextEditingController _clubController;
  late final FocusNode _clubFocusNode;
  Position? _locationData;
  HttpAPIServices services = HttpAPIServices();
  @override
  void initState() {
    super.initState();
    getLocation();
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

  getLocation() async {
    _locationData = await Get.find<LocationController>().getCurrentLocation();
    dev.log(
      ".............user current Lat ${_locationData!.latitude.toString()} long ${_locationData!.latitude.toString()}",
    );
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
    final currentYear = DateTime.now().year;
    final graduationYears = List.generate(
      9,
      (index) => (currentYear - 4 + index).toString(),
    );
    final selectedYear = ref.watch(studentProfileProvider)["batchYear"];

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
            CompositedTransformTarget(
              link: _layerLink,
              child: GestureDetector(
                key: _fieldKey,
                onTap: () {
                  if (_dropdownOverlay == null) {
                    _showYearDropdown(context, graduationYears);
                  } else {
                    _hideYearDropdown();
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedYear.isNotEmpty
                            ? selectedYear
                            : "Select Graduation Year",
                        style: TextStyle(
                          color: selectedYear.isNotEmpty
                              ? Colors.black
                              : Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.grey),
                    ],
                  ),
                ),
              ),
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
                ref.read(majorsProvider.notifier).state = majors
                    .where((i) => i != item)
                    .toList();
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
                ref.read(minorsProvider.notifier).state = minors
                    .where((i) => i != item)
                    .toList();
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
                ref.read(clubsProvider.notifier).state = clubs
                    .where((i) => i != item)
                    .toList();
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
              isLoading: _isLoading,
              onTap: () async {
                setState(() {
                  _isLoading = true;
                });
                final aboutYou = ref.read(studentProfileProvider)["aboutYou"];
                final batchYear = ref.read(studentProfileProvider)["batchYear"];
                final majors = ref.read(majorsProvider);
                final minors = ref.read(minorsProvider);
                final clubs = ref.read(clubsProvider);

                if (batchYear.isEmpty) {
                  showToast(
                    "Please select your graduation year.",
                    context: context,
                  );
                  setState(() => _isLoading = false);
                  return;
                }

                if (majors.isEmpty) {
                  showToast("Please add at least one major.", context: context);
                  setState(() => _isLoading = false);
                  return;
                }

                if (minors.isEmpty) {
                  showToast("Please add at least one minor.", context: context);
                  setState(() => _isLoading = false);
                  return;
                }

                if (clubs.isEmpty) {
                  showToast(
                    "Please add at least one club or organization.",
                    context: context,
                  );
                  setState(() => _isLoading = false);
                  return;
                }

                if (aboutYou.isEmpty) {
                  showToast(
                    "Please write a short bio about yourself.",
                    context: context,
                  );
                  setState(() => _isLoading = false);
                  return;
                }

                final response = await services.postAPI(
                  url: '/rider/riderRegistration',
                  map: {
                    "bio": aboutYou,
                    "batch_year": batchYear,
                    "majors": minors,
                    "monirs": minors,
                    "club_organizations": clubs,
                    "location": {
                      "lat": _locationData!.latitude,
                      "lng": _locationData!.longitude,
                    }, // Replace with actual GPS
                  },
                );
                final data = jsonDecode(response.body);
                final riderId = data['data']['user'];
                String successUrl =
                    'https://restaurantmanager.campuscravings.co/$riderId?verified=true';
                String failureUrl =
                    'https://restaurantmanager.campuscravings.co/login';
                if (response.statusCode == 201 || response.statusCode == 200) {
                  StorageHelper().saveRiderId(riderId);
                  StorageHelper().saveRiderProfileComplete(true);

                  // Show loader before hitting onboarding API
                  setState(() => _isLoading = true);

                  RiderPayoutRepo repo = RiderPayoutRepo();
                  await repo.generateOnboardingLink(
                    riderId,
                    successUrl,
                    failureUrl,
                    context,
                  );

                  setState(() => _isLoading = false);
                } else if (response.statusCode == 400) {
                  setState(() => _isLoading = false);
                  showToast(
                    context: context,
                    "You are already registered as a rider!",
                  );
                } else {
                  setState(() => _isLoading = false);

                  String errorMessage = "Something went wrong";
                  try {
                    final decoded = jsonDecode(response.body);
                    if (decoded is Map && decoded.containsKey("message")) {
                      errorMessage = decoded["message"];
                    }
                  } catch (_) {
                    // If decoding fails, use default error message
                  }

                  showToast(context: context, errorMessage);
                }
              },
            ),
            height(30),
          ],
        ),
      ),
    );
  }

  void _showYearDropdown(BuildContext context, List<String> years) {
    final renderBox = _fieldKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _dropdownOverlay = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 5,
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: years.length,
              itemBuilder: (context, index) {
                final year = years[index];
                final selectedYear = ref.watch(
                  studentProfileProvider,
                )["batchYear"];
                final selected = selectedYear == year;

                return InkWell(
                  onTap: () {
                    final current = ref.read(studentProfileProvider);
                    ref.read(studentProfileProvider.notifier).state = {
                      ...current,
                      "batchYear": year,
                    };

                    _hideYearDropdown();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: selected ? Colors.black12 : Colors.white,
                      borderRadius: index == 0
                          ? BorderRadius.vertical(top: Radius.circular(8))
                          : index == years.length - 1
                          ? BorderRadius.vertical(bottom: Radius.circular(8))
                          : BorderRadius.zero,
                    ),
                    child: Text(
                      year,
                      style: TextStyle(
                        fontSize: 12,
                        color: selected ? Colors.black : Colors.grey.shade800,
                        fontWeight: selected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_dropdownOverlay!);
  }

  void _hideYearDropdown() {
    _dropdownOverlay?.remove();
    _dropdownOverlay = null;
  }
}

final studentProfileProvider = StateProvider<Map<String, dynamic>>(
  (ref) => {"batchYear": "", "aboutYou": ""},
);

final majorsProvider = StateProvider<List<String>>((ref) => []);
final minorsProvider = StateProvider<List<String>>((ref) => []);
final clubsProvider = StateProvider<List<String>>((ref) => []);

import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/widgets/custom_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

// Mock API service for fetching rider details
class RiderApiService {
  final HttpService services = HttpService();
  Future<RiderDetails> fetchRiderDetails(String orderId) async {
    // Simulate network delay
    final response = await services.getRequest(
      "/rider/getRiderDetails/$orderId",
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to load rider details');
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final rider = RiderDetails.fromJson(data["data"] as Map<String, dynamic>);
    return rider;
  }
}

// Rider details model
class RiderDetails {
  final String name;
  final String profileImageUrl;
  final String rating;
  final String hours;
  final String miles;
  final String bio;
  final List majors;
  final List minors;
  final List clubs;
  final String phoneNumber;

  RiderDetails({
    required this.name,
    required this.profileImageUrl,
    required this.rating,
    required this.hours,
    required this.miles,
    required this.bio,
    required this.majors,
    required this.minors,
    required this.clubs,
    required this.phoneNumber,
  });

  factory RiderDetails.fromJson(Map<String, dynamic> json) {
    return RiderDetails(
      name: json['user']['fullName'] as String,
      profileImageUrl: json['user']['imgUrl'] as String,
      rating: (json['rating']['average']).toString(),
      hours: json['totalHours'].toString(),
      miles: json['totalDistance'].toString(),
      bio: json['bio'] as String,
      majors: json['majors'] as List,
      minors: json['monirs'] as List,
      clubs: json['club_organizations'] as List,
      phoneNumber: json['user']['phoneNumber'] as String,
    );
  }
}

// Riverpod provider for rider details
final riderDetailsProvider = FutureProvider.family<RiderDetails, String>((
  ref,
  orderId,
) async {
  final apiService = RiderApiService();
  return apiService.fetchRiderDetails(orderId);
});

// Mock locale class
class Locale {
  String get viewProfile => 'View Profile';
  String get yourOrderGoodHandsFellowComputerScienceStudent =>
      'Your order is in good hands with a fellow computer science student';
  String get sendMessage => 'Send Message';
}

// Rider Information Widget
class RiderInformationWidget extends ConsumerStatefulWidget {
  final VoidCallback orderReviewSheetMethod;
  final String orderId;

  const RiderInformationWidget({
    required this.orderReviewSheetMethod,
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  ConsumerState<RiderInformationWidget> createState() =>
      _RiderInformationWidgetState();
}

class _RiderInformationWidgetState
    extends ConsumerState<RiderInformationWidget> {
  @override
  void initState() {
    super.initState();
    // API call is handled by Riverpod provider
  }

  @override
  Widget build(BuildContext context) {
    final locale = Locale(); // Mock locale instance
    final riderDetailsAsync = ref.watch(riderDetailsProvider(widget.orderId));

    return riderDetailsAsync.when(
      data: (riderDetails) {
        return Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 16),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  width: 80,
                  margin: const EdgeInsets.only(bottom: 9),
                  child: CustomNetworkImage(
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(9999),
                    riderDetails.profileImageUrl,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed:
                  () => context.pushRoute(
                    DeliveryManProfileRoute(riderDetails: riderDetails),
                  ),
              child: Center(
                child: Text(
                  locale.viewProfile,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Text(
                locale.yourOrderGoodHandsFellowComputerScienceStudent,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: AppColors.black),
              ),
            ),
            height(10),
            InkWellButtonWidget(
              onTap: () => widget.orderReviewSheetMethod(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5, // Assuming 5 stars
                  (i) => Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: SvgAssets(
                      'star',
                      width: 20,
                      height: 20,
                      color:
                          i < int.parse(riderDetails.rating)
                              ? AppColors.yellow
                              : AppColors.dividerColor,
                    ),
                  ),
                ),
              ),
            ),
            height(15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      final Uri dialUri = Uri(
                        scheme: 'tel',
                        path: riderDetails.phoneNumber,
                      );

                      // Check if the URL can be launched
                      if (await canLaunchUrl(dialUri)) {
                        await launchUrl(dialUri);
                      } else {
                        throw 'Could not launch $dialUri';
                      }
                    },

                    child: SizedBox(
                      width: 55,
                      height: 55,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgAssets("call_icon", width: 100, height: 100),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWellButtonWidget(
                      borderRadius: BorderRadius.circular(12),
                      onTap:
                          () => context.pushRoute(
                            CheckOutChatRoute(
                              id: widget.orderId,
                              isCustomer: true,
                            ),
                          ),
                      child: Container(
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xffF5F5F5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 17,
                          vertical: 8,
                        ),
                        child: Text(
                          locale.sendMessage,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: AppColors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

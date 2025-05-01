import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/pages/checkout/pages/delivering/widgets/rider_details_widget.dart';

@RoutePage()
class DeliveryManProfilePage extends StatefulWidget {
  final RiderDetails riderDetails;
  const DeliveryManProfilePage({super.key, required this.riderDetails});

  @override
  State<DeliveryManProfilePage> createState() => _DeliveryManProfilePageState();
}

class _DeliveryManProfilePageState extends State<DeliveryManProfilePage> {
  List stars = [1, 2, 3, 4, 5];

  List majors = ["Computer Science", "Business"];
  List minors = ["Computer Science", "Business", "IT", "Arts", "Sports", "Law"];
  List sports = [
    "Coding Club",
    "Debate Society",
    "Sports Club",
    "Arts",
    "Sports",
    "Football",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileAndAchievmentsWidget(
              size: size,
              riderDetails: widget.riderDetails,
            ),
            ProfileDetailsWidget(
              stars: stars,
              majors: widget.riderDetails.majors,
              minors: widget.riderDetails.minors,
              sports: widget.riderDetails.clubs,
              bio: widget.riderDetails.bio,
            ),
          ],
        ),
      ),
    );
  }
}

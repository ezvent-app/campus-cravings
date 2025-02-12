import 'package:campus_cravings/src/src.dart';

@RoutePage()
class DeliveryManProfilePage extends StatefulWidget {
  const DeliveryManProfilePage({super.key});

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
    "Football"
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
            ProfileAndAchievmentsWidget(size: size),
            ProfileDetailsWidget(stars: stars, majors: majors, minors: minors, sports: sports),
          ],
        ),
      ),
    );
  }
}

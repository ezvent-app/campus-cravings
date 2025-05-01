import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/pages/checkout/pages/delivering/widgets/rider_details_widget.dart';
import 'package:campuscravings/src/ui/widgets/custom_network_image.dart';

class ProfileAndAchievmentsWidget extends StatelessWidget {
  final RiderDetails riderDetails;
  const ProfileAndAchievmentsWidget({
    super.key,
    required this.size,
    required this.riderDetails,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final isIOS = Platform.isIOS;
    return SizedBox(
      height: size.height * .53,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: size.height * .4,
              width: size.width,
              padding: EdgeInsets.all(Dimensions.paddingSizeLarge),
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            isIOS ? Icons.arrow_back_ios_new : Icons.arrow_back,
                          ),
                          color: AppColors.white,
                        ),
                        width(20),
                        Text(
                          locale.profile,
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        height(20),
                        Center(
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
                        height(10),
                        Text(
                          riderDetails.name,
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(color: AppColors.white),
                        ),
                        Text(
                          "Beginner",
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall!.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 275,
            left: 35,
            right: 35,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.red.shade50, width: 3),
              ),
              child: Padding(
                padding: EdgeInsets.all(Dimensions.paddingSizeLarge),
                child: Column(
                  children: [
                    Text(
                      locale.achievements,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    height(10),
                    Container(
                      padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red.shade100),
                        borderRadius: BorderRadius.circular(
                          Dimensions.radiusDefault,
                        ),
                        color: Color(0xffFFF7F7),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AchievmentsRowWidget(
                            image: "runner",
                            title: locale.miles,
                            value: riderDetails.miles,
                          ),
                          SizedBox(
                            height: 40,
                            child: VerticalDivider(color: AppColors.email),
                          ),
                          AchievmentsRowWidget(
                            image: "stopwatch",
                            title: locale.hours,
                            value: riderDetails.hours,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

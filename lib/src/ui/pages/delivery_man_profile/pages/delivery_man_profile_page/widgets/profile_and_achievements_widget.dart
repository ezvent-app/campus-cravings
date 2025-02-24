import 'package:campus_cravings/src/src.dart';

class ProfileAndAchievmentsWidget extends StatelessWidget {
  const ProfileAndAchievmentsWidget({super.key, required this.size});

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
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                              "https://s3-alpha-sig.figma.com/img/b271/70bb/8a7db32d95e2d59f88efb80e8417336c?Expires=1740355200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=U1TCftYFII4pIsidEmBhOUs96q6udmiVQ0z1YPKHJJVIjeh~m7r1gTCdGf3S4BIjHAEc9kRQ8fQ52UfUzwENj2Z~m07wfWB3juP9uNTyWdc5vTwW~OAvhjiaQpv9P26dbXTOL1Y~0JoCtG79QCMIKIj7rxV5IiM8wZjAFLAZptmXyP4S1O-miNft6j5CutQKKm-dcR8laXfyjXqsXc0OuVmkHbRuxVSLSrkBTsfoGSEXz7u6TTi5kwNyAResPYpa7VGC3gPrvx2IilBNP7obPKzZ126OBlwNN~hwG3VY9AF1E4gHblmLskYdulaJGBCNMOvtMeGdrWMD3W3-y5ElCw__",
                            ),
                          ),
                        ),
                        height(10),
                        Text(
                          "Robert Fox",
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
                            value: "1032",
                          ),
                          SizedBox(
                            height: 40,
                            child: VerticalDivider(color: AppColors.email),
                          ),
                          AchievmentsRowWidget(
                            image: "stopwatch",
                            title: locale.hours,
                            value: "169",
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

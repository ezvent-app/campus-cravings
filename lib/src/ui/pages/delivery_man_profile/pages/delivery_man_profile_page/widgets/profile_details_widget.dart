import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/pages/checkout/pages/delivering/widgets/rider_details_widget.dart';

class ProfileDetailsWidget extends StatelessWidget {
  const ProfileDetailsWidget({
    super.key,
    required this.stars,
    required this.majors,
    required this.minors,
    required this.sports,
    required this.bio,
  });
  final String bio;
  final List stars;
  final List majors;
  final List minors;
  final List sports;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            locale.serviceRating,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          height(10),
          Row(
            children: List.generate(
              stars.length,
              (i) => Padding(
                padding: const EdgeInsets.only(right: 7),
                child: SvgAssets(
                  'star',
                  width: 35,
                  height: 35,
                  color: i == 4 ? AppColors.dividerColor : AppColors.yellow,
                ),
              ),
            ),
          ),
          ServiceRowWidget(image: 'user', title: locale.about),
          Text(
            bio,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          height(10),
          Divider(color: AppColors.dividerColor),
          ServiceRowWidget(image: 'books', title: locale.educationDiscipline),
          Text(locale.yourMajors, style: Theme.of(context).textTheme.bodySmall),
          Wrap(
            spacing: 8,
            children:
                majors
                    .map(
                      (i) => Chip(
                        label: Text(
                          i,
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: AppColors.black),
                        ),
                      ),
                    )
                    .toList(),
          ),
          height(10),
          Text(
            locale.yourMinors,
            style: Theme.of(context).textTheme.bodySmall!,
          ),
          Wrap(
            spacing: 8,
            children:
                minors
                    .map(
                      (i) => Chip(
                        label: Text(
                          i,
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: AppColors.black),
                        ),
                      ),
                    )
                    .toList(),
          ),
          ServiceRowWidget(image: 'Target', title: locale.clubOrganizations),
          Wrap(
            spacing: 8,
            children:
                sports
                    .map(
                      (i) => Chip(
                        label: Text(
                          i,
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: AppColors.black),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}

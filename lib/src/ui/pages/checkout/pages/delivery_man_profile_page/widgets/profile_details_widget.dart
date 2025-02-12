import 'package:campus_cravings/src/src.dart';

class ProfileDetailsWidget extends StatelessWidget {
  const ProfileDetailsWidget({
    super.key,
    required this.stars,
    required this.majors,
    required this.minors,
    required this.sports,
  });

  final List stars;
  final List majors;
  final List minors;
  final List sports;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Service rating',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          height(10),
          Row(
            children: List.generate(
                stars.length,
                (i) => Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: Icon(
                        Icons.star,
                        color:
                            i == 4 ? AppColors.dividerColor : AppColors.yellow,
                        size: 40,
                      ),
                    )),
          ),
          ServiceRowWidget(
            image: 'user',
            title: "About",
          ),
          Text(
            "Hi! I’m passionate about coding and love participating in hackathons. When I’m not coding, you’ll find me playing chess or exploring new coffee spots!",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
          ),
          height(10),
          Divider(
            color: AppColors.dividerColor,
          ),
          ServiceRowWidget(
            image: 'books',
            title: "Education Discipline",
          ),
          Text(
            "Your Major(s)",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Wrap(
            spacing: 8,
            children: majors
                .map((i) => Chip(
                      label: Text(
                        i,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.black),
                      ),
                    ))
                .toList(),
          ),
          height(10),
          Text(
            "Your Minor(s)",
            style: Theme.of(context).textTheme.bodySmall!,
          ),
          Wrap(
            spacing: 8,
            children: minors
                .map((i) => Chip(
                      label: Text(
                        i,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.black),
                      ),
                    ))
                .toList(),
          ),
          ServiceRowWidget(
            image: 'target',
            title: "Clubs or organizations",
          ),
          Wrap(
            spacing: 8,
            children: sports
                .map((i) => Chip(
                      label: Text(
                        i,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.black),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

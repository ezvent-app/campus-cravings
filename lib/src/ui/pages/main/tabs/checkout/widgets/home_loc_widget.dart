import 'package:campuscravings/src/src.dart';

class HomeLocationWidget extends StatelessWidget {
  const HomeLocationWidget({
    super.key,
    this.icon = Icons.keyboard_arrow_right,
    required this.title,
    required this.subTitle,
  });
  final IconData icon;
  final String title, subTitle;
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Material(
      color: Colors.transparent,
      child: InkWellButtonWidget(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const SvgAssets('location', height: 52, width: 52),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium!.copyWith(fontSize: 18),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          margin: const EdgeInsets.only(left: 30, bottom: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEBEBEB),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            locale.defaultValue,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 10, color: AppColors.black),
                          ),
                        ),
                      ],
                    ),
                    height(5),
                    Text(
                      subTitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final isSelected = ref.watch(checkOutProvider);
                  return InkWellButtonWidget(
                    onTap: () =>
                        ref.read(checkOutProvider.notifier).state = !isSelected,
                    child: Container(
                      width: 20,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            isSelected ? AppColors.accent : Colors.transparent,
                        border: Border.all(
                          color: AppColors.accent,
                          width: 1,
                        ),
                      ),
                      child: isSelected
                          ? Center(
                              child: Icon(
                              Icons.done,
                              color: AppColors.white,
                              size: 15,
                            ))
                          : SizedBox(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final checkOutProvider = StateProvider((ref) => false);

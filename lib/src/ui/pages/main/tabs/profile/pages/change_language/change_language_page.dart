import 'package:campuscravings/src/src.dart';

@RoutePage()
class ChangeLanguagePage extends ConsumerWidget {
  const ChangeLanguagePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    return BaseWrapper(
      label: locale.changeLanguage,
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 150,
            padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              itemCount: languagesList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final language = languagesList[index];

                return Consumer(
                  builder: (context, child, _) {
                    final selectedIndex = ref.watch(changeLanguageProvider);
                    bool isSelected = selectedIndex == index;
                    return ListTile(
                      title: Text(
                        language.title,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      // leading: SvgAssets(language.flag, width: 23, height: 16),
                      trailing: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: isSelected ? Colors.black : Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: isSelected
                            ? Center(
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ),
                      onTap: () => ref
                          .read(changeLanguageProvider.notifier)
                          .state = index,
                    );
                  },
                );
              },
            ),
          ),
          height(24),
          Consumer(
            builder: (context, ref, child) {
              var language = ref.watch(changeLanguageProvider);
              return RoundedButtonWidget(
                btnTitle: locale.save,
                onTap: language == 1
                    ? null
                    : () {
                        context.maybePop();
                        ref.read(changeLanguageProvider.notifier).state = 1;
                      },
              );
            },
          ),
        ],
      ),
    );
  }
}

final changeLanguageProvider = StateProvider<int>((ref) => 1);

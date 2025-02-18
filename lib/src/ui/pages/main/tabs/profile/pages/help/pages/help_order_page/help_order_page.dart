import 'package:campus_cravings/src/src.dart';

@RoutePage()
class HelpOrderPage extends ConsumerWidget {
  const HelpOrderPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    return BaseWrapper(
      label: locale.order,
      child: ListView.builder(
        itemCount: helpOrderModelList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final order = helpOrderModelList[index];

          return Container(
            width: double.infinity,
            padding:
                EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10)),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                title: Text(order.name),
                tilePadding: EdgeInsets.zero,
                trailing: SvgAssets(
                  "arrow_down",
                  width: 24,
                  height: 24,
                ),
                children: [
                  Divider(
                    color: Color(0xffE1E1E1),
                  ),
                  Text(order.description),
                  height(10)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

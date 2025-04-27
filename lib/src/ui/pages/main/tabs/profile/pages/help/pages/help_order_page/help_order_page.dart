import 'package:campuscravings/src/src.dart';

@RoutePage()
class HelpFAQPage extends ConsumerWidget {
  final FAQS type;
  final String title;
  final List faqs;

  const HelpFAQPage({
    super.key,
    required this.faqs,
    required this.type,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expansionState = ref.watch(expansionProvider(faqs.length));

    return BaseWrapper(
      label: title,
      child: ListView.builder(
        itemCount: faqs.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final order = faqs[index];

          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeSmall,
            ),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                initiallyExpanded: expansionState[index],
                title: Text(order.name, textAlign: TextAlign.start),
                tilePadding: EdgeInsets.zero,
                onExpansionChanged: (value) {
                  ref
                      .read(expansionProvider(faqs.length).notifier)
                      .toggle(index);
                },
                trailing: SvgAssets(
                  expansionState[index] ? "arrowUp" : "arrow_down",
                  width: 24,
                  height: 24,
                ),
                children: [
                  Divider(color: Color(0xffE1E1E1)),
                  Text(order.description),
                  height(10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Expansion State Notifier
class ExpansionNotifier extends StateNotifier<List<bool>> {
  ExpansionNotifier(int itemCount) : super(List.filled(itemCount, false));

  // Toggle a specific FAQ item
  void toggle(int index) {
    state = [
      for (int i = 0; i < state.length; i++) i == index ? !state[i] : state[i],
    ];
  }
}

// **Correct use of family provider**
final expansionProvider =
    StateNotifierProvider.family<ExpansionNotifier, List<bool>, int>(
      (ref, itemCount) => ExpansionNotifier(itemCount),
    );

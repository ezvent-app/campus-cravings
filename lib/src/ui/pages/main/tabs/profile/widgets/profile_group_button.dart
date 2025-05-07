import 'package:campuscravings/src/src.dart';

class ProfileGroupButton extends ConsumerWidget {
  final List<dynamic> options;
  final double topMargin;
  final bool isHelp;
  const ProfileGroupButton({
    super.key,
    required this.options,
    this.topMargin = 30,
    this.isHelp = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            options.map((option) {
              return Material(
                color: Colors.transparent,
                child: InkWellButtonWidget(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    option.onPressed();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        isHelp
                            ? SizedBox()
                            : SvgAssets(option.icon, height: 30, width: 30),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 10),
                          child: Text(
                            option.label,
                            // maxLines: 1,
                            // overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff443A39),
                            ),
                          ),
                        ),

                        const Spacer(),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          size: 30,
                          color: Color(0xff443A39),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}

class ProfileOption {
  final String label;
  final String icon;
  final Function onPressed;
  final bool hasTrailingIcon;

  const ProfileOption({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.hasTrailingIcon = true,
  });
}

class HelpOption {
  final String label;
  final Function onPressed;
  final bool hasTrailingIcon;

  const HelpOption({
    required this.label,
    required this.onPressed,
    this.hasTrailingIcon = true,
  });
}

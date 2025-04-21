import 'package:campuscravings/src/src.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
    required this.title,
    required this.desc,
    required this.isEnable,
    required this.onChange,
  });

  final String title, desc;
  final bool isEnable;
  final ValueChanged onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 15, color: Color(0xff2E3138)),
                ),
                height(12),
                Text(
                  desc,
                  style: TextStyle(fontSize: 14, color: Color(0xff878E9B)),
                ),
              ],
            ),
          ),
          width(15),
          Switch(
            value: isEnable,
            onChanged: onChange,
            trackOutlineColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.black;
              } else {
                return AppColors.unselectedTabIconColor;
              }
            }),
            trackColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.black;
              } else {
                return AppColors.unselectedTabIconColor;
              }
            }),
          ),
        ],
      ),
    );
  }
}

import 'package:campus_cravings/src/src.dart';

@RoutePage()
class CheckOutChatPage extends StatelessWidget {
  const CheckOutChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Robert Fox'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: chatsList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final chat = chatsList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: chat.isRead
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Card(
                          color: chat.isRead
                              ? AppColors.black
                              : AppColors.dividerColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: chat.isRead
                                  ? BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(2))
                                  : BorderRadius.only(
                                      topLeft: Radius.circular(2),
                                      topRight: Radius.circular(16),
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16))),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              chat.message,
                              style: TextStyle(
                                  color: chat.isRead
                                      ? AppColors.white
                                      : AppColors.black),
                            ),
                          ),
                        ),
                        chat.isRead
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(chat.timestamp),
                                  width(5),
                                  Icon(Icons.done_all)
                                ],
                              )
                            : Text(chat.timestamp)
                      ],
                    ),
                  );
                },
              ),
            ),
            height(40),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: locale.typeMessage,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {},
                )
              ],
            ),
            height(20)
          ],
        ),
      ),
    );
  }
}

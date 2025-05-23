import 'dart:developer';

import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/widgets/custom_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

@RoutePage()
class TicketMessagesPage extends ConsumerStatefulWidget {
  final String ticketId;
  final Function? onDelete;
  final Function(String ticketId, TicketMessage) onAdd;
  final List<TicketMessage> messages;

  const TicketMessagesPage({
    required this.onAdd,
    super.key,
    required this.ticketId,
    this.onDelete,
    required this.messages,
  });

  @override
  ConsumerState<TicketMessagesPage> createState() => _TicketMessagesPageState();
}

class _TicketMessagesPageState extends ConsumerState<TicketMessagesPage> {
  final TextEditingController _controller = TextEditingController();
  // Add these members
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Scroll to bottom after initial build
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void didUpdateWidget(covariant TicketMessagesPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Scroll when new messages are added
    if (oldWidget.messages.length < widget.messages.length) {
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final notifier = ref.read(ticketMessagesProvider(widget.ticketId).notifier);
    final state = ref.watch(ticketMessagesProvider(widget.ticketId));
    final messages =
        ref
            .watch(ticketProvider)
            .firstWhere((ticket) => ticket.id == widget.ticketId)
            .messages;
    // print("messages here: ${messages[0].sender}");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ticket#${widget.ticketId}",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              widget.onDelete?.call();
              context.maybePop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: messages.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isUser = message.sender == 'user';
                  if (message.imageUrl.isNotEmpty) {
                    print("Message image URL: ${message.imageUrl[0]}");
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment:
                          isUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color:
                                isUser ? AppColors.black : AppColors.halfWhite,
                            borderRadius:
                                isUser
                                    ? const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(2),
                                    )
                                    : const BorderRadius.only(
                                      topLeft: Radius.circular(2),
                                      topRight: Radius.circular(16),
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (message.text.isNotEmpty)
                                  Text(
                                    message.text,
                                    style: TextStyle(
                                      color:
                                          isUser
                                              ? AppColors.white
                                              : AppColors.black,
                                    ),
                                  ),
                                if (message.imageUrl.isNotEmpty) ...[
                                  const SizedBox(height: 10),
                                  CustomNetworkImage(
                                    message.imageUrl[0],
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  // Image.network(
                                  //   message.imageUrl[0],
                                  //   height: 100,
                                  //   fit: BoxFit.cover,
                                  //   errorBuilder:
                                  //       (context, error, stackTrace) =>
                                  //           const Text('Error loading image'),
                                  // ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        Text(
                          DateFormat(
                            'MMM d, yyyy, h:mm a',
                          ).format(message.time),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () async {
                    await notifier.pickImage(context, widget.onAdd);
                  },
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.halfWhite,
                    ),
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) {
                        notifier.updateMessage(value);
                      },
                      decoration: InputDecoration(
                        hintText: locale.typeMessage,
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: SvgAssets("Navigation"),
                  onPressed: () async {
                    await notifier.sendMessage(context, widget.onAdd);
                    _controller.clear();
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// State management with Provider
class TicketMessagesState {
  final String message;
  final File? image;
  final bool isLoading;

  TicketMessagesState({this.message = '', this.image, this.isLoading = false});

  TicketMessagesState copyWith({
    String? message,
    File? image,
    bool? isLoading,
  }) {
    return TicketMessagesState(
      message: message ?? this.message,
      image: image ?? this.image,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class TicketMessagesNotifier extends StateNotifier<TicketMessagesState> {
  final String ticketId;
  final HttpAPIServices services;

  TicketMessagesNotifier(this.ticketId, this.services)
    : super(TicketMessagesState());

  void updateMessage(String message) {
    state = state.copyWith(message: message);
  }

  Future<void> pickImage(
    BuildContext context,
    Function(String ticketId, TicketMessage message) onAdd,
  ) async {
    try {
      state = state.copyWith(isLoading: true);
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        String? path = result.files.single.path;
        if (path != null) {
          File file = File(path);

          final base64Image = await compressImageToBase64(file);

          if (base64Image != null) {
            String base64 =
                'data:image/${result.files.single.extension};base64,$base64Image';

            await _sendImage(base64, context, onAdd);
            log("Base64 Length: ${base64Image.length}");
          } else {
            log("Image compression failed.");
          }
        }
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to pick image')));
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void clearImage() {
    state = state.copyWith(image: null);
  }

  Future<void> _sendImage(
    String image,
    BuildContext context,
    Function(String ticketId, TicketMessage message) onAdd,
  ) async {
    try {
      state = state.copyWith(isLoading: true);
      final response = await services.patchAPI(
        url: '/admin/tickets/reply/$ticketId',
        map: {
          'text': '',
          'imageUrl': [image],
        },
      );
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      // Extract the latest message from the response
      final ticket = responseData['ticket'] as Map<String, dynamic>;
      final messages = ticket['messages'] as List<dynamic>;
      final latestMessage = messages.last as Map<String, dynamic>;

      // Create a TicketMessage object from the latest message
      final message = TicketMessage(
        sender: latestMessage['sender'] as String,
        text: latestMessage['text'] as String,
        imageUrl: (latestMessage['imageUrl'] as List<dynamic>).cast<String>(),
        id: latestMessage['_id'] as String,
        time: DateTime.parse(latestMessage['time'] as String),
      );

      // Call the onAdd callback with the ticketId and the new message
      onAdd(ticketId, message);

      // Reset the state
      state = state.copyWith(image: null);
    } catch (e) {
      debugPrint('Error sending image: $e');
      showToast(context: context, 'Failed to send image');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> sendMessage(
    BuildContext context,
    Function(String ticketId, TicketMessage message) onAdd,
  ) async {
    if (state.message.isEmpty) return;

    try {
      state = state.copyWith(isLoading: true);
      final response = await services.patchAPI(
        url: '/admin/tickets/reply/$ticketId',
        map: {'text': state.message},
      );

      // Parse the response body into a Map<String, dynamic>
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      // Extract the latest message from the response
      final ticket = responseData['ticket'] as Map<String, dynamic>;
      final messages = ticket['messages'] as List<dynamic>;
      final latestMessage = messages.last as Map<String, dynamic>;

      // Create a TicketMessage object from the latest message
      final message = TicketMessage(
        sender: latestMessage['sender'] as String,
        text: latestMessage['text'] as String,
        imageUrl: (latestMessage['imageUrl'] as List<dynamic>).cast<String>(),
        id: latestMessage['_id'] as String,
        time: DateTime.parse(latestMessage['time'] as String),
      );

      // Call the onAdd callback with the ticketId and the new message
      onAdd(ticketId, message);

      // Reset the state
      state = state.copyWith(message: '', image: null);
    } catch (e) {
      debugPrint('Error sending message: $e');
      showToast(context: context, 'Failed to send message');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final ticketMessagesProvider = StateNotifierProvider.family<
  TicketMessagesNotifier,
  TicketMessagesState,
  String
>((ref, ticketId) => TicketMessagesNotifier(ticketId, HttpAPIServices()));

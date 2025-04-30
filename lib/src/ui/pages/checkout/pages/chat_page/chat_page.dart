import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/src.dart';

@RoutePage()
class CheckOutChatPage extends ConsumerStatefulWidget {
  final String id;
  final bool isCustomer;

  const CheckOutChatPage({
    super.key,
    required this.id,
    required this.isCustomer,
  });

  @override
  ConsumerState<CheckOutChatPage> createState() => _CheckOutChatPageState();
}

class _CheckOutChatPageState extends ConsumerState<CheckOutChatPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Setup will happen automatically since we're watching the conversation provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupSocket();
    });
  }

  @override
  void dispose() {
    // ref.read(socketControllerProvider).stopListeningForNewMessages();
    _controller.dispose();
    super.dispose();
  }

  void _setupSocket() {
    final socketController = ref.read(socketControllerProvider);

    // Ensure socket is connected
    if (ref.read(socketStateProvider).status != SocketStatus.connected) {
      final token = StorageHelper().getAccessToken();
      if (token == null) return;
      socketController.connect(token);
    }

    // Watch conversation details to get conversationId
    final conversationAsync = ref.watch(
      conversationNotifierProvider(widget.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final socketController = ref.read(socketControllerProvider);
    final locale = AppLocalizations.of(context)!;
    final conversationAsync = ref.watch(
      conversationNotifierProvider(widget.id),
    );

    return ProviderScope(
      overrides: [isCustomerProvider.overrideWithValue(widget.isCustomer)],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            conversationAsync.valueOrNull?.recipientName ?? 'Loading...',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Expanded(
                child: conversationAsync.when(
                  data:
                      (details) =>
                          details != null
                              ? ref
                                  .watch(
                                    chatNotifierProvider(
                                      details.conversationId,
                                    ),
                                  )
                                  .when(
                                    data:
                                        (chats) =>
                                            chats.isEmpty
                                                ? Center(
                                                  child: Text(
                                                    "No messages",
                                                    style:
                                                        Theme.of(
                                                          context,
                                                        ).textTheme.bodyMedium,
                                                  ),
                                                )
                                                : ListView.builder(
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  itemCount: chats.length,
                                                  itemBuilder: (
                                                    context,
                                                    index,
                                                  ) {
                                                    final chat = chats[index];
                                                    final isCurrentUser =
                                                        chat.senderModel ==
                                                        (widget.isCustomer
                                                            ? 'User'
                                                            : 'Rider');
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 10,
                                                          ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            isCurrentUser
                                                                ? CrossAxisAlignment
                                                                    .end
                                                                : CrossAxisAlignment
                                                                    .start,
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  isCurrentUser
                                                                      ? AppColors
                                                                          .black
                                                                      : AppColors
                                                                          .halfWhite,
                                                              borderRadius:
                                                                  isCurrentUser
                                                                      ? const BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                              16,
                                                                            ),
                                                                        topRight:
                                                                            Radius.circular(
                                                                              16,
                                                                            ),
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                              16,
                                                                            ),
                                                                        bottomRight:
                                                                            Radius.circular(
                                                                              2,
                                                                            ),
                                                                      )
                                                                      : const BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                              2,
                                                                            ),
                                                                        topRight:
                                                                            Radius.circular(
                                                                              16,
                                                                            ),
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                              16,
                                                                            ),
                                                                        bottomRight:
                                                                            Radius.circular(
                                                                              16,
                                                                            ),
                                                                      ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets.all(
                                                                    20,
                                                                  ),
                                                              child: Text(
                                                                chat.text,
                                                                style: TextStyle(
                                                                  color:
                                                                      isCurrentUser
                                                                          ? AppColors
                                                                              .white
                                                                          : AppColors
                                                                              .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          isCurrentUser
                                                              ? Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                    _formatTimestamp(
                                                                      chat.createdAt,
                                                                    ),
                                                                    style:
                                                                        Theme.of(
                                                                          context,
                                                                        ).textTheme.bodySmall,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Icon(
                                                                    chat.status ==
                                                                            'read'
                                                                        ? Icons
                                                                            .done_all
                                                                        : Icons
                                                                            .done,
                                                                    size: 16,
                                                                    color:
                                                                        chat.status ==
                                                                                'read'
                                                                            ? Colors.blue
                                                                            : Colors.grey,
                                                                  ),
                                                                ],
                                                              )
                                                              : Text(
                                                                _formatTimestamp(
                                                                  chat.createdAt,
                                                                ),
                                                                style:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodySmall,
                                                              ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                    loading:
                                        () => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                    error:
                                        (error, _) => Center(
                                          child: Text('Error: $error'),
                                        ),
                                  )
                              : const Center(
                                child: Text('No conversation found'),
                              ),
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(child: Text('Error: $error')),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.halfWhite,
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: locale.typeMessage,
                          hintStyle: Theme.of(context).textTheme.bodyMedium,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: SvgAssets("Navigation"),
                    onPressed:
                        conversationAsync.valueOrNull?.conversationId != null
                            ? () async {
                              if (_controller.text.isNotEmpty) {
                                socketController.emitSendChatMessage(
                                  conversationAsync.valueOrNull!.conversationId,
                                  _controller.text,
                                  widget.isCustomer,
                                );
                                _controller.clear();
                              }
                            }
                            : null,
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}

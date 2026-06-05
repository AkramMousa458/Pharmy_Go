// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/patient/models/screen_args.dart';
import 'package:pharmygo/patient/widgets/confirm_dialog_box.dart';
import 'package:pharmygo/patient/widgets/message_bubble.dart';
import 'package:pharmygo/public/cubits/chat_cubit/chat_cubit.dart';
import 'package:pharmygo/public/models/message_model.dart';

class ChatScreen extends StatefulWidget {
  static String routeName = 'ChatScreen';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  ScreenArgs? _args;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _args ??= ModalRoute.of(context)?.settings.arguments as ScreenArgs?;
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(BuildContext context) {
    final args = _args;
    if (args == null) return;

    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    context.read<ChatCubit>().sendMessage(
          userMessage: text,
          context: context,
          userEmail: args.userEmail,
          friendEmail: args.friendEmail,
        );

    _messageController.clear();
    _scrollToLatest();
  }

  void _scrollToLatest() {
    if (!_scrollController.hasClients) return;

    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  bool _isSentByMe(Message message, String userEmail) {
    return message.id == userEmail;
  }

  @override
  Widget build(BuildContext context) {
    final args = _args;
    if (args == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
          backgroundColor: ThemeColors.kMainColor(context),
        ),
        body: const Center(child: Text('Unable to open chat.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
              tooltip: 'Back',
            ),
            Row(
              children: [
                const SizedBox(width: 7),
                Text(
                  args.friendName,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(width: MediaQuery.sizeOf(context).width / 8),
          ],
        ),
        backgroundColor: ThemeColors.kMainColor(context),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatDeleteMessageSucssesState) {
                  Navigator.pop(context);
                } else if (state is ChatDeleteMessageFailureState) {
                  showSnackBar(context, state.errMessage);
                } else if (state is ChatEditMessageSucssesState) {
                  Navigator.pop(context);
                } else if (state is ChatEditMessageFailureState) {
                  showSnackBar(context, state.errMessage);
                }
              },
              builder: (context, state) {
                final chatList = context.read<ChatCubit>().chatList;

                return Stack(
                  children: [
                    ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      controller: _scrollController,
                      itemCount: chatList.length,
                      itemBuilder: (context, index) {
                        final message = chatList[index];
                        final sentByMe = _isSentByMe(message, args.userEmail);

                        if (sentByMe) {
                          return Slidable(
                            key: ValueKey(
                              '${message.id}_${message.friendId}_${message.time}_${message.text}',
                            ),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      confirmDialogBox(
                                        context: context,
                                        onTap: () {
                                          context.read<ChatCubit>().delMessage(
                                                message: message,
                                              );
                                        },
                                        title: 'Delete Message',
                                        body: 'Do you want delete the message',
                                        no: 'Cancel',
                                        confirm: 'Delete',
                                      );
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 19,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: ThemeColors.kMainColor(context),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<ChatCubit>().editMessage(
                                            message: message,
                                            context: context,
                                          );
                                    },
                                    child: const Icon(
                                      Icons.edit_rounded,
                                      color: Colors.white,
                                      size: 19,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            child: MessageBubbleSend(message: message),
                          );
                        }

                        return MessageBubbleReceive(message: message);
                      },
                    ),
                    if (chatList.isEmpty)
                      Center(
                        child: Text(
                          'No messages yet. Say hello!',
                          style: TextStyle(
                            color: ThemeColors.kMainColor(context),
                            fontSize: 16,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    onSubmitted: (_) => _sendMessage(context),
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      hintText: 'Message',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(200),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _sendMessage(context),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      color: ThemeColors.kMainColor(context),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

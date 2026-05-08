// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/chat_methods.dart';
import 'package:pharmygo/core/utils/constants.dart';
import 'package:pharmygo/public/models/message_model.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());

  List<Message> messagesList = [];
  List<Message> chatList = [];

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  void getMessages(
      {required BuildContext context,
      required String userEmail,
      required String friendEmail}) {
    messages.orderBy(kOrderTime, descending: true).snapshots().listen((event) {
      messagesList = [];
      chatList = [];
      for (var doc in event.docs) {
        messagesList.add(
          Message.fromJson(doc),
        );
      }
      chatList = getChat(messagesList, userEmail, friendEmail, context);
      emit(ChatSucsessState(messages: messagesList, chat: chatList));
    });
  }

  void sendMessage(
      {required String userMessage,
      required String userEmail,
      required String friendEmail,
      required BuildContext context}) {
    if (userMessage != '') {
      messages.add({
        kMessage: userMessage.trim(),
        kCreatedAt: getTime(
          DateTime.now().hour,
          DateTime.now().minute,
          DateTime.now().second,
          DateTime.now().millisecond,
          DateTime.now().day,
          DateTime.now().month,
          DateTime.now().year,
        ),
        kTime: getTime(
          DateTime.now().hour,
          DateTime.now().minute,
          DateTime.now().second,
          DateTime.now().millisecond,
          DateTime.now().day,
          DateTime.now().month,
          DateTime.now().year,
        ).toString().substring(0, 5),
        kOrderTime: DateTime.now().toUtc(),
        kId: userEmail,
        kFriendId: friendEmail
      });
    }
  }

  List<Message> getChat(List<Message> list, String sender, String receiver,
      BuildContext context) {
    List<Message> userChat = [];
    for (int i = 0; i < list.length; i++) {
      if ((list[i].id == sender && list[i].friendId == receiver) ||
          list[i].friendId == sender && list[i].id == receiver) {
        userChat.add(list[i]);
      }
    }
    return userChat;
  }

  void delMessage({required Message message}) async {
    String? itemId = await getDocumentId(localMessage: message);
    try {
      deleteMessage(messages, itemId!);
      emit(ChatDeleteMessageSucssesState());
    } catch (error) {
      emit(ChatDeleteMessageFailureState(
          errMessage: 'Error while deleting message, try again'));
    }
  }

  void editMessage(
      {required Message message, required BuildContext context}) async {
    String? itemId = await getDocumentId(localMessage: message);
    String messageBuffer = '';
    // ignore: use_build_context_synchronously
    showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Edit Message',
              style: TextStyle(
                color: ThemeColors.kMainColor(context),
                fontSize: 20,
              ),
            ),
            content: TextFormField(
              onChanged: (data) {
                messageBuffer = data;
              },
              initialValue: message.text,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.white),
                  gapPadding: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.white),
                  gapPadding: 20,
                ),
                contentPadding: EdgeInsets.all(20),
                suffixIcon: Icon(Icons.edit_rounded),
                suffixIconColor: Colors.white,
              ),
            ),
            backgroundColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            actionsPadding:
                const EdgeInsets.only(top: 10, right: 10, bottom: 20),
            actions: [
              GestureDetector(
                onTap: () async {
                  messageBuffer == ''
                      ? await updateMessage(messages, itemId!, message.text)
                      : await updateMessage(
                          messages, itemId!, messageBuffer.trim());
                  emit(ChatEditMessageSucssesState());
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  decoration: BoxDecoration(
                    color: ThemeColors.kMainColor(context),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Edit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Cancel',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        color: ThemeColors.kMainColor(context),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          );
        });
  }

  String getTime(var hour, var minute, var second, var millisecond, var day,
      var month, var year) {
    String getHour,
        getMinute,
        getSecond,
        getMilliSecond,
        getDay,
        getMonth,
        getYear;

    hour < 10 ? getHour = '0$hour' : getHour = '$hour';

    minute < 10 ? getMinute = '0$minute' : getMinute = '$minute';

    second < 10 ? getSecond = '0$second' : getSecond = '$second';

    millisecond < 10
        ? getMilliSecond = '0$millisecond'
        : getMilliSecond = '$millisecond';

    day < 10 ? getDay = '0$day' : getDay = '$day';

    month < 10 ? getMonth = '0$month' : getMonth = '$month';

    getYear = '$year';

    return '$getHour:$getMinute:$getSecond:$getMilliSecond:$getDay:$getMonth:$getYear';
  }
}

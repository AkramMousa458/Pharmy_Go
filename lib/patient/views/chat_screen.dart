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

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  static String routeName = 'ChatScreen';

  static final TextEditingController messageController =
      TextEditingController();

  String? userMessage;

  static final _controller = ScrollController();

  // final soundPlayer = AudioPlayer();
  ScreenArgs? args;

  List<Message> chat = [];
  List<Message> thisChat = [];

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as ScreenArgs;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                ),
                tooltip: 'Back',
              ),
              Row(
                children: [
                  // Container(
                  //   width: 38,
                  //   height: 38,
                  //   decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //         image: NetworkImage(args!.friendPhoto),
                  //       ),
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(150)),
                  // ),
                  const SizedBox(width: 7),
                  Text(
                    args!.friendName,
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
              SizedBox(width: MediaQuery.sizeOf(context).width / 8)
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
                    // showSnackBar(
                    //     context: context,
                    //     text: state.errMessage,
                    //     icon: Icons.error,
                    //     backColor: Colors.red);
                  } else if (state is ChatEditMessageSucssesState) {
                    Navigator.pop(context);
                  } else if (state is ChatEditMessageFailureState) {
                    showSnackBar(context, state.errMessage);
                    // showSnackBar(
                    //     context: context,
                    //     text: state.errMessage,
                    //     icon: Icons.error,
                    //     backColor: Colors.red);
                  }
                },
                builder: (context, state) {
                  chat = BlocProvider.of<ChatCubit>(context).messagesList;
                  thisChat = BlocProvider.of<ChatCubit>(context).chatList;
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    reverse: true,
                    controller: _controller,
                    itemCount: thisChat.length,
                    itemBuilder: (context, index) {
                      return thisChat[index].id == args!.userEmail &&
                              thisChat[index].friendId == args!.friendEmail
                          ? Slidable(
                              key: UniqueKey(),
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
                                              BlocProvider.of<ChatCubit>(
                                                      context)
                                                  .delMessage(
                                                message: thisChat[index],
                                              );
                                            },
                                            title: 'Delete Message',
                                            body:
                                                'Do you want delete the message',
                                            no: 'Cancel',
                                            confirm: 'Delete');
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
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<ChatCubit>(context)
                                            .editMessage(
                                                message: thisChat[index],
                                                context: context);
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
                              child:
                                  MessageBubbleSend(message: thisChat[index]),
                            )
                          : MessageBubbleReceive(message: thisChat[index]);
                    },
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
                        controller: messageController,
                        onChanged: (data) {
                          userMessage = data;
                        },
                        onSubmitted: (data) {
                          BlocProvider.of<ChatCubit>(context).sendMessage(
                              userMessage: data,
                              context: context,
                              userEmail: args!.userEmail,
                              friendEmail: args!.friendEmail);
                          _controller.animateTo(0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn);
                          // soundPlayer
                          //     .play(AssetSource('sounds/message_sound.mp3'));

                          messageController.clear();
                          userMessage = null;
                        },
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                          hintText: 'Message',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(200),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<ChatCubit>(context).sendMessage(
                            userMessage: userMessage!,
                            context: context,
                            userEmail: args!.userEmail,
                            friendEmail: args!.friendEmail);

                        _controller.animateTo(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn);
                        // soundPlayer
                        //     .play(AssetSource('sounds/message_sound.mp3'));

                        userMessage = '';
                        messageController.clear();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        margin: const EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                            color: ThemeColors.kMainColor(context),
                            borderRadius: BorderRadius.circular(100)),
                        child: const Icon(
                          Icons.send_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}

// else {
//             return Scaffold(
//                 appBar: AppBar(
//                   automaticallyImplyLeading: false,
//                   title: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(kLogo, height: 38),
//                       const SizedBox(width: 6),
//                       const Text('Chaty')
//                     ],
//                   ),
//                   backgroundColor: kPrimaryColor,
//                 ),
//                 body: Column(
//                   children: [
//                     Expanded(
//                       child: Center(
//                         child: Text(
//                           'Waiting to load messages..',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: kPrimaryColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                         padding: const EdgeInsets.all(15),
//                         child: Row(
//                           children: [
//                             const Expanded(
//                               child: TextField(
//                                 style: TextStyle(fontSize: 18),
//                                 maxLines: 1,
//                                 decoration: InputDecoration(
//                                   hintText: 'Message',
//                                   contentPadding: EdgeInsets.symmetric(
//                                       vertical: 14, horizontal: 20),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(200),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             GestureDetector(
//                               child: Container(
//                                 padding: const EdgeInsets.all(14),
//                                 margin: const EdgeInsets.only(left: 5),
//                                 decoration: BoxDecoration(
//                                     color: kPrimaryColor,
//                                     borderRadius: BorderRadius.circular(100)),
//                                 child: const Icon(
//                                   Icons.send_rounded,
//                                   size: 30,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ))
//                   ],
//                 ));
//           }

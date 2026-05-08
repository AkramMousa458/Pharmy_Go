// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/chat_methods.dart';
import 'package:pharmygo/core/utils/constants.dart';
import 'package:pharmygo/patient/cubits/patient_cubit/patient_cubit.dart';
import 'package:pharmygo/patient/models/screen_args.dart';
import 'package:pharmygo/patient/views/chat_screen.dart';
import 'package:pharmygo/patient/widgets/user_widget.dart';
import 'package:pharmygo/pharmacist/cubits/pharmacist_cubit/pharmacist_cubit.dart';
import 'package:pharmygo/public/cubits/chat_cubit/chat_cubit.dart';
import 'package:pharmygo/public/models/auth_model.dart';

late CollectionReference people;

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  static String routeName = 'PeopleScreen';

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    var userModel;
    var args = ModalRoute.of(context)!.settings.arguments as String;
    if (args == 'patient') {
      userModel = BlocProvider.of<PatientCubit>(context).patient!;
      people = FirebaseFirestore.instance.collection(kPharmacistesCollection);
    } else if (args == 'doctor') {
      userModel = BlocProvider.of<PharmacistCubit>(context).pharmacist!;
      people = FirebaseFirestore.instance.collection(kPatientsCollection);
    }

    return StreamBuilder<QuerySnapshot>(
        stream: people.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<AuthModel> usersList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              usersList.add(AuthModel.fromSnapshot(snapshot.data!.docs[i]));
            }
            return Scaffold(
              backgroundColor: ThemeColors.kMainColor(context),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.arrowLeft),
                            color: ThemeColors.kTextColor(context),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Text(
                            'Chats',
                            style: TextStyle(
                                color: ThemeColors.kTextColor(context),
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: usersList.length,
                                itemBuilder: (context, index) {
                                  return MaterialButton(
                                    onPressed: () {
                                      BlocProvider.of<ChatCubit>(context)
                                          .getMessages(
                                              context: context,
                                              userEmail: userModel.email,
                                              friendEmail:
                                                  usersList[index].email);
                                      Navigator.pushNamed(
                                        context,
                                        ChatScreen.routeName,
                                        arguments: ScreenArgs(
                                          userEmail: userModel.email,
                                          friendName: usersList[index].name,
                                          friendEmail: usersList[index].email,
                                          // friendPhoto: usersList[index].photo,
                                        ),
                                      );
                                    },
                                    child: UserWidget(
                                        user: usersList[index],
                                        userName: findUserName(
                                            usersList, userModel.email)),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Loading Chats'),
              ),
            );
          }
        });
  }
}


enum MenuItem {
  search,
  setting,
}

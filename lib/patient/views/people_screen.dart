// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/chat_methods.dart';
import 'package:pharmygo/core/utils/constants.dart';
import 'package:pharmygo/patient/cubits/patient_cubit/patient_cubit.dart';
import 'package:pharmygo/patient/cubits/get_nearst_pharmacies/get_nearst_pharmacies_cubit.dart';
import 'package:pharmygo/patient/models/screen_args.dart';
import 'package:pharmygo/patient/views/chat_screen.dart';
import 'package:pharmygo/patient/widgets/user_widget.dart';
import 'package:pharmygo/pharmacist/cubits/pharmacist_cubit/pharmacist_cubit.dart';
import 'package:pharmygo/public/cubits/chat_cubit/chat_cubit.dart';
import 'package:pharmygo/public/models/auth_model.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  static String routeName = 'PeopleScreen';

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  String? _userType;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_userType != null) return;

    _userType = ModalRoute.of(context)?.settings.arguments as String?;
    if (_userType == null) return;

    if (_userType == 'patient') {
      context.read<PatientCubit>().getPatient();
    } else if (_userType == 'doctor') {
      context.read<PharmacistCubit>().getPharmaicst();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_userType == null) {
      return _messageScaffold(
          'Invalid chat session. Please go back and try again.');
    }

    if (_userType == 'patient') {
      return BlocBuilder<PatientCubit, PatientState>(
        builder: (context, state) {
          if (state is FetchPatientSuccess) {
            return _PatientChatPeopleList(
              patientEmail: state.patient.email,
              patientName: state.patient.name,
            );
          }
          if (state is FetchPatientFailure) {
            return _messageScaffold(state.errMesage);
          }
          return _loadingScaffold();
        },
      );
    }

    if (_userType == 'doctor') {
      return BlocBuilder<PharmacistCubit, PharmacistState>(
        builder: (context, state) {
          if (state is FetchPharmacistSuccess) {
            return _PharmacistChatPeopleList(
              pharmacistEmail: state.pharmacist.email,
              pharmacistName: state.pharmacist.name,
            );
          }
          if (state is FetchPharmacistFailure) {
            return _messageScaffold(state.errMesage);
          }
          return _loadingScaffold();
        },
      );
    }

    return _messageScaffold('Unsupported user type.');
  }

  Widget _loadingScaffold() {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _messageScaffold(String message) {
    return Scaffold(
      backgroundColor: ThemeColors.kMainColor(context),
      body: SafeArea(
        child: Column(
          children: [
            _ChatsHeader(onBack: () => Navigator.pop(context)),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatsHeader extends StatelessWidget {
  const _ChatsHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.arrowLeft),
            color: ThemeColors.kTextColor(context),
            onPressed: onBack,
          ),
          Text(
            'Chats',
            style: TextStyle(
              color: ThemeColors.kTextColor(context),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatsBody extends StatelessWidget {
  const _ChatsBody({
    required this.usersList,
    required this.userEmail,
    required this.userName,
    required this.emptyMessage,
  });

  final List<AuthModel> usersList;
  final String userEmail;
  final String userName;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.kMainColor(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ChatsHeader(onBack: () => Navigator.pop(context)),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: usersList.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            emptyMessage,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: usersList.length,
                        itemBuilder: (context, index) {
                          final friend = usersList[index];
                          return MaterialButton(
                            onPressed: () {
                              context.read<ChatCubit>().getMessages(
                                    context: context,
                                    userEmail: userEmail,
                                    friendEmail: friend.email,
                                  );
                              Navigator.pushNamed(
                                context,
                                ChatScreen.routeName,
                                arguments: ScreenArgs(
                                  userEmail: userEmail,
                                  friendName: friend.name,
                                  friendEmail: friend.email,
                                ),
                              );
                            },
                            child: UserWidget(
                              user: friend,
                              userName: userName,
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PatientChatPeopleList extends StatefulWidget {
  const _PatientChatPeopleList({
    required this.patientEmail,
    required this.patientName,
  });

  final String patientEmail;
  final String patientName;

  @override
  State<_PatientChatPeopleList> createState() => _PatientChatPeopleListState();
}

class _PatientChatPeopleListState extends State<_PatientChatPeopleList> {
  @override
  void initState() {
    super.initState();
    context.read<GetNearstPharmaciesCubit>().getNearstPharmacies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNearstPharmaciesCubit, GetNearstPharmaciesState>(
      builder: (context, pharmaciesState) {
        if (pharmaciesState is GetNearstPharmaciesFailure) {
          return _ChatsBody(
            usersList: const [],
            userEmail: widget.patientEmail,
            userName: widget.patientName,
            emptyMessage: pharmaciesState.errMessage,
          );
        }

        if (pharmaciesState is! GetNearstPharmaciesSuccsess) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(kPharmacistesCollection)
              .snapshots(),
          builder: (context, pharmacistsSnapshot) {
            if (pharmacistsSnapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text(
                    'Failed to load pharmacists: ${pharmacistsSnapshot.error}',
                  ),
                ),
              );
            }

            if (!pharmacistsSnapshot.hasData) {
              return const Scaffold(
                body: Center(child: Text('Loading Chats')),
              );
            }

            final pharmacists = pharmacistsSnapshot.data!.docs
                .map((doc) => AuthModel.fromSnapshot(doc.data()))
                .where((user) => user.email != widget.patientEmail)
                .toList();

            final usersList = dedupeAuthModelsByEmail(
              buildPatientPharmacyContacts(
                nearestPharmacies: pharmaciesState.nearstPharmacies,
                firestorePharmacists: pharmacists,
                patientEmail: widget.patientEmail,
              ),
            );

            return _ChatsBody(
              usersList: usersList,
              userEmail: widget.patientEmail,
              userName: widget.patientName,
              emptyMessage: 'No pharmacies or pharmacists available to chat with yet.',
            );
          },
        );
      },
    );
  }
}

class _PharmacistChatPeopleList extends StatelessWidget {
  const _PharmacistChatPeopleList({
    required this.pharmacistEmail,
    required this.pharmacistName,
  });

  final String pharmacistEmail;
  final String pharmacistName;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(kPharmacistesCollection)
          .snapshots(),
      builder: (context, pharmacistsSnapshot) {
        if (pharmacistsSnapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Failed to load pharmacists: ${pharmacistsSnapshot.error}',
              ),
            ),
          );
        }

        if (!pharmacistsSnapshot.hasData) {
          return const Scaffold(
            body: Center(child: Text('Loading Chats')),
          );
        }

        final firestorePharmacists = pharmacistsSnapshot.data!.docs
            .map((doc) => AuthModel.fromSnapshot(doc.data()))
            .toList();

        final identityEmails = collectPharmacistIdentityEmails(
          pharmacistEmail: pharmacistEmail,
          pharmacistName: pharmacistName,
          firestorePharmacists: firestorePharmacists,
        );

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(kMessagesCollection)
              .snapshots(),
          builder: (context, messagesSnapshot) {
            if (messagesSnapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text('Failed to load chats: ${messagesSnapshot.error}'),
                ),
              );
            }

            if (!messagesSnapshot.hasData) {
              return const Scaffold(
                body: Center(child: Text('Loading Chats')),
              );
            }

            final patientEmails = getChatPartnerEmailsForIdentities(
              messagesSnapshot.data!.docs,
              identityEmails,
            );

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(kPatientsCollection)
                  .snapshots(),
              builder: (context, patientsSnapshot) {
                if (patientsSnapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text(
                        'Failed to load patients: ${patientsSnapshot.error}',
                      ),
                    ),
                  );
                }

                if (!patientsSnapshot.hasData) {
                  return const Scaffold(
                    body: Center(child: Text('Loading Chats')),
                  );
                }

                final allPatients = patientsSnapshot.data!.docs
                    .map((doc) => AuthModel.fromSnapshot(doc.data()))
                    .toList();

                final usersList = buildUniqueChatUsers(
                  partnerEmails: patientEmails,
                  profiles: allPatients,
                  fallbackUserType: 'patient',
                )
                  ..sort(
                    (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
                  );

                return _ChatsBody(
                  usersList: usersList,
                  userEmail: pharmacistEmail,
                  userName: pharmacistName,
                  emptyMessage:
                      'No patients have messaged your pharmacy yet.',
                );
              },
            );
          },
        );
      },
    );
  }
}

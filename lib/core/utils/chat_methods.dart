// ignore_for_file: avoid_print, avoid_single_cascade_in_expression_statements

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmygo/core/utils/constants.dart';
import 'package:pharmygo/pharmacist/models/nearst_pharmacy_model.dart';
import 'package:pharmygo/public/models/auth_model.dart';
import 'package:pharmygo/public/models/message_model.dart';

Future<String?> getDocumentId({required Message localMessage}) async {
  try {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection(kMessagesCollection);

    QuerySnapshot querySnapshot = await collectionRef
        .where(kMessage, isEqualTo: localMessage.text)
        .where(kTime, isEqualTo: localMessage.time)
        .where(kId, isEqualTo: localMessage.id)
        .where(kFriendId, isEqualTo: localMessage.friendId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    } else {
      return 'Document not found'; // Document not found
    }
  } catch (e) {
    // Handle errors here
    print('Error getting document ID: $e');
    return 'Error getting document ID: $e';
  }
}

deleteMessage(CollectionReference messages, String id) async {
  messages.doc(id).delete()
    ..then((_) => print('Deleted'))
        .catchError((error) => print('Delete failed: $error'));
}

updateMessage(CollectionReference messages, String id, String text) {
  messages.doc(id).update({kMessage: text})
    ..then((_) => print('${messages.doc(id).toString()}Edited'))
        .catchError((error) => print('Edit failed: $error'));
}

String normalizeChatEmail(String email) => email.trim().toLowerCase();

Set<String> getChatPartnerEmails(
  Iterable<QueryDocumentSnapshot> messageDocs,
  String userEmail,
) {
  return getChatPartnerEmailsForIdentities(
    messageDocs,
    {userEmail},
  );
}

Set<String> collectPharmacistIdentityEmails({
  required String pharmacistEmail,
  required String pharmacistName,
  required Iterable<AuthModel> firestorePharmacists,
}) {
  final identities = <String>{pharmacistEmail};
  final normalizedName = pharmacistName.trim().toLowerCase();

  for (final pharmacist in firestorePharmacists) {
    final firestoreName = pharmacist.name.trim().toLowerCase();
    if (firestoreName.isEmpty) continue;

    if (firestoreName == normalizedName ||
        firestoreName.contains(normalizedName) ||
        normalizedName.contains(firestoreName)) {
      identities.add(pharmacist.email);
    }
  }

  return identities;
}

Set<String> getChatPartnerEmailsForIdentities(
  Iterable<QueryDocumentSnapshot> messageDocs,
  Set<String> userEmails,
) {
  final partners = <String, String>{};
  final normalizedIdentities =
      userEmails.map(normalizeChatEmail).where((email) => email.isNotEmpty).toSet();

  if (normalizedIdentities.isEmpty) return {};

  for (final doc in messageDocs) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) continue;

    final sender = data[kId]?.toString() ?? '';
    final friend = data[kFriendId]?.toString() ?? '';
    if (sender.isEmpty || friend.isEmpty) continue;

    final normalizedSender = normalizeChatEmail(sender);
    final normalizedFriend = normalizeChatEmail(friend);

    if (normalizedIdentities.contains(normalizedSender) &&
        !normalizedIdentities.contains(normalizedFriend)) {
      partners.putIfAbsent(normalizedFriend, () => friend);
    } else if (normalizedIdentities.contains(normalizedFriend) &&
        !normalizedIdentities.contains(normalizedSender)) {
      partners.putIfAbsent(normalizedSender, () => sender);
    }
  }
  return partners.values.toSet();
}

List<AuthModel> buildUniqueChatUsers({
  required Set<String> partnerEmails,
  required Iterable<AuthModel> profiles,
  required String fallbackUserType,
}) {
  final normalizedPartners = {
    for (final email in partnerEmails) normalizeChatEmail(email): email,
  };

  final usersByEmail = <String, AuthModel>{};

  for (final profile in profiles) {
    final key = normalizeChatEmail(profile.email);
    if (!normalizedPartners.containsKey(key)) continue;
    usersByEmail.putIfAbsent(key, () => profile);
  }

  for (final entry in normalizedPartners.entries) {
    final profileName = findUserName(profiles.toList(), entry.value);
    usersByEmail.putIfAbsent(
      entry.key,
      () => AuthModel(
        name: profileName == 'User Name' ? entry.value : profileName,
        email: entry.value,
        phone: findUserphone(profiles.toList(), entry.value),
        userType: fallbackUserType,
        id: 0,
      ),
    );
  }

  return usersByEmail.values.toList();
}

bool pharmacistNamesMatch(String left, String right) {
  final normalizedLeft = left.trim().toLowerCase();
  final normalizedRight = right.trim().toLowerCase();
  if (normalizedLeft.isEmpty || normalizedRight.isEmpty) return false;
  if (normalizedLeft == normalizedRight) return true;
  return normalizedLeft.contains(normalizedRight) ||
      normalizedRight.contains(normalizedLeft);
}

AuthModel? findMatchingPharmacist(
  String pharmacistName,
  Iterable<AuthModel> pharmacists,
) {
  for (final pharmacist in pharmacists) {
    if (pharmacistNamesMatch(pharmacist.name, pharmacistName)) {
      return pharmacist;
    }
  }
  return null;
}

List<AuthModel> buildPatientPharmacyContacts({
  required List<NearestPharmacyModel> nearestPharmacies,
  required List<AuthModel> firestorePharmacists,
  required String patientEmail,
}) {
  final contacts = <AuthModel>[];
  final seenKeys = <String>{};
  final normalizedPatientEmail = normalizeChatEmail(patientEmail);
  final listedPharmacistEmails = <String>{};

  for (final pharmacy in nearestPharmacies) {
    final matched = findMatchingPharmacist(
      pharmacy.pharmacist,
      firestorePharmacists,
    );
    if (matched == null) continue;
    if (normalizeChatEmail(matched.email) == normalizedPatientEmail) continue;

    final key =
        '${normalizeChatEmail(matched.email)}|${pharmacy.pharmacyName.trim().toLowerCase()}';
    if (!seenKeys.add(key)) continue;

    listedPharmacistEmails.add(normalizeChatEmail(matched.email));
    contacts.add(
      AuthModel(
        name: '${pharmacy.pharmacyName} (${pharmacy.pharmacist})',
        email: matched.email,
        phone: matched.phone,
        userType: 'pharmacist',
        id: matched.id,
      ),
    );
  }

  for (final pharmacist in firestorePharmacists) {
    final emailKey = normalizeChatEmail(pharmacist.email);
    if (emailKey.isEmpty || emailKey == normalizedPatientEmail) continue;
    if (listedPharmacistEmails.contains(emailKey)) continue;

    final key = 'pharmacist|$emailKey';
    if (!seenKeys.add(key)) continue;

    contacts.add(pharmacist);
  }

  contacts.sort(
    (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
  );
  return contacts;
}

List<AuthModel> dedupeAuthModelsByEmail(List<AuthModel> users) {
  final usersByEmail = <String, AuthModel>{};
  for (final user in users) {
    final key = normalizeChatEmail(user.email);
    if (key.isEmpty) continue;
    usersByEmail.putIfAbsent(key, () => user);
  }
  return usersByEmail.values.toList();
}

String? getFirstChatPartnerEmail(
  Iterable<QueryDocumentSnapshot> messageDocs,
  String userEmail,
) {
  final relevantDocs = <QueryDocumentSnapshot>[];
  final normalizedUserEmail = normalizeChatEmail(userEmail);

  for (final doc in messageDocs) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) continue;

    final sender = data[kId]?.toString() ?? '';
    final friend = data[kFriendId]?.toString() ?? '';
    if (sender.isEmpty || friend.isEmpty) continue;

    final normalizedSender = normalizeChatEmail(sender);
    final normalizedFriend = normalizeChatEmail(friend);

    if (normalizedSender == normalizedUserEmail ||
        normalizedFriend == normalizedUserEmail) {
      relevantDocs.add(doc);
    }
  }

  if (relevantDocs.isEmpty) return null;

  relevantDocs.sort((a, b) {
    final aData = a.data() as Map<String, dynamic>;
    final bData = b.data() as Map<String, dynamic>;
    return _orderTime(aData[kOrderTime]).compareTo(_orderTime(bData[kOrderTime]));
  });

  final data = relevantDocs.first.data() as Map<String, dynamic>;
  final sender = data[kId]?.toString() ?? '';
  final friend = data[kFriendId]?.toString() ?? '';

  if (normalizeChatEmail(sender) == normalizedUserEmail &&
      normalizeChatEmail(friend) != normalizedUserEmail) {
    return friend;
  }
  if (normalizeChatEmail(friend) == normalizedUserEmail &&
      normalizeChatEmail(sender) != normalizedUserEmail) {
    return sender;
  }
  return null;
}

DateTime _orderTime(dynamic value) {
  if (value is Timestamp) return value.toDate();
  if (value is DateTime) return value;
  return DateTime.fromMillisecondsSinceEpoch(0);
}

String findUserName(List<AuthModel> listOfAuthModel, String email) {
  final normalizedEmail = normalizeChatEmail(email);
  for (int i = 0; i < listOfAuthModel.length; i++) {
    if (normalizeChatEmail(listOfAuthModel[i].email) == normalizedEmail) {
      return listOfAuthModel[i].name;
    }
  }
  return 'User Name';
}

// String findUserPhoto(List<AuthModel> listOfAuthModel, String email) {
//   for (int i = 0; i < listOfAuthModel.length; i++) {
//     if (listOfAuthModel[i].email == email) {
//       return listOfAuthModel[i].photo;
//     }
//   }
//   return 'User Photo';
// }

String findUserphone(List<AuthModel> listOfAuthModel, String email) {
  final normalizedEmail = normalizeChatEmail(email);
  for (int i = 0; i < listOfAuthModel.length; i++) {
    if (normalizeChatEmail(listOfAuthModel[i].email) == normalizedEmail) {
      return listOfAuthModel[i].phone;
    }
  }
  return 'User phone';
}

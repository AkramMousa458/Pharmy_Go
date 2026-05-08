// ignore_for_file: avoid_print, avoid_single_cascade_in_expression_statements

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmygo/core/utils/constants.dart';
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

String findUserName(List<AuthModel> listOfAuthModel, String email) {
  for (int i = 0; i < listOfAuthModel.length; i++) {
    if (listOfAuthModel[i].email == email) {
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
  for (int i = 0; i < listOfAuthModel.length; i++) {
    if (listOfAuthModel[i].email == email) {
      return listOfAuthModel[i].phone;
    }
  }
  return 'User phone';
}

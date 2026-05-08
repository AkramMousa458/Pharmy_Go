import 'package:pharmygo/core/utils/constants.dart';

class AuthModel {
  final String name;
  final String email;
  final String phone;
  final String userType;
  final int id;

  AuthModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.userType,
      required this.id});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      userType: json["user_type"],
      id: json["id"],
    );
  }

  factory AuthModel.fromSnapshot(jsonData) {
    return AuthModel(
      email: jsonData[kEmail],
      id: 0,
      name: jsonData[kName],
      phone: jsonData[kphone],
      userType: '',
      // jsonData[photoConst],
    );
  }
}

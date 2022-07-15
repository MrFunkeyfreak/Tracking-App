import 'package:cloud_firestore/cloud_firestore.dart';

// usermodel to get all informations of a user
// get used in auth.dart for database requests
class UserModel {
  final String UID = "uid";
  final String USERNAME = "username";
  final String EMAIL = "email";
  final String FIRSTNAME = "first name";
  final String LASTNAME = "last name";
  final String BIRTHDAY = "birthday";
  final String GENDER = "gender";
  final String STATUS = "status";
  final String ROLE = 'role';

  String? _uid;
  String? _username;
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _birthday;
  String? _gender;
  String? _status;
  String? _role;

  // getters
  String? get uid => _uid;
  String? get username => _username;
  String? get email => _email;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get birthday => _birthday;
  String? get gender => _gender;
  String? get status => _status;
  String? get role => _role;

  // input snapshot - get all the data from a user by the input snapshot
  // get used in auth.dart for database requests
  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    _uid = data[UID];
    _username = data[USERNAME];
    _email = data[EMAIL];
    _firstName = data[FIRSTNAME];
    _lastName = data[LASTNAME];
    _birthday = data[BIRTHDAY];
    _gender = data[GENDER];
    _status = data[STATUS];
    _role = data[ROLE];
  }
}

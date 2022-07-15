import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../datamodels/user_model.dart';
import '../services/user_services.dart';

// setting status at login, which role is logged in
enum Status { Uninitialized, Admin, Scientist, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  AuthProvider({Key? key});

  User? _user;
  Status _status = Status.Uninitialized;
  final UserServices _userServices = UserServices();
  UserModel? _userModel;

  //  getter
  UserModel? get userModel => _userModel;
  Status get status => _status;
  User? get user => _user;

  // public variables
  UserServices userServices = UserServices();

  AuthProvider.initialize() {
    _fireSetUp();
  }

  _fireSetUp() async {
    //initializeApp (Firebase connection) and check changes
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBDTaDfjNVxDgM82AAq9jgVYOjtiQ4CV7Y",
          authDomain: "tracking-app-5aafd.firebaseapp.com",
          databaseURL:
              "https://tracking-app-5aafd-default-rtdb.europe-west1.firebasedatabase.app",
          projectId: "tracking-app-5aafd",
          storageBucket: "tracking-app-5aafd.appspot.com",
          messagingSenderId: "792812168466",
          appId: "1:792812168466:web:0c88adc20adda5328e7fcb",
          measurementId: "G-W3QVMWFDD3"),
    ).then((value) {
      FirebaseAuth.instance.authStateChanges().listen(_onStateChanged);
    });
  }

  // checking if user is allowed to have access
  _onStateChanged(User? firebaseUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      await prefs.setString("id", firebaseUser.uid);

      _userModel =
          await _userServices.getUserById(user!.uid).then((value) async {
        //checking if user is Authenticated
        Map<String, dynamic>? mapUserinformations = {};
        mapUserinformations =
            await getUserByUid(user!.uid);
        if (mapUserinformations['role'] == 'Admin') {
          _status = Status.Admin; //admin
          print('role is admin');
        }
        if (mapUserinformations['role'] == 'Scientist') {
          _status = Status.Scientist; //scientist
          print('role is scientist');
        }
        if (mapUserinformations['role'] == 'User') {
          _status = Status.Unauthenticated; //scientist
          print('role is user');
        }
        return value; //userModel
      });
    }
    notifyListeners();
  }

  // sign in the user -> used for login page (input = email and password)
  Future<bool> signIn(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      _status = Status.Authenticating;
      notifyListeners(); //changing status
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await prefs.setString("id", value.user!.uid); //checking user
      });

      // now check if user is admin or scientist
      var mapUserinformations = {};
      mapUserinformations = await getUserByEmail(email);

      if (mapUserinformations['role'] == 'Admin') {
        _status = Status.Admin; //admin
        print('role is admin');
      }
      if (mapUserinformations['role'] == 'Wissenschaftler') {
        _status = Status.Scientist; //scientist
        print('role is scientist');
      }

      if (mapUserinformations['role'] == 'User') {
        _status = Status.Unauthenticated; //scientist
        print('role is user');
      }
      notifyListeners();
      return true;
    } catch (e) {
      print('error, daher Status.Unauthenticated');
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  // update user - especially made for the edit button in the user tables as admin
  Future<void> updateUserEdit(
      String? uid,
      String username,
      String email,
      String firstName,
      String lastName,
      String? birthday,
      String? gender,
      String? role) async {
    print("username: " + username + "email: " + email);
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({
          'username': username,
          'email': email,
          'first name': firstName,
          'last name': lastName,
          'birthday': birthday,
          'gender': gender,
          'role': role,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  // update user - especially made for the sign up in the registration pages (when user has status deleted)
  Future<void> updateUserSignup(
      String? uid,
      String username,
      String email,
      String? firstName,
      String? lastName,
      String? birthday,
      String? gender,
      String? role) async {
    print("username: " + username + "email: " + email);
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({
          'username': username,
          'email': email,
          'first name': firstName,
          'last name': lastName,
          'birthday': birthday,
          'gender': gender,
          'status': 'aktiv',
          'role': role,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  // update user - especially made for changing status in the user tables (input: id and the value of the changed status)
  Future<void> updateUserStatus(String? id, String status) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'status': status})
        .then((value) => print("User status Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  // input: email -> get the user data (used in registration, login and user_administration -> check if a user with this email already exist)
  Future<Map<String, dynamic>> getUserByEmail(String email) async {
    Map<String, dynamic>? userData = {};
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get()
          .then((QuerySnapshot docs) {
        if (docs.docs.isNotEmpty) {
          print('test not empty + emailcontroller: ' + email);
          userData = docs.docs[0].data() as Map<String, dynamic>?;
        }
      });
      return userData as Map<String, dynamic>;
    } catch (e) {
      print('Fehler getUserByEmail: ' + e.toString());
    }
    //print('getUserByEmail2 = ' + userData);
    return userData as Map<String, dynamic>;
  }

  // input: username -> get the user data (used in registration, login and user_administration -> check if a user with this username already exist)
  Future<Map<String, dynamic>?> UsernameExist(String username) async {
    Map<String, dynamic>? userData = {};
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .get()
          .then((QuerySnapshot docs) {
        if (docs.docs.isNotEmpty) {
          print('test not empty + username: ' + username);
          userData = docs.docs[0].data() as Map<String, dynamic>?;
        }
      });
      return userData;
    } catch (e) {
      print('Fehler getUserByEmail: ' + e.toString());
    }
    return userData as Map<String, dynamic>?;
  }

  // input: id -> get the user data as Map<String, dynamic>
  // used for reloadUserModel in this file
  Future<Map<String, dynamic>> getUserByUid(String uid) async {
    var userData;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get()
          .then((QuerySnapshot docs) {
        if (docs.docs.isNotEmpty) {
          print('getUserByUid not empty');
          userData = docs.docs[0].data();
          return userData;
        }
      });
    } catch (e) {
      print('Fehler getUserByUid: ' + e.toString());
    }
    return userData;
  }

/*                 //not in use anymore
  Future <bool> getAdminExistence()async{  //bearbeiten
    print('hier wird abgefragt: '+emailController.text.trim());
    var i = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: emailController.text.trim(),)
        .get();
    if(i.size > 0){
      print('mit der email gibt admins: '+i.size.toString());
      return true;
    }
    else{
      return false;
    }
  }

  Future <bool> getScientistExistence()async{ //bearbeiten
    var i = await FirebaseFirestore.instance
        .collection('scientists')
        .where('email', isEqualTo: emailController.text.trim())
        .get();
    if(i.size > 0){
      return true;
    }
    else{
      return false;
    }
  }  */

  // delete a user from FirebaseFirestore -> not in use because we can't delete the user from Authentication Firebase
  static Future deleteUser(String uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).delete();
  }

  // signUp a user in the database (Authentication Firebase and Firestore Database) - the user won't get auto logged in because of the second instance
  // used as admin to create a user with a choosen role - in Benutzerverwaltung
  Future<bool> signUpUserAdmin(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
      String? birthday,
      String? gender,
      String? role) async {
    try {
      FirebaseApp secondaryApp = await Firebase.initializeApp(
        name: 'Secondary',
        options: Firebase.app().options,
      );

      try {
        UserCredential? credential = await FirebaseAuth.instanceFor(
                app: secondaryApp)
            .createUserWithEmailAndPassword(email: email, password: password);

        _userServices.createUser(
          uid: await credential.user!.uid,
          username: username,
          email: email,
          firstName: firstName,
          lastName: lastName,
          birthday: birthday,
          gender: gender,
          status: 'aktiv',
          role: role,
        );

        if (credential.user == null) {
          throw 'An error occured. Please try again.';
        }
        await credential.user!.sendEmailVerification();
        print('send verfication');
        await secondaryApp.delete();
        print('deleted instance');
      } on FirebaseAuthException catch (e) {
        print(e);
      }

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // signUp a user in the database (Authentication Firebase and Firestore Database) - the user won't get auto logged in because of the second instance
  // used in registration or Wissenschaftlerverwaltung
  Future<bool> signUpUser(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
      String? birthday,
      String? gender) async {
    try {
      _status = Status.Authenticating;
      notifyListeners(); //changing status

      FirebaseApp secondaryApp = await Firebase.initializeApp(
        name: 'Secondary',
        options: Firebase.app().options,
      );

      try {
        UserCredential? credential = await FirebaseAuth.instanceFor(
                app: secondaryApp)
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((result) async {
          //User user = result.user;
          _userServices.createUser(
            uid: result.user!.uid,
            username: username,
            email: email,
            firstName: firstName,
            lastName: lastName,
            birthday: birthday,
            gender: gender,
            status: 'aktiv',
            role: 'User',
          );
        });
        print('user created');

        await credential?.user!.sendEmailVerification();
      } on FirebaseAuthException catch (e) {
        print(e);
      }
      print('secondapp deleted');
      await secondaryApp.delete();
      _status = Status.Unauthenticated;
      notifyListeners();
      print('secondapp deleted');

      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  //signOut a user - used in every page after the login (in the TopNavigationBar)
  Future signOut() async {
    FirebaseAuth.instance.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  //reloads the userModel - used in user_administration_view... table
  Future<void> reloadUserModel() async {
    //reloading user data
    _userModel = await _userServices.getUserById(user!.uid);
    notifyListeners();
  }

  //validation of the email -> not in use, because I am using a package
  String? validateEmail(String email) {
    //validate the email textfield
    RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email.isEmpty) {
      return 'Bitte gib eine E-Mail ein.';
    } else {
      if (!regex.hasMatch(email)) {
        return 'Bitte gib eine gültige E-Mail ein.';
      } else {
        return null;
      }
    }
  }

  // used in every TextFormField, which is named password
  // at least one upper case, lower case, one digit, one Special character and at least 8  and max 18 characters in length
  String? validatePassword(String password) {
    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,18}$');
    if (password.isEmpty) {
      return 'Bitte gib ein Passwort ein.';
    } else {
      if (!regex.hasMatch(password)) {
        return 'Bitte gib ein gültiges Passwort ein.';
      } else {
        return null;
      }
    }
  }

  // validate the username TextFormField
  String? validateUsername(String username) {
    RegExp regex = RegExp(r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$');
    if (username.isEmpty) {
      return 'Bitte gib einen Benutzernamen ein.';
    } else {
      if (!regex.hasMatch(username)) {
        return 'Bitte gib einen gültigen Benutzernamen ein.';
      } else {
        return null;
      }
    }
  }

  // validate the name TextFormField
  String? validateName(String name) {
    // so modifizieren, dass (^[A-Z]*) = erster buchstabe immer groß
    RegExp regex = RegExp(
        r"(^[A-Z]*)^[\w'\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{1,}$");
    if (name.isEmpty) {
      return 'Bitte gib einen Namen ein.';
    } else {
      if (!regex.hasMatch(name)) {
        return 'Bitte gib einen gültigen Namen ein.';
      } else {
        return null;
      }
    }
  }
}

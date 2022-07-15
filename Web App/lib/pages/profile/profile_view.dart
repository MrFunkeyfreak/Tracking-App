import 'package:bestfitnesstrackereu/datamodels/get_user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// not in use, because we hadn't enough time to implement a login for the users, where they can change their personal informations

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final user = FirebaseAuth.instance.currentUser;

  // document IDs of user
  List<String> docIDsUser = [];

  //get docIDsUser
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .orderBy('first name',
            descending:
                true) //descending = true, dann ältester oben und jünster unten
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docIDsUser.add(document.reference.id); //add docIDsUser to list
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 800),
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Image.asset("assets/logo.png"),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              Row(
                children: [
                  Text("Profile from: " + user!.email!,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: FutureBuilder(
                    future: getDocId(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        itemCount: docIDsUser.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: GetUserData(documentId: docIDsUser[index]),
                          );
                        },
                      );
                    }),
              ),
              InkWell(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    print('user ist ausgeloggt');
                    //Navigator.of(context).pushNamed(AuthenticationPageRoute);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'sign out',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}

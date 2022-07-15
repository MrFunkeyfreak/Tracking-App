import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class for getting user data from the database
// not in use - should get used for a custom profile page (see profile_view), but I hadn't enough time for this
class GetUserData extends StatelessWidget {
  final String documentId;

  const GetUserData({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get the collection in database - here 'users'
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // get the informations of the collections - is not completed because I hadn't enough time for this
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text(
                'Username: ${data['username']} \n E-Mail: ${data['email']} \n '
                'Vorname: ${data['first name']} \n Nachname: ${data['last name']} \n '
                'Geburtsdatum: ${data['birthday']} \n Geschlecht: ${data['gender']} \n Status: ${data['status']}');
          }
          return const Text('loading...');
        });
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../routing/route_names.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

// in work Rinor task
// get the current user, show the email from the current user and create a button which logs him out

class _DashboardViewState extends State<DashboardView> {
  final user = FirebaseAuth.instance.currentUser;

  //überprüfen ob user eingeloggt ist oder nicht
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Dashboard View - signed in as '),
              SizedBox(
                height: 8,
              ),
              Text(user!.email!),
              InkWell(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    print('user ist ausgeloggt');
                    Navigator.of(context).pushNamed(AuthenticationPageRoute);
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

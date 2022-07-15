import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../routing/route_names.dart';
import '../../../top_navbar_item/top_navbar_item.dart';
import '../../top_navigation_bar_logo.dart';


// TopNavigationBar for Admin - Screentype = Desktop


final FirebaseAuth auth = FirebaseAuth.instance;

// get the email of the current user
Future<String?> currentUserEmail() async {
  final String? email = await auth.currentUser!.email;

  return email;
}

var currentEmail = currentUserEmail();

class TopNavigationBarAdminDesktop extends StatelessWidget {
  const TopNavigationBarAdminDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.grey,
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            width: 30,
          ),
          const TopNavBarLogo(),
          const SizedBox(
            width: 15,
          ),
          const Visibility(
              child: Text("Admin",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ))),

          const Spacer(), //Space between logo+text and widgets in the center of the row

          const TopNavBarItem('Userverwaltung', UsersAdministrationRoute),
          const SizedBox(
            width: 30,
          ),
          const TopNavBarItem('Dashboard', DashboardRoute),
          const SizedBox(
            width: 30,
          ),
          const TopNavBarItem('Informationen', DashboardRoute),
          const SizedBox(
            width: 30,
          ),
          const TopNavBarItem('Neuigkeiten', DashboardRoute),

          const Spacer(), //Space between widgets in the center of the row and end of row

          // displaying the email of the current user
          FutureBuilder<String?>(
              future: currentEmail,
              builder: (_, AsyncSnapshot<String?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.hasData) {
                    try {
                      return Text('eingeloggt als: \n' + snapshot.data!);
                    } catch (e) {
                      print(e);
                    }
                  }
                } else {
                  return const CircularProgressIndicator();
                }
                return const Text('Something went wrong');
              }),

          const SizedBox(
            width: 10,
          ),

          //sign out the current user - button
          TextButton.icon(
            onPressed: () async => {
              await FirebaseAuth.instance.signOut(),
              print('user ist ausgeloggt'),
              Navigator.of(context).pushNamed(AuthenticationPageRoute),
            },
            icon: const Icon(
              IconData(0xe3b3, fontFamily: 'MaterialIcons'),
              color: Colors.black,
              size: 20,
            ),
            label: const Text("Logout",
                style: TextStyle(color: Colors.black, fontSize: 14)),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              padding:
                  MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
            ),
          ),
        ],
      ),
    );
  }
}

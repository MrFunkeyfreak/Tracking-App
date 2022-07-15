import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../routing/route_names.dart';
import '../../../top_navbar_item/top_navbar_item.dart';
import '../../top_navigation_bar_logo_tablet.dart';

// TopNavigationBar for scientist - Screentype = Tablet

final FirebaseAuth auth = FirebaseAuth.instance;

// get the email of the currentUser
Future<String?> currentUserEmail() async {
  final String? email = await auth.currentUser!.email;
  print(email);

  return email;
}

class TopNavigationBarScientistTablet extends StatelessWidget {
  const TopNavigationBarScientistTablet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child:
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        const SizedBox(
          width: 15,
        ),
        const TopNavBarLogoTablet(),

        const Spacer(), //Space between logo+text and widgets in the center of the row
        const TopNavBarItem('Userverwaltung', UsersAdministrationRoute),
        const SizedBox(
          width: 15,
        ),
        const TopNavBarItem('Dashboard', DashboardRoute),
        const SizedBox(
          width: 15,
        ),
        const TopNavBarItem('Informationen', DashboardRoute),

        const SizedBox(
          width: 15,
        ),
        const TopNavBarItem('Neuigkeiten', DashboardRoute),

        const Spacer(), //Space between widgets in the center of the row and end of row

        // displaying the email of the current user
        FutureBuilder<String?>(
            future: currentUserEmail(),
            builder: (_, AsyncSnapshot<String?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.hasData) {
                  return Text('eingeloggt als: \n' + snapshot.data!,
                      style: const TextStyle(color: Colors.black, fontSize: 10));
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
              style: TextStyle(color: Colors.black, fontSize: 10)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
          ),
        ),
      ]),
    );
  }
}

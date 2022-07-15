import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../routing/route_names.dart';
import '../../top_navbar_item/top_navbar_item.dart';
import '../sidemenu_drawer_header.dart';

//drawer for hamburgericon (menu) in mobile screen when user is admin - used in SideMenuDrawer

final FirebaseAuth auth = FirebaseAuth.instance;

// get the email of the current user
Future<String?> currentUserEmail() async {
  final String? email = await auth.currentUser!.email;

  return email;
}

class SideMenuDrawerAdminMobile extends StatelessWidget {
  const SideMenuDrawerAdminMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: 300,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 16),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SideMenuDrawerHeader(),
            const TopNavBarItem(
              'Userverwaltung',
              UsersAdministrationRoute,
              icon: IconData(0xe318, fontFamily: 'MaterialIcons'),
            ),
            const TopNavBarItem(
              'Dashboard',
              DashboardRoute,
              icon: IconData(0xf0639, fontFamily: 'MaterialIcons'),
            ),
            const TopNavBarItem('Informationen', DashboardRoute,
                icon: IconData(0xe3b2, fontFamily: 'MaterialIcons')),
            const TopNavBarItem(
              'Neuigkeiten',
              DashboardRoute,
              icon: IconData(0xe08c, fontFamily: 'MaterialIcons'),
            ),
            const Spacer(),

            Row(crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              const SizedBox(
                width: 30,
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
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
                ),
              ),
              const SizedBox(
                width: 40,
              ),

              // displaying the email of the current user
              FutureBuilder<String?>(
                  future: currentUserEmail(),
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
            ]),

            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

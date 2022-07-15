import 'package:bestfitnesstrackereu/widgets/top_navigation_bar/top_navigation_bar_logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../provider/auth.dart';
import '../../routing/route_names.dart';

// when TopNavigationBar is for mobile device, then open drawer with the global key
// then a sidemenu get drawen

final FirebaseAuth auth = FirebaseAuth.instance;

Future<String?> currentUserEmail() async {
  // get the email of the currentUser
  final String? email = await auth.currentUser!.email;

  return email;
}

final AuthProvider authProvider = AuthProvider();
final user = FirebaseAuth.instance.currentUser;
Widget TopNavigationBarMobile(
        GlobalKey<ScaffoldState> key, BuildContext context) =>
    AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.grey,
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        onPressed: () {
          key.currentState!.openDrawer();
        },
      ),
      title: Row(
        children: const [
          TopNavBarLogo(),

          // I tried to implement a log out button at the TopNavigationBar, but I didn't had enough time for this

          /*
              Spacer(),

                  if(authProvider.status == Status.Admin || authProvider.status == Status.Scientist)  FutureBuilder<String>(     // displaying the email of the current user
                  future: currentUserEmail(),
                  builder: (_, AsyncSnapshot<String> snapshot) {
                    if(snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError){
                        return Text('Something went wrong',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14
                            ));
                      }
                      if(snapshot.hasData){
                        try {
                          return Text('eingeloggt als: \n' + snapshot.data,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14
                              ));
                        } catch (e){ print(e);}
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  }
              ),

              SizedBox(width: 10,),

              //sign out the current user - button
               if(authProvider.status == Status.Admin || authProvider.status == Status.Scientist) TextButton.icon(
                onPressed: () async => {
                  await FirebaseAuth.instance.signOut(),
                  print('user ist ausgeloggt'),
                  Navigator.of(context).pushNamed(AuthenticationPageRoute),
                },
                icon: Icon(
                  IconData(0xe3b3, fontFamily: 'MaterialIcons'),
                  color: Colors.black,
                  size: 20,
                ),
                label: Text("Logout",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14
                    )
                ),
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.all(10)),
                ),
              ),*/
        ],
      ),
    );

import 'package:flutter/material.dart';
import '../../../routing/route_names.dart';
import '../../top_navbar_item/top_navbar_item.dart';
import '../sidemenu_drawer_header.dart';


//drawer for hamburgericon (menu) in mobile screen when it is a normal user - used in SideMenuDrawer

class SideMenuDrawerUserMobile extends StatelessWidget {
  const SideMenuDrawerUserMobile({Key? key}) : super(key: key);

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
          children: const <Widget>[
            SideMenuDrawerHeader(),
            TopNavBarItem(
              'Information',
              InformationRoute,
              icon: IconData(0xe318, fontFamily: 'MaterialIcons'),
            ),
            TopNavBarItem(
              'Neuigkeiten',
              NeuigkeitenRoute,
              icon: IconData(0xf0639, fontFamily: 'MaterialIcons'),
            ),
            Spacer(),
            TopNavBarItem('Login', AuthenticationPageRoute,
                icon: IconData(0xe3b2, fontFamily: 'MaterialIcons')),
            TopNavBarItem(
              'Teilnehmer \n werden',
              RegristrationUserRoute,
              icon: IconData(0xe08c, fontFamily: 'MaterialIcons'),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

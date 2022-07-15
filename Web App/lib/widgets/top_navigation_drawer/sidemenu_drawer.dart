import 'package:bestfitnesstrackereu/widgets/top_navigation_drawer/widgets/sidemenu_drawer_admin_mobile.dart';
import 'package:bestfitnesstrackereu/widgets/top_navigation_drawer/widgets/sidemenu_drawer_scientist_mobile.dart';
import 'package:bestfitnesstrackereu/widgets/top_navigation_drawer/widgets/sidemenu_drawer_user_mobile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth.dart';
import '../../routing/route_names.dart';

//drawer for hamburgericon (menu) in mobile screen - used in layout_template.dart

class SideMenuDrawer extends StatelessWidget {
  const SideMenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(
        context); // creating an instance of authProvider

    bool currentRouteIsAdmin = false;
    bool currentRouteIsUser = false;
    bool currentRouteIsScientist = false;

    // checking if an admin, an user or a scientist page is the currentRoute and then set the specific bool value to true
    Navigator.popUntil(context, (currentRoute) {
      if (currentRoute.settings.name == RegristrationScientistRoute ||
          currentRoute.settings.name == RegristrationAdminRoute ||
          currentRoute.settings.name == DashboardRoute ||
          currentRoute.settings.name == UsersAdministrationRoute) {
        currentRouteIsAdmin = true;
      }
      if (currentRoute.settings.name == RegristrationScientistRoute) {
        currentRouteIsScientist = true;
      }
      if (currentRoute.settings.name == InformationRoute ||
          currentRoute.settings.name == NeuigkeitenRoute ||
          currentRoute.settings.name == AuthenticationPageRoute ||
          currentRoute.settings.name == RegristrationUserRoute ||
          currentRoute.settings.name == ForgotPasswordRoute ||
          currentRoute.settings.name == AccessDeniedRoute) {
        currentRouteIsUser = true;
      }
      // Return true so popUntil() pops nothing.
      return true;
    });

    final user = FirebaseAuth.instance.currentUser;

    // current user exist
    if (user != null) {
      // print('user is logged in ' + currentUserEmail2);

      // specific bool value for user is true and role is user, then create the user TopNavigationBar for user
      // 404_page_not_found Page not found don't have a route, so only the role need to get checked and then the TopNavigationBar for user displayed
      if (currentRouteIsUser == true &&
          authProvider.status == Status.Unauthenticated) {
        return const SideMenuDrawerUserMobile();
      } else {
        if (authProvider.status == Status.Unauthenticated) {
          return const SideMenuDrawerUserMobile();
        }
      }

      // specific bool value for admin is true and role is admin, then create the user TopNavigationBar for admin
      // 404_page_not_found Page not found don't have a route, so only the role need to get checked and then the TopNavigationBar for admin displayed
      if (currentRouteIsAdmin == true && authProvider.status == Status.Admin) {
        return const SideMenuDrawerAdminMobile();
      } else {
        if (authProvider.status == Status.Admin) {
          return const SideMenuDrawerAdminMobile();
        }
      }

      // specific bool value for scientist is true and role is scientist, then create the user TopNavigationBar for scientist
      // 404_page_not_found Page not found don't have a route, so only the role need to get checked and then the TopNavigationBar for scientist displayed
      if (currentRouteIsScientist == true &&
          authProvider.status == Status.Scientist) {
        return const SideMenuDrawerScientistMobile();
      } else {
        if (authProvider.status == Status.Scientist) {
          return const SideMenuDrawerScientistMobile();
        }
      }

      // no user is logged in - currentUser not exist
    } else {
      print('user not logged in');
      return const SideMenuDrawerUserMobile();
    }
    return const SideMenuDrawerUserMobile();
  }
}

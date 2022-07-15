import 'package:bestfitnesstrackereu/extensions/string_extensions.dart';
import 'package:bestfitnesstrackereu/pages/403_acess_denied/access_denied.dart';
import 'package:bestfitnesstrackereu/pages/dashboard/dashboard_view.dart';
import 'package:bestfitnesstrackereu/pages/forgot_password/forgot_password_view.dart';
import 'package:bestfitnesstrackereu/pages/information/information_view.dart';
import 'package:bestfitnesstrackereu/pages/login/authentication.dart';
import 'package:bestfitnesstrackereu/pages/neuigkeiten/neuigkeiten_view.dart';
import 'package:bestfitnesstrackereu/pages/profile/profile_view.dart';
import 'package:bestfitnesstrackereu/pages/registration/registration_admins_view.dart';
import 'package:bestfitnesstrackereu/pages/registration/registration_scientist_view.dart';
import 'package:bestfitnesstrackereu/pages/user_administration/admin/user_administration_view_admin.dart';
import 'package:bestfitnesstrackereu/pages/user_administration/scientist/user_administration_view_scientist.dart';
import 'package:bestfitnesstrackereu/routing/route_names.dart';
import 'package:flutter/material.dart';
import '../pages/404_page_not_found//page_not_found.dart';
import '../pages/layout_template/layout_template.dart';
import '../pages/registration/registration_users_view.dart';

// used to navigate to a specific route or to the page not found route
// _getPageRoute with a fading previous route + Layouttemplate which builds up the page + settings (routename)
Route<dynamic> generateRoute(RouteSettings settings) {
  var routingData = settings.name!.getRoutingData; // Get the routing Data
  switch (routingData.route) {
    case InformationRoute:
      return _getPageRoute(const LayoutTemplate(child1: InformationView()), settings);
    case NeuigkeitenRoute:
      return _getPageRoute(const LayoutTemplate(child1: NeuigkeitenView()), settings);
    case AuthenticationPageRoute:
      return _getPageRoute(
          const LayoutTemplate(child1: AuthenticationPage()), settings);
    case RegristrationUserRoute:
      return _getPageRoute(
          const LayoutTemplate(child1: RegistrationUsersView()), settings);
    case RegristrationScientistRoute:
      return _getPageRoute(const LayoutTemplate(child1: RegistrationScientistView()),
          settings); // not in use
    case RegristrationAdminRoute:
      return _getPageRoute(const LayoutTemplate(child1: RegistrationAdminsView()),
          settings); // not in use
    case DashboardRoute:
      return _getPageRoute(const LayoutTemplate(child1: DashboardView()), settings);
    case ForgotPasswordRoute:
      return _getPageRoute(
          const LayoutTemplate(child1: ForgotPasswordView()), settings);
    case ProfileRoute:
      return _getPageRoute(
          const LayoutTemplate(child1: ProfileView()), settings); // not in use
    case UsersAdministrationRoute:
      return _getPageRoute(
          const LayoutTemplate(child1: UserAdministrationViewAdmin()), settings);
    case UsersScientistRoute:
      return _getPageRoute(
          const LayoutTemplate(child1: UserAdministrationViewScientist()), settings);
    case AccessDeniedRoute:
      return _getPageRoute(const LayoutTemplate(child1: AccessDenied()), settings);
    default:
      return _getPageRoute(const LayoutTemplate(child1: PageNotFound()), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(
      child: child, //Widget child for displaying the widget/view/page
      routeName: settings.name //routeName for named routing
      );
}

class _FadeRoute extends PageRouteBuilder {
  final Widget? child; //Widget child for returning the widget/view/page
  final String? routeName;
  _FadeRoute({this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName), //setting routeName
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

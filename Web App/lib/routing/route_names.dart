// route names and sidemenuitem routes

const String InformationRoute = "/info";
const String NeuigkeitenRoute = "/news";
const String AuthenticationPageRoute = "/login";
const String RegristrationUserRoute = "/registrieren";
const String RegristrationScientistRoute = "/scientistregistrieren";
const String RegristrationAdminRoute = "/adminregistrieren";
const String DashboardRoute = "/dashboard";
const String ForgotPasswordRoute = "/forgot_password";
const String ProfileRoute = "/profile";
const String UsersAdministrationRoute = "/adminverwaltung";
const String UsersScientistRoute = "/scientistverwaltung";
const String AccessDeniedRoute = "/access_denied";

class MenuItemRoutes {
  final String name;
  final String route;

  MenuItemRoutes(this.name, this.route);
}

List<MenuItemRoutes> sideMenuItems = [
  MenuItemRoutes('Information', InformationRoute),
  MenuItemRoutes('Neuigkeiten', NeuigkeitenRoute),
  MenuItemRoutes('Login', AuthenticationPageRoute),
  MenuItemRoutes('Registrieren', RegristrationUserRoute),
  MenuItemRoutes('Wissenschaftler-Registrieren', RegristrationScientistRoute),
  MenuItemRoutes('Admin-Registrieren', RegristrationAdminRoute),
  MenuItemRoutes('Dashboard', DashboardRoute),
  MenuItemRoutes('Passwort vergessen', ForgotPasswordRoute),
  MenuItemRoutes('Profile', ProfileRoute),
  MenuItemRoutes('Adminverwaltung', UsersAdministrationRoute),
  MenuItemRoutes('Scientistverwaltung', UsersScientistRoute),
];

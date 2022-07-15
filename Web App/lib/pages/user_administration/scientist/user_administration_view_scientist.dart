import 'package:bestfitnesstrackereu/pages/user_administration/scientist/user_administration_view_scientist_desktop.dart';
import 'package:bestfitnesstrackereu/pages/user_administration/scientist/user_administration_view_scientist_mobile.dart';
import 'package:bestfitnesstrackereu/pages/user_administration/scientist/user_administration_view_scientist_tablet.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

// user_administration_scientist page displayer - ScreenTypeLayout decides, which screen is getting displayed

class UserAdministrationViewScientist extends StatelessWidget {
  const UserAdministrationViewScientist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: UsersAdministrationViewScientistDesktop(),
      tablet: UsersAdministrationViewScientistTablet(),
      mobile: UsersAdministrationViewScientistMobile(),
    );
  }
}

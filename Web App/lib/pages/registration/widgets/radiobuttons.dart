import 'package:flutter/material.dart';

// RadioButton for the Gender section - used in all registrations and in all user_administration..._views (as example user_administration_view or user_administration_view_scientist)
class RadioButtonGender extends StatelessWidget {
  int btnValue; // shows the value of this button (0=male, 1=female)
  String title;
  Function(dynamic) onChanged;
  String? genderSelected;

  RadioButtonGender(
      this.btnValue, this.title, this.genderSelected, this.onChanged,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List gender = ["Männlich", "Weiblich"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[
              btnValue], //btnValue - shows the value of this button (0=male, 1=female)
          groupValue:
              genderSelected, //will set the genderSelected when the button gets initialize (useful when a user gets editted - to show which gender is currently selected)
          onChanged:
              onChanged, //the onChanged function will be set when the radiobutton get initialised
        ),
        Text(title) //just the title of the radiobutton
      ],
    );
  }
}

// RadioButton for the Role section - used in all registrations and in all user_administration..._views (as example user_administration_view or user_administration_view_scientist)
class RadioButtonRole extends StatelessWidget {
  int btnValue;
  String title;
  Function(dynamic) onChanged;
  String? roleSelected;

  RadioButtonRole(this.btnValue, this.title, this.roleSelected, this.onChanged,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List role = ["User", "Wissenschaftler", "Admin"];

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: role[
              btnValue], //btnValue - shows the value of this button (0=user, 1=scientist, 2=admin)
          groupValue:
              roleSelected, //will set the roleSelected when the button gets initialize (useful when a user gets editted - to show which role is currently selected)
          onChanged:
              onChanged, //the onChanged function will be set when the radiobutton get initialised
        ),
        Text(title) // just the title of the radiobutton
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'call_to_action_mobile.dart';
import 'call_to_action_tablet_desktop.dart';

// used in News- and Informationpage, but they are just hardcoded anyways
// Rinor's task

class CallToAction extends StatelessWidget {
  final String title;
  const CallToAction(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: CallToActionMobile(title),
      tablet: CallToActionTabletDesktop(title),
    );
  }
}

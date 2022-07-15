import 'package:bestfitnesstrackereu/pages/Information/information_content_desktop.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'information_content_mobile.dart';

// information page displayer - ScreenTypeLayout decides which screen is getting displayed
// in work Rinor task - at the moment just hard coded sides

class InformationView extends StatelessWidget {
  const InformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: InformationContentMobile(),
      desktop: InformationContentDesktop(),
    );
  }
}

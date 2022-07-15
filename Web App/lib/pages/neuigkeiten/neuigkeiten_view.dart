import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'neuigkeiten_content_desktop.dart';
import 'neuigkeiten_content_mobile.dart';

// neuigkeiten page displayer - ScreenTypeLayout decides which screen is getting displayed
// in work Rinor task - at the moment just hard coded sides

class NeuigkeitenView extends StatelessWidget {
  const NeuigkeitenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: NeuigkeitenContentMobile(),
      desktop: NeuigkeitenContentDesktop(),
    );
  }
}

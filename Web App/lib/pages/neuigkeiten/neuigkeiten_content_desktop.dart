import 'package:bestfitnesstrackereu/pages/neuigkeiten/widgets/neuigkeiten_content_details.dart';
import 'package:flutter/material.dart';

// neuigkeiten page for desktop with NeuigkeitenContentDetails (input of the page)
// used in neuigkeiten_view.dart

class NeuigkeitenContentDesktop extends StatelessWidget {
  const NeuigkeitenContentDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: <Widget>[
          NeuigkeitenContentDetails(),
          Expanded(
            child: Center(
                //child: CallToAction('Join our Fitnesstracker now!'),
                ),
          )
        ],
      ),
    );
  }
}

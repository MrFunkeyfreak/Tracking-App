import 'package:bestfitnesstrackereu/pages/neuigkeiten/widgets/neuigkeiten_content_details.dart';
import 'package:flutter/material.dart';

// neuigkeiten page for mobile with NeuigkeitenContentDetails (input of the page)
// used in neuigkeiten_view.dart

class NeuigkeitenContentMobile extends StatelessWidget {
  const NeuigkeitenContentMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          NeuigkeitenContentDetails(),
          SizedBox(
            height: 100,
          ),
          //CallToAction('Join our Fitnesstracker now!'),
        ],
      ),
    );
  }
}

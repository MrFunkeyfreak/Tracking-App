import 'package:bestfitnesstrackereu/pages/information/widgets/informations_content_details.dart';
import 'package:flutter/material.dart';

// information page for desktop with InformationContentDetails (input of the page)
// used in information_view.dart

class InformationContentDesktop extends StatelessWidget {
  const InformationContentDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: <Widget>[
          InformationContentDetails(),
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

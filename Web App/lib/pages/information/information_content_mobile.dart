import 'package:bestfitnesstrackereu/pages/information/widgets/informations_content_details.dart';
import 'package:flutter/material.dart';

// information page for mobile with InformationContentDetails (input of the page)
// used in information_view.dart

class InformationContentMobile extends StatelessWidget {
  const InformationContentMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InformationContentDetails(),
          SizedBox(
            height: 100,
          ),
          //CallToAction('Join our Fitnesstracker now!'),
        ],
      ),
    );
  }
}

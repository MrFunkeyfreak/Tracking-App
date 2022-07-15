import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../constants/text_styles.dart';

// used in Informationpage - hardcoded site
// Rinor's task

class InformationContentDetails extends StatelessWidget {
  const InformationContentDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        TextAlign textAlignment;
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          textAlignment = TextAlign.left;
        } else {
          textAlignment = TextAlign.center;
        }

        return Container(
          width: 650,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Informations- \nseite von \nTheBestFitnessTracker',
                style: titleTextStyle(sizingInformation.deviceScreenType),
                textAlign: textAlignment,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Herzlich Willkommen auf unserer Webseite TheBestFitnessTrackerEU. \n\n Hier finden Sie Informationen zu unserer aktuellen Studie: \n\n ...',
                style: descriptionTextStyle(sizingInformation.deviceScreenType),
                textAlign: textAlignment,
              )
            ],
          ),
        );
      },
    );
  }
}

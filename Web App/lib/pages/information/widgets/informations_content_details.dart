import 'package:bestfitnesstrackereu/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

// all the input text which get displayed on the information page
// used in information_content_mobile.dart and information_content_desktop.dart

class InformationContentDetails extends StatelessWidget {
  const InformationContentDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          // if the ScreenType is desktop, then text on left side, else center
          var textAlignment;
          if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
            textAlignment = TextAlign.left;
          } else {
            textAlignment = TextAlign.center;
          }

          return Container(
            width: 650,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Information',
                  style: titleTextStyle(sizingInformation.deviceScreenType),
                  textAlign: textAlignment,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Herzlich Willkommen auf unserer Webseite TheBestFitnessTrackerEU. \n\nBewegungsmangel ist in unserer modernen Gesellschaft ein weit verbreitetes Problem und kann weitreichende Folgen für jeden Einzelnen haben. Er fördert die Entstehung von Übergewicht und erhöht das Risiko für Typ-2-Diabetes, Herz-Kreislauferkrankungen und Krebs. '
                  '\n\nAb wann spricht man eigentlich von Bewegungsmangel? \nMan spricht von Bewegungsmangel, sobald die Muskulatur unseres Körpers zu wenig belastet wird. \nDabei würde pro Woche bereits ein Bewegungspensum von 150 Minuten mäßige Aktivitäten oder 75 Minuten intensiver Sport wie Fahrradfahren oder Joggen ausreichen, um das Defizit auszugleichen. \nDabei möchen wir Ihnen gerne behilflich sein. \nMit dem BestFitnessTrackerEU haben Sie die Möglichkeit ihre Aktivitäten zu im Auge zu behalten und können dadurch ihren Bewegungsmangel reduzieren.',
                  style:
                      descriptionTextStyle(sizingInformation.deviceScreenType),
                  textAlign: textAlignment,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

// used in News- and Informationpage, but they are just hardcoded anyways
// Rinor's task

class CallToActionMobile extends StatelessWidget {
  final String title;
  const CallToActionMobile(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }
}

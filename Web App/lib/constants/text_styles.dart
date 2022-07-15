import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

// Returns the style for a page title based on the [deviceScreenType] passed in.
// used for the responsivness of the website
TextStyle titleTextStyle(DeviceScreenType deviceScreenType) {
  double titleSize;
  if (deviceScreenType == DeviceScreenType.mobile) {
    titleSize = 50;
  } else {
    titleSize = 80;
  }
  return TextStyle(
      fontWeight: FontWeight.w800, height: 0.9, fontSize: titleSize);
}

// Return the style for description text on a page based on the [deviceScreenType] passed in.
// used for the responsivness of the website
TextStyle descriptionTextStyle(DeviceScreenType deviceScreenType) {
  double descriptionSize;
  if (deviceScreenType == DeviceScreenType.mobile) {
    descriptionSize = 16;
  } else {
    descriptionSize = 21;
  }
  return TextStyle(
    fontSize: descriptionSize,
    height: 1.7,
  );
}

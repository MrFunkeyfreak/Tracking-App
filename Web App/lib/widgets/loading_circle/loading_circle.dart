import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// just a loading circle - get used when the program is loading
// unfortunately it is not always used, because we hadn't enough time to implement it in the whole code

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.white,
          child: const SpinKitFadingCircle(
            color: Colors.black,
            size: 30,
          )),
    );
  }
}

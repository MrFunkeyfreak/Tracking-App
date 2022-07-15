import 'package:flutter/material.dart';

// 403 error - access denied
// design of the error page: everything centered with logo and text: 'Page not found'
// get used when an unauthorised user want to enter a scientist- or admin-page
class AccessDenied extends StatelessWidget {
  const AccessDenied({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/403_error.png",
              width: 350,
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Access denied\nZugriff verweigert\n',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '\nDu hast nicht die nötigen Rechte, \num Zugriff zu dieser Seite zu erhalten',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bestfitnesstrackereu/routing/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// forgot password page - when an user forgets his password, then he can request a password reset link
// not in use anymore, because the user won't have access to the login page anymore and scientist need to call an admin
// we still haven't deleted it for the presentation, but it would be a security risk, so it should get deleted

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(
                'Eine E-Mail zum zurücksetzen des Passwortes ist versendet worden. \n Überprüfe dein Postfach!',
                textAlign: TextAlign.center,
              ),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    'Gib deine E-Mail Adresse ein. \n Dann senden wir dir einen Link zum zurücksetzen des Passworts ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: "E-Mail",
                      hintText: "abc@domain.com",
                      suffixIcon: const Icon(
                        Icons.mail_outline,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                    onTap: () {
                      passwordReset();
                      //Navigator.of(context).pushNamed();
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(20)),
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: const Text(
                          "Passwort zurücksetzen",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ))),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                      height: 50,
                      color: Colors.grey[500],
                    )),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                          'Du hast dein Passwort \nbereits zurückgesetzt?'),
                    ),
                    Expanded(
                        child: Divider(
                      height: 50,
                      color: Colors.grey[500],
                    )),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AuthenticationPageRoute);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(20)),
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: const Text(
                          "Zurück zum Login",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

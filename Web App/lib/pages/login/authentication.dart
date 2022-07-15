import 'package:bestfitnesstrackereu/routing/route_names.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth.dart';
import '../../widgets/loading_circle/loading_circle.dart';

//AuthenticationPage (Login page)

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final GlobalKey<FormState> _formKeys =
      GlobalKey<FormState>(); // key for validation of the TextFormFields

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // clear all controllers - used after every click on a button
  void clearController() {
    emailController.text = '';
    passwordController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(
        context); //creates an instance of AuthProvider
    final hasAuthenticated = context.select<AuthProvider, bool>(
        (AuthProvider) =>
            authProvider.status ==
            Status.Authenticating); //used to check the authentication status

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          // check the authentication status, when it is Authenticating, then return loading, else show the page
          child: hasAuthenticated
              ? Loading()
              : Container(
                  constraints: const BoxConstraints(maxWidth: 440),
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Image.asset(
                              "assets/logo.png", //image of our logo
                              width: 300,
                            ),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      Row(
                        children: const [
                          Text("Login",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: const [
                          Text("Wilkommen zurück zum Login",
                              style: TextStyle(
                                color: Colors.grey,
                              ))
                        ],
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      Form(
                        key: _formKeys,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              validator: (email) =>
                                  EmailValidator.validate(email!)
                                      ? null
                                      : "Bitte gib eine gültige E-Mail an.",
                              controller: emailController,
                              decoration: InputDecoration(
                                  labelText: "E-Mail",
                                  hintText: "abc@domain.com",
                                  suffixIcon: const Icon(
                                    Icons.mail_outline,
                                  ),
                                  //isDense: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              validator: (password) {
                                print(authProvider.validatePassword(password!));
                                return authProvider.validatePassword(password);
                              },
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: "Passwort",
                                  hintText: "******",
                                  suffixIcon: const Icon(
                                    Icons.lock_outline,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                clearController();
                                Navigator.of(context).pushNamed(
                                    ForgotPasswordRoute); // navigate to the forgot password page
                              },
                              child: Text(
                                'Passwort vergessen',
                                style: TextStyle(
                                  color: Colors.blue[700],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      InkWell(
                          onTap: () async {
                            //check if email and password field is not empty
                            if (emailController.text.trim().isEmpty ||
                                passwordController.text.trim().isEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                          "Error: Bitte fülle das E-Mail- und Passwort-Feld aus."),
                                      actions: [
                                        TextButton(
                                          child: const Text("Ok"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  });
                            } else {
                              //checking if the email and password is valid
                              if (_formKeys.currentState!.validate()) {

                                Map<String, dynamic> mapUserinformations = {};

                                // input is the email of the user
                                // output are all the user informations in a Map<String, dynamic>
                                // used to check the status and role of the user
                                mapUserinformations =
                                    await authProvider.getUserByEmail(
                                        emailController.text.trim());

                                //when email exist, then check status
                                if (mapUserinformations.isNotEmpty) {
                                  print('email is already existing');

                                  //status from user = locked
                                  if (mapUserinformations['status'] ==
                                      'gesperrt') {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                "Error: Dein Account ist gesperrt"),
                                            actions: [
                                              TextButton(
                                                child: const Text("Ok"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  }

                                  //status from user = deleted
                                  if (mapUserinformations['status'] ==
                                      'gelöscht') {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                "Error: Dein Account wurde gelöscht. Er existiert nicht mehr."),
                                            actions: [
                                              TextButton(
                                                child: const Text("Ok"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  }

                                  //status from user = active
                                  if (mapUserinformations['status'] ==
                                      'aktiv') {

                                    //role from user = admin
                                    if (mapUserinformations['role'] ==
                                        'Admin') {
                                      print('admin - am einloggen');

                                      // if signIn fails, then print error "Login failed", otherwise signIn normally
                                      if (!await authProvider.signIn(
                                          emailController.text.trim(),
                                          passwordController.text.trim())) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    "Error: Login fehlgeschlagen. Falsche Kombination aus E-Mail und Passwort."),
                                                actions: [
                                                  TextButton(
                                                    child: const Text("Ok"),
                                                    onPressed: () {
                                                      clearController();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  )
                                                ],
                                              );
                                            });
                                      } else {

                                        //checking if the email of the user is verificated - when it is not verificated, then send an email for the verification
                                        final user =
                                            FirebaseAuth.instance.currentUser;
                                        if (user?.emailVerified ?? true) {
                                          clearController();
                                          Navigator.of(context).pushNamed(
                                              UsersAdministrationRoute);
                                        } else {
                                          user?.sendEmailVerification();
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Error: E-Mail ist nicht verifiziert. Dir wurde eine E-Mail zur Verifizierung deiner E-Mail zugesendet."),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text("Ok"),
                                                      onPressed: () {
                                                        clearController();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    )
                                                  ],
                                                );
                                              });
                                        }
                                      }
                                    }

                                    //role from user = scientist
                                    if (mapUserinformations['role'] ==
                                        'Wissenschaftler') {
                                      print('scientist - am einloggen');

                                      // if signIn fails, then print "Login failed", otherwise signIn normally
                                      if (!await authProvider.signIn(
                                          emailController.text.trim(),
                                          passwordController.text.trim())) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    "Error: Login fehlgeschlagen. Falsche Kombination aus E-Mail und Passwort."),
                                                actions: [
                                                  TextButton(
                                                    child: const Text("Ok"),
                                                    onPressed: () {
                                                      clearController();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  )
                                                ],
                                              );
                                            });
                                      } else {

                                        //checking if the email of the user is verificated - when it is not verificated, then send an email for the verification
                                        final user =
                                            FirebaseAuth.instance.currentUser;
                                        if (user?.emailVerified ?? true) {
                                          clearController();
                                          Navigator.of(context).pushNamed(
                                              UsersAdministrationRoute);
                                        } else {
                                          user?.sendEmailVerification();
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Error: E-Mail ist nicht verifiziert. Dir wurde eine E-Mail zur Verifizierung deiner E-Mail zugesendet."),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text("Ok"),
                                                      onPressed: () {
                                                        clearController();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    )
                                                  ],
                                                );
                                              });
                                        }
                                      }
                                    }

                                    //role from user = user
                                    if (mapUserinformations['role'] == 'User') {
                                      print('user - kein zugriff');
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  "Error: Du hast keine Zugriffsberichtigung auf diesen Login."),
                                              actions: [
                                                TextButton(
                                                  child: const Text("Ok"),
                                                  onPressed: () {
                                                    clearController();
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    }
                                  }
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Error: Ein Benutzer mit dieser E-Mail existiert nicht."),
                                          actions: [
                                            TextButton(
                                              child: const Text("Ok"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        );
                                      });
                                }
                              } else {
                                print('validate email not goodat all');
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            "Error: Bitte gebe eine gültige E-Mail und/oder Passwort ein."),
                                        actions: [
                                          TextButton(
                                            child: const Text("Ok"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    });
                              }
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(20)),
                              alignment: Alignment.center,
                              width: double.maxFinite,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ))),

                      // when the user is already registrated, then navigate to the login page, when he clicks on the button
                      // -> it just get implemented when an user login exist. (no time to implement an user profil, so not in use)
                      // login information for the user

                      /*
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
                          child: Text('Du bist noch nicht registriert?'),
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
                          clearController();
                          Navigator.of(context).pushNamed(
                              RegristrationUserRoute); // navigation to the Registration page
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(20)),
                            alignment: Alignment.center,
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: const Text(
                              "Teilnehmer werden",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ))),*/
                    ],
                  )),
                ),
        ));
  }
}

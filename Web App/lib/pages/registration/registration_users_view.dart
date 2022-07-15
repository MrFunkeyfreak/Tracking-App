import 'package:bestfitnesstrackereu/pages/registration/widgets/radiobuttons.dart';
import 'package:bestfitnesstrackereu/routing/route_names.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth.dart';
import '../../widgets/loading_circle/loading_circle.dart';

// normal Registration page for the users
class RegistrationUsersView extends StatefulWidget {
  const RegistrationUsersView({Key? key}) : super(key: key);

  @override
  State<RegistrationUsersView> createState() => _RegristrationViewState();
}

class _RegristrationViewState extends State<RegistrationUsersView> {
  String? _genderSelected;

  String? _birthDateInString;
  DateTime? birthDate;
  bool isDateSelected = false;

  Map<String, dynamic>? mapUserinformations = {};
  Map<String, dynamic>? mapUsernameExist = {};

  final GlobalKey<FormState> _formKeys = GlobalKey<FormState>(); // key for validation of the TextFormFields

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmedController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmedController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  // clear all controllers - used after every click on a button
  void clearController() {
    usernameController.text = '';
    emailController.text = '';
    passwordController.text = '';
    passwordConfirmedController.text = '';
    firstNameController.text = '';
    lastNameController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(
        context); // creating an instance of authProvider
    final hasAuthenticated = context.select<AuthProvider, bool>(
            (AuthProvider) =>
        authProvider.status ==
            Status.Authenticating); //used to check the authentication status

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            // check the authentication status, when it is Authenticating, then return loading, else show the page
            child: hasAuthenticated
                ? Loading()
                : Container(
                    constraints: const BoxConstraints(maxWidth: 440),
                    padding: const EdgeInsets.all(24),
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
                            Text("Registrierung",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: const [
                            Text("Wilkommen zur Registration",
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
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (username) {
                                    print(authProvider
                                        .validateUsername(username!));
                                    return authProvider
                                        .validateUsername(username);
                                  },
                                  controller: usernameController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                      labelText: "Benutzername",
                                      hintText: "Max123",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  validator: (email) =>
                                      EmailValidator.validate(email!)
                                          ? null
                                          : "Bitte gib eine gültige E-Mail an.",
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      labelText: "E-Mail",
                                      hintText: "abc@domain.com",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  validator: (password) {
                                    print(authProvider
                                        .validatePassword(password!));
                                    return authProvider
                                        .validatePassword(password);
                                  },
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      labelText: "Passwort",
                                      hintText: "******",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  validator: (passwordConfirm) {
                                    print(authProvider
                                        .validatePassword(passwordConfirm!));
                                    return authProvider
                                        .validatePassword(passwordConfirm);
                                  },
                                  controller: passwordConfirmedController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      labelText: "Passwort wiederholen",
                                      hintText: "******",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  validator: (firstName) {
                                    print(
                                        authProvider.validateName(firstName!));
                                    return authProvider.validateName(firstName);
                                  },
                                  controller: firstNameController,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                      labelText: "Vorname",
                                      hintText: "Max",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  validator: (lastName) {
                                    print(authProvider.validateName(lastName!));
                                    return authProvider.validateName(lastName);
                                  },
                                  controller: lastNameController,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                      labelText: "Nachname",
                                      hintText: "Mustermann",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 11,
                            ),
                            const Text(
                              "Geburtsdatum:",
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              width: 90,
                            ),

                            // DateTime birthday selection
                            GestureDetector(
                              child:  const Icon(
                                Icons.calendar_today,
                                size: 30,
                              ),
                              onTap: () async {
                                final DateTime? datePick = await showDatePicker(
                                  context: context,
                                  initialDate:  DateTime.now(),
                                  firstDate:  DateTime(1900),
                                  lastDate:  DateTime(2100),
                                  initialEntryMode: DatePickerEntryMode.input,
                                  errorFormatText:
                                      'Gib ein Datum mit dem Format Tag/Monat/Jahr ein',
                                  errorInvalidText:
                                      'Gib ein realistisches Datum ein',
                                  fieldLabelText: 'Geburtstag',
                                  fieldHintText: 'TT/MM/YYYY',
                                );
                                if (datePick != null && datePick != birthDate) {
                                  setState(() {
                                    birthDate = datePick;
                                    isDateSelected = true;

                                    // birthdate in string
                                    _birthDateInString =
                                        "${birthDate!.day}/${birthDate!.month}/${birthDate!.year}";
                                    print('' + _birthDateInString!);
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            const Text(
                              "Geschlecht:",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.start,
                            ),

                            const SizedBox(
                              width: 10,
                            ),

                            // // RadioButtons from the registration folder inside of widget
                            RadioButtonGender(0, 'Männlich', _genderSelected,
                                (newValue) {
                              print(newValue);
                              setState(() => _genderSelected = newValue);
                            }),
                            RadioButtonGender(1, 'Weiblich', _genderSelected,
                                (newValue) {
                              print(newValue);
                              setState(() => _genderSelected = newValue);
                            }),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                            onTap: () async {
                              final Formkey = _formKeys.currentState;

                              print('pw confirmed:' +
                                  passwordConfirmedController.text.trim());
                              print('pw:' + passwordController.text.trim());

                              //password and passworconfirm check
                              if (passwordConfirmedController.text.trim() ==
                                  passwordController.text.trim()) {

                                // checking if a date,gender and role is selected
                                // controllers don't need to get checked, because of validation
                                if (isDateSelected != false &&
                                    _genderSelected != null) {
                                  // checking if all textfields are valid

                                  // validation of the TextFormFields
                                  if (Formkey!.validate()) {
                                    print('validate okok');

                                    // input is the email of the user
                                    // output are all the user informations in a Map<String, dynamic>
                                    // used to check the status and role of the user
                                    mapUserinformations =
                                        await authProvider.getUserByEmail(
                                            emailController.text.trim());

                                    //when email exist, then check status
                                    if (mapUserinformations!.isNotEmpty) {
                                      print('email is already existing');

                                      //checking if status is deleted
                                      if (mapUserinformations!['status'] ==
                                          'gelöscht') {
                                        print('email is deleted');

                                        //recreate the deleted user
                                        try {
                                          mapUsernameExist =
                                              await authProvider.UsernameExist(
                                                  usernameController.text
                                                      .trim());

                                          //if username already exist, then print error otherwise recreate user
                                          if (mapUsernameExist!.isEmpty) {
                                            print('username is free');

                                            //update user informations
                                            await authProvider.updateUserSignup(
                                                mapUserinformations!['uid'],
                                                usernameController.text.trim(),
                                                mapUserinformations!['email'],
                                                firstNameController.text.trim(),
                                                lastNameController.text.trim(),
                                                _birthDateInString,
                                                _genderSelected,
                                                'User');

                                            //input: emailcontroller, output: send password reset link
                                            try {
                                              await FirebaseAuth.instance
                                                  .sendPasswordResetEmail(
                                                      email: emailController
                                                          .text
                                                          .trim());
                                            } on FirebaseAuthException catch (e) {
                                              print(e);
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: Text(
                                                          e.message.toString()),
                                                    );
                                                  });
                                            }
                                            clearController();
                                            isDateSelected = false;
                                            _genderSelected = null;

                                            // deleted user got recreated - now print a message that the registration process is completed
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Registration abgeschlossen.\nDein Account war gelöscht, daher wurde dir eine E-Mail zum zurücksetzen deines persönlichen Passworts zugesendet.\nNachdem du das Passwort abgeändert hast, kannst du "
                                                        "dich nun in unserer App einloggen.",
                                                        textAlign:
                                                            TextAlign.center),
                                                    actions: [
                                                      TextButton(
                                                        child: const Text("Ok"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      )
                                                    ],
                                                  );
                                                });
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Error: Der Username wird bereits verwendet. Bitte benutze einen anderen."),
                                                    actions: [
                                                      TextButton(
                                                        child: const Text("Ok"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      )
                                                    ],
                                                  );
                                                });
                                          }
                                        } catch (e) {
                                          print(e);
                                        }
                                      }
                                      // email is already existing and the status is not deleted
                                      else {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    "Error: Es existiert schon ein Account mit dieser E-Mail Adresse."),
                                                actions: [
                                                  TextButton(
                                                    child: const Text("Ok"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  )
                                                ],
                                              );
                                            });
                                      }
                                    }
                                    // email not existing in database -> mapUserinformations = null
                                    else {
                                      try {
                                        print('email existiert noch nicht');

                                        // input is the usernameController, which provides the written username
                                        // output are all the user informations in a Map<String, dynamic>
                                        // used to get a unique username
                                        mapUsernameExist =
                                            await authProvider.UsernameExist(
                                                usernameController.text.trim());

                                        // if mapUsernameExist is empty, then the username is free
                                        if (mapUsernameExist!.isEmpty) {
                                          print('username is free');

                                          // sign up user in database with the birthday and gender + all controllers
                                          await authProvider.signUpUser(
                                              usernameController.text.trim(),
                                              emailController.text.trim(),
                                              passwordController.text.trim(),
                                              firstNameController.text.trim(),
                                              lastNameController.text.trim(),
                                              _birthDateInString,
                                              _genderSelected);
                                          clearController();
                                          isDateSelected = false;
                                          _genderSelected = null;

                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Registration abgeschlossen. Du kannst dich nun in unserer App einloggen."),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text("Ok"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    )
                                                  ],
                                                );
                                              });
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Error: Der Username wird bereits verwendet. Bitte benutze einen anderen."),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text("Ok"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    )
                                                  ],
                                                );
                                              });
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    }
                                  } else {
                                    print('validate email notgoodatall');
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                "Error: Bitte überprüfe, ob alle deine Eingaben ein gültiges Format aufweisen."),
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
                                // not all Textfields/Buttons are filled
                                else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Error: Registration gescheitert! Bitte alle Felder ausfüllen."),
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
                                  return;
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            "Error: Passwort und Passwort wiederholen müssen gleich sein!"),
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
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(20)),
                                alignment: Alignment.center,
                                width: double.maxFinite,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: const Text(
                                  "Registrieren",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ))),

                        // when the user is already registrated, then navigate to the login page, when he clicks on the button
                        // -> it just get implemented when an user login exist. (no time to implement a user profil, so not in use)

                        /*SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Divider(
                              height: 50,
                              color: Colors.grey[500],
                            )),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text('Du bist schon registriert?'),
                            ),
                            Expanded(
                                child: Divider(
                              height: 50,
                              color: Colors.grey[500],
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                            onTap: () {
                              clearController();
                              isDateSelected = false;
                              _genderSelected = null;
                              //Navigator.of(context).pop();
                              Navigator.of(context)
                                  .pushNamed(AuthenticationPageRoute);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(20)),
                                alignment: Alignment.center,
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  "Zum Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ))),*/
                      ],
                    ),
                  )),
      ),
    );
  }
}

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/auth.dart';
import '../../../provider/users_table.dart';
import '../../registration/widgets/radiobuttons.dart';

// Button which adds an User to the table and database. Required is to fill out all the fields in the AlertDialog (normal registration as admin)

class AddButtonScientist extends StatefulWidget {
  const AddButtonScientist({Key? key}) : super(key: key);

  @override
  State<AddButtonScientist> createState() => _AddButtonScientistState();
}

class _AddButtonScientistState extends State<AddButtonScientist> {
  String? genderSelected;

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
    final authproviderInstance = Provider.of<AuthProvider>(
        context); // creating an instance of authProvider
    final UsersTable userTable = Provider.of<UsersTable>(
        context); // initialize the usertable from provider

    return TextButton.icon(
      onPressed: () => {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (context, setState) {
                return AlertDialog(
                  content: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Positioned(
                        right: -40.0,
                        top: -40.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(Icons.close),
                          ),
                        ),
                      ),
                      Form(
                        key: _formKeys,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("User hinzufügen",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (username) {
                                  print(authproviderInstance
                                      .validateUsername(username!));
                                  return authproviderInstance
                                      .validateUsername(username);
                                },
                                controller: usernameController,
                                decoration: InputDecoration(
                                    labelText: "Benutzername",
                                    hintText: "Max123",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (email) =>
                                    EmailValidator.validate(email!)
                                        ? null
                                        : "Bitte gib eine gültige E-Mail an.",
                                controller: emailController,
                                decoration: InputDecoration(
                                    labelText: "E-Mail",
                                    hintText: "abc@domain.com",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (password) {
                                  print(authproviderInstance
                                      .validatePassword(password!));
                                  return authproviderInstance
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
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (passwordConfirm) {
                                  print(authproviderInstance
                                      .validatePassword(passwordConfirm!));
                                  return authproviderInstance
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
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (firstName) {
                                  print(authproviderInstance
                                      .validateName(firstName!));
                                  return authproviderInstance
                                      .validateName(firstName);
                                },
                                controller: firstNameController,
                                decoration: InputDecoration(
                                    labelText: "Vorname",
                                    hintText: "Max",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (lastName) {
                                  print(authproviderInstance
                                      .validateName(lastName!));
                                  return authproviderInstance
                                      .validateName(lastName);
                                },
                                controller: lastNameController,
                                decoration: InputDecoration(
                                    labelText: "Nachname",
                                    hintText: "Mustermann",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "Geburtsdatum:",
                                  style: TextStyle(fontSize: 18),
                                ),

                                // DateTime birthday selection
                                GestureDetector(
                                  child:  const Icon(
                                    Icons.calendar_today,
                                    size: 30,
                                  ),
                                  onTap: () async {
                                    final DateTime? datePick =
                                        await showDatePicker(
                                      locale: const Locale('de'),
                                      context: context,
                                      initialDate:  DateTime.now(),
                                      firstDate:  DateTime(1900),
                                      lastDate:  DateTime(2100),
                                      initialEntryMode:
                                          DatePickerEntryMode.input,
                                      errorFormatText:
                                          'Gib ein Datum mit dem Format Tag/Monat/Jahr ein',
                                      errorInvalidText:
                                          'Gib ein realistisches Datum ein',
                                      fieldLabelText: 'Geburtstag',
                                      fieldHintText: 'TT/MM/YYYY',
                                    );
                                    if (datePick != null &&
                                        datePick != birthDate) {
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

                                // RadioButtons from the registration folder inside of widget
                                RadioButtonGender(0, 'Männlich', genderSelected,
                                    (newValue) {
                                  print(newValue);
                                  setState(() => genderSelected = newValue);
                                }),
                                RadioButtonGender(1, 'Weiblich', genderSelected,
                                    (newValue) {
                                  print(newValue);
                                  setState(() => genderSelected = newValue);
                                }),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                child: const Text("Hinzufügen"),
                                onPressed: () async {
                                  // validation of the TextFormFields
                                  if (_formKeys.currentState!.validate()) {
                                    print('validate okok');

                                    print('pw confirmed:' + passwordConfirmedController.text.trim());
                                    print('pw:' + passwordController.text.trim());

                                    //password and passworconfirm check
                                    if (passwordConfirmedController.text
                                            .trim() ==
                                        passwordController.text.trim()) {

                                      // checking if a date and gender is selected
                                      // controllers don't need to get checked, because of validation
                                      if (isDateSelected != false &&
                                          genderSelected != null) {

                                        // input is the email of the user
                                        // output are all the user informations in a Map<String, dynamic>
                                        // used to check the status and role of the user
                                        mapUserinformations =
                                            await authproviderInstance
                                                .getUserByEmail(emailController
                                                    .text
                                                    .trim());

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
                                                  await authproviderInstance
                                                      .UsernameExist(
                                                          usernameController
                                                              .text
                                                              .trim());

                                              //if username already exist, then print error otherwise recreate user
                                              if (mapUsernameExist!.isEmpty) {
                                                print('username is free');

                                                //update user informations
                                                await authproviderInstance
                                                    .updateUserSignup(
                                                        mapUserinformations![
                                                            'uid'],
                                                        usernameController.text
                                                            .trim(),
                                                        emailController.text
                                                            .trim(),
                                                        firstNameController.text
                                                            .trim(),
                                                        lastNameController.text
                                                            .trim(),
                                                        _birthDateInString,
                                                        genderSelected,
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
                                                          content: Text(e
                                                              .message
                                                              .toString()),
                                                        );
                                                      });
                                                }
                                                clearController();
                                                isDateSelected = false;
                                                genderSelected = null;

                                                // deleted user got recreated - now print a message that the registration process is completed
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            "Registration abgeschlossen.\nDer Account war gelöscht, daher wurde eine E-Mail zum zurücksetzen des persönlichen Passworts zugesendet.\nNachdem das Passwort abgeändert wurde, kann sich der Benutzer mit diesem"
                                                            "in unserer App einloggen.",
                                                            textAlign: TextAlign
                                                                .center),
                                                        actions: [
                                                          TextButton(
                                                            child: const Text("Ok"),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    });
                                                userTable.initializeData();
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
                                                              Navigator.of(
                                                                      context)
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
                                                builder:
                                                    (BuildContext context) {
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
                                        // email not existing in database -> mapUserinformations is emtpy
                                        else {
                                          try {
                                            print('email existiert noch nicht');

                                            // input is the usernameController, which provides the written username
                                            // output are all the user informations in a Map<String, dynamic>
                                            // used to get a unique username
                                            mapUsernameExist =
                                                await authproviderInstance
                                                    .UsernameExist(
                                                        usernameController.text
                                                            .trim());

                                            // if mapUsernameExist is empty, then the username is free
                                            if (mapUsernameExist!.isEmpty) {
                                              print('username is free');

                                              // sign up user in database with the birthday and gender + all controllers
                                              await authproviderInstance
                                                  .signUpUser(
                                                      usernameController.text
                                                          .trim(),
                                                      emailController.text
                                                          .trim(),
                                                      passwordController.text
                                                          .trim(),
                                                      firstNameController.text
                                                          .trim(),
                                                      lastNameController.text
                                                          .trim(),
                                                      _birthDateInString,
                                                      genderSelected);
                                              isDateSelected = false;
                                              genderSelected = null;

                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Benutzer wurde erfolgreich erstellt."),
                                                      actions: [
                                                        TextButton(
                                                          child: const Text("Ok"),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  });
                                              clearController();
                                              userTable.initializeData();
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
                                                            Navigator.of(
                                                                    context)
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
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  )
                                                ],
                                              );
                                            });
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
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
            })
      },
      icon: const Icon(
        Icons.add,
        color: Colors.black,
      ),
      label: const Text("Hinzufügen", style: TextStyle(color: Colors.black)),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
      ),
    );
  }
}

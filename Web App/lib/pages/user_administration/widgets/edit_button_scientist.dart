import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/auth.dart';
import '../../../provider/users_table.dart';
import '../../registration/widgets/radiobuttons.dart';
import 'package:intl/intl.dart';

// Button which edit an User in the database (and table)

class EditButtonScientist extends StatefulWidget {
  const EditButtonScientist({Key? key}) : super(key: key);

  @override
  State<EditButtonScientist> createState() => _EditButtonScientistState();
}

class _EditButtonScientistState extends State<EditButtonScientist> {
  String? genderSelected;

  late List<Map<String, dynamic>> selectedRows;
  String? selectedUid;

  String? _birthDateInString;
  DateTime? birthDate;
  bool isDateSelected = true;

  final GlobalKey<FormState> _formKeys = GlobalKey<FormState>(); // key for validation of the TextFormFields

  Map<String, dynamic>? mapUsernameExist = {};
  Map<String, dynamic>? mapUserinformations = {};

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
    final UsersTable userTable = Provider.of<UsersTable>(context); // instance of UserTable
    final AuthProvider authproviderInstance =
        Provider.of<AuthProvider>(context); // instance of AuthProvider

    return TextButton.icon(
      onPressed: () => {
        selectedRows = userTable
            .selecteds, //get the selected row from the userTable.dart
        if (selectedRows.length == 1)
          {
            //change the value of the TextFieldsControllers, RadioButtons and Birthday to the data of the selected user
            usernameController.value = TextEditingValue(
                text: selectedRows[0]['username'],
                selection: TextSelection.fromPosition(
                    TextPosition(offset: selectedRows[0]['username'].length))),

            emailController.value = TextEditingValue(
                text: selectedRows[0]['email'],
                selection: TextSelection.fromPosition(
                    TextPosition(offset: selectedRows[0]['email'].length))),

            firstNameController.value = TextEditingValue(
                text: selectedRows[0]['first name'],
                selection: TextSelection.fromPosition(TextPosition(
                    offset: selectedRows[0]['first name'].length))),

            lastNameController.value = TextEditingValue(
                text: selectedRows[0]['last name'],
                selection: TextSelection.fromPosition(
                    TextPosition(offset: selectedRows[0]['last name'].length))),

            _birthDateInString = selectedRows[0]['birthday'],

            genderSelected = selectedRows[0]['gender'],

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
                                    Text("Benutzer bearbeiten",
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
                                    validator: (email) => EmailValidator
                                            .validate(email!)
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //SizedBox(width: 11,),

                                    const Text(
                                      "Geburtsdatum:",
                                      style: TextStyle(fontSize: 18),
                                    ),

                                    // DateTime birthday selection
                                    GestureDetector(
                                      child: const Icon(
                                        Icons.calendar_today,
                                        size: 30,
                                      ),
                                      onTap: () async {
                                        final DateTime? datePick =
                                            await showDatePicker(
                                          locale: const Locale('de'),
                                          context: context,
                                          initialDate: DateFormat(
                                                  "dd/MM/yyyy", 'de')
                                              .parseStrict(
                                                  selectedRows[0]['birthday']),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                    RadioButtonGender(
                                        0, 'Männlich', genderSelected,
                                        (newValue) {
                                      print(newValue);
                                      setState(() => genderSelected = newValue);
                                    }),
                                    RadioButtonGender(
                                        1, 'Weiblich', genderSelected,
                                        (newValue) {
                                      print(newValue);
                                      setState(() => genderSelected = newValue);
                                    }),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    child: const Text("Bearbeiten"),
                                    onPressed: () async {
                                      // validation of the TextFormFields
                                      if (_formKeys.currentState!.validate()) {

                                        // checking if a date,gender and role is selected
                                        // controllers don't need to get checked, because of validation
                                        if (isDateSelected != false &&
                                            genderSelected != null) {

                                          // get the selected uid from the usertable
                                          selectedUid = selectedRows[0]['uid'];

                                          // input is the emailController, which provides the written email
                                          // output are all the user informations in a Map<String, dynamic>
                                          // used to get a unique email
                                          mapUserinformations =
                                              await authproviderInstance
                                                  .getUserByEmail(
                                                      emailController.text
                                                          .trim());

                                          //when email exist, then check if it is his own email
                                          if (mapUserinformations!.isNotEmpty) {
                                            print('email is already existing');

                                            //check if it is his own email
                                            if (selectedRows[0]['email'] ==
                                                mapUserinformations!['email']) {
                                              print('own email');

                                              // input is the usernameController, which provides the written username
                                              // output are all the user informations in a Map<String, dynamic>
                                              // used to get a unique username
                                              mapUsernameExist =
                                                  await authproviderInstance
                                                      .UsernameExist(
                                                          usernameController
                                                              .text
                                                              .trim());

                                              // if mapUsernameExist is empty, then the username is free
                                              // if mapUsernameExist is the same username as the selected user's username, then it is his own username
                                              if (mapUsernameExist!.isEmpty ||
                                                  mapUsernameExist![
                                                          'username'] ==
                                                      selectedRows[0]
                                                          ['username']) {
                                                print(
                                                    'username is free oder eigene');

                                                //update the user with the controllers and the selected role,gender,birthday + the uid
                                                await authproviderInstance
                                                    .updateUserEdit(
                                                        selectedUid,
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

                                                userTable.selecteds
                                                    .clear(); //clear the selected row variable
                                                userTable
                                                    .initializeData(); //initializeData to update the table

                                                // user information successful edited - now print a message, so the user have a reply
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            "Editieren abgeschlossen",
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
                                            } else {
                                              print('not own email');
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
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  });
                                            }
                                          } else {
                                            print('email is not existing');

                                            // input is the usernameController, which provides the written username
                                            // output are all the user informations in a Map<String, dynamic>
                                            // used to get a unique username
                                            mapUsernameExist =
                                                await authproviderInstance
                                                    .UsernameExist(
                                                        usernameController.text
                                                            .trim());

                                            // if mapUsernameExist is empty, then the username already exist
                                            // if mapUsernameExist is the same username as the selected user's username, then it is his own username
                                            if (mapUsernameExist!.isEmpty ||
                                                mapUsernameExist!['username'] ==
                                                    selectedRows[0]
                                                        ['username']) {
                                              print(
                                                  'username is free oder eigene');

                                              //update the user with the controllers and the selected role,gender,birthday + the uid
                                              await authproviderInstance
                                                  .updateUserEdit(
                                                      selectedUid,
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

                                              userTable.selecteds
                                                  .clear(); //clear the selected row variable
                                              userTable
                                                  .initializeData(); //initializeData to update the table

                                              // user information successful edited - now print a message, so the user have a reply
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Editieren abgeschlossen",
                                                          textAlign:
                                                              TextAlign.center),
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
                                          }
                                        }
                                        // not all Textfields/Buttons are filled
                                        else {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Error: Editieren gescheitert! Bitte alle Felder ausfüllen."),
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
                                      } // not all Textfields/Buttons are filled
                                      else {
                                        print('validate notgoodatall');
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
                                                      Navigator.of(context)
                                                          .pop();
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
          }
        else
          {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Error: Bitte wähle genau einen User aus."),
                    actions: [
                      TextButton(
                        child: const Text("Ok"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                }),
          }
      },
      icon: const Icon(
        IconData(0xf00d, fontFamily: 'MaterialIcons'),
        color: Colors.black,
      ),
      label: const Text("Bearbeiten", style: TextStyle(color: Colors.black)),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
      ),
    );
  }
}

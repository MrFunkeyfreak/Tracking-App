import 'package:bestfitnesstrackereu/pages/registration/widgets/radiobuttons.dart';
import 'package:bestfitnesstrackereu/routing/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth.dart';
import '../../widgets/loading_circle/loading_circle.dart';

// not in use because we have edit_button_scientist.dart

class RegistrationScientistView extends StatefulWidget {
  const RegistrationScientistView({Key? key}) : super(key: key);

  @override
  State<RegistrationScientistView> createState() => _RegristrationViewState();
}

class _RegristrationViewState extends State<RegistrationScientistView> {
  String? _genderSelected;

  String? _birthDateInString;
  DateTime? birthDate;
  bool isDateSelected = false;

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
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Center(
          child: authProvider.status == Status.Authenticating
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
                            child: Image.asset("assets/logo.png"),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: const [
                          Text("Wissenschaftler-Registrierung",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Text("Wilkommen zur Wissenschaftler-Registration",
                              style: TextStyle(
                                color: Colors.grey,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                            labelText: "Benutzername",
                            hintText: "Max123",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            labelText: "E-Mail",
                            hintText: "abc@domain.com",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Passwort",
                            hintText: "******",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: passwordConfirmedController,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Passwort wiederholen",
                            hintText: "******",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                            labelText: "Vorname",
                            hintText: "Max",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                            labelText: "Nachname",
                            hintText: "Mustermann",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
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
                                errorFormatText: 'Enter valid date',
                                errorInvalidText: 'Enter date in valid range',
                                fieldLabelText: 'Birthdate',
                                fieldHintText: 'TT/MM/YYYY',
                              );
                              if (datePick != null && datePick != birthDate) {
                                setState(() {
                                  birthDate = datePick;
                                  isDateSelected = true;

                                  // birthdate in string
                                  _birthDateInString =
                                      "${birthDate!.month}/${birthDate!.day}/${birthDate!.year}";
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
                            print('pw confirmed:' +
                                passwordConfirmedController.text.trim());
                            print('pw:' + passwordController.text.trim());

                            if (passwordConfirmedController.text.trim() ==
                                passwordController.text.trim()) {
                              if (_birthDateInString != null &&
                                  _genderSelected != null) {
                                //if signIn is success, then signUp + clear controller

                                /*if(authProvider.validateEmail(authProvider.email.text.trim()) == null){
                            print('validate email okok');
                          }
                          else{
                            print('validate email notgoodatall');
                          }             -> email checken, dass es bestimmtes format einhält */

                                await authProvider.signUpUser(
                                    usernameController.text.trim(),
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                    firstNameController.text.trim(),
                                    lastNameController.text.trim(),
                                    _birthDateInString,
                                    _genderSelected);
                                clearController();
                                Navigator.of(context).pushNamed(DashboardRoute);
                              } else {
                                //signIn failed, then return Login failed
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
                    ],
                  ),
                )),
    );
  }
}

import 'package:bestfitnesstrackereu/pages/registration/widgets/radiobuttons.dart';
import 'package:bestfitnesstrackereu/routing/route_names.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth.dart';
import '../../widgets/loading_circle/loading_circle.dart';

// not in use because we have edit_button_admin.dart

class RegistrationAdminsView extends StatefulWidget {
  const RegistrationAdminsView({Key? key}) : super(key: key);

  @override
  State<RegistrationAdminsView> createState() => _RegristrationViewState();
}

class _RegristrationViewState extends State<RegistrationAdminsView> {
  String? _genderSelected;
  String? _roleSelected;

  String? _birthDateInString;
  DateTime? birthDate;
  bool isDateSelected = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    final hasAuthenticated = context.select<AuthProvider, bool>(
            (AuthProvider) =>
        authProvider.status ==
            Status.Authenticating); //used to check the authentication status

    return Scaffold(
      body: Center(
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
                            child: Image.asset("assets/logo.png"), //image of our logo
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: const [
                          Text("Admin-Registrierung",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Text("Wilkommen zur Admin-Registration",
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
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: TextFormField(
                          validator: (email) => EmailValidator.validate(email!)
                              ? null
                              : "Please enter a valid email",
                          controller: emailController,
                          decoration: InputDecoration(
                              labelText: "E-Mail",
                              hintText: "abc@domain.com",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
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

                          // DateTime birthday selection
                          GestureDetector(
                            child: const Icon(
                              Icons.calendar_today,
                              size: 30,
                            ),
                            onTap: () async {
                              final DateTime? datePick = await showDatePicker(
                                context: context,
                                initialDate:  DateTime.now(),
                                firstDate:  DateTime(1900),
                                lastDate: DateTime(2100),
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
                                  print(_birthDateInString!);
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

                          // RadioButtons from the registration folder inside of widget
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const Text(
                            "Rolle:",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            width: 10,
                          ),

                          // RadioButtons from the registration folder inside of widget
                          RadioButtonRole(0, 'User', _roleSelected, (newValue) {
                            print(newValue);
                            setState(() => _roleSelected = newValue);
                          }),
                          RadioButtonRole(1, 'Wissenschaftler', _roleSelected,
                              (newValue) {
                            print(newValue);
                            setState(() => _roleSelected = newValue);
                          }),
                          RadioButtonRole(2, 'Admin', _roleSelected,
                              (newValue) {
                            print(newValue);
                            setState(() => _roleSelected = newValue);
                          }),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                          onTap: () async {
                            final form = _formKey.currentState;
                            print(form);

                            print('pw confirmed:' +
                                passwordConfirmedController.text.trim());
                            print('pw:' + passwordController.text.trim());

                            if (passwordConfirmedController.text.trim() ==
                                passwordController.text.trim()) {
                              if (_birthDateInString != null &&
                                  _genderSelected != null) {
                                //if signIn is success, then signUp + clear controller

                                if (form!.validate()) {
                                  print('validate email okok');
                                } else {
                                  print('validate email notgoodatall');
                                }

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

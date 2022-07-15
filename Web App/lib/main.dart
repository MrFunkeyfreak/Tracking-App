import 'package:bestfitnesstrackereu/provider/auth.dart';
import 'package:bestfitnesstrackereu/provider/users_table.dart';
import 'package:bestfitnesstrackereu/routing/route_names.dart';
import 'package:bestfitnesstrackereu/routing/router.dart';
import 'package:bestfitnesstrackereu/services/navigation_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'locator.dart';

// connection to the database -> connection need to be ensured
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBDTaDfjNVxDgM82AAq9jgVYOjtiQ4CV7Y",
        authDomain: "tracking-app-5aafd.firebaseapp.com",
        databaseURL:
            "https://tracking-app-5aafd-default-rtdb.europe-west1.firebasedatabase.app",
        projectId: "tracking-app-5aafd",
        storageBucket: "tracking-app-5aafd.appspot.com",
        messagingSenderId: "792812168466",
        appId: "1:792812168466:web:0c88adc20adda5328e7fcb",
        measurementId: "G-W3QVMWFDD3"),
  );

  // initialize the notifyListeners/Providers
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AuthProvider.initialize()),
    ChangeNotifierProvider.value(value: UsersTable.init()),
  ], child: const MyApp()));
  setupLocator(); // initialize the locator
}

// setting language to german + setting the navigatorKey,
// setting the initialRoute and the onGenerateRoute for generating the routes from router.dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('de', ''),
        Locale('en', ''),
      ],
      locale: const Locale('de'),
      title: 'BestFitnesstrackerEU',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
      ),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: InformationRoute,
    );
  }
}

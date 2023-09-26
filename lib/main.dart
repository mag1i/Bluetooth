import 'package:dntst/profile.dart';
import 'package:dntst/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Addpatient.dart';
import 'admin.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'login.dart';

void main() async {
  sqfliteFfiInit();
  // Use the sqflite_common_ffi database factory
  databaseFactory = databaseFactoryFfi;
  final rep = Repository();
  Admin? loggedInAdmin;

  // Check if there's a logged-in admin session
  // For example, you can store the email in shared preferences
  //final savedEmail = 'john@example.com';
  final prefs = await SharedPreferences.getInstance();
  final savedEmail= prefs.getString('email');
  if (savedEmail != " " && savedEmail != null) {
    loggedInAdmin = await rep.getAdmin(savedEmail!);
  }else{print("Noooooo");}



  WidgetsFlutterBinding.ensureInitialized();
  // Set the minimum window size for desktop apps
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(MyApp( rep : rep,
    loggedInAdmin: loggedInAdmin,));
}

class MyApp extends StatefulWidget {
  final Repository rep;
  final Admin? loggedInAdmin;
  const MyApp({required this.rep, required this.loggedInAdmin});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Admin? loggedInAdmin;

  @override
  void initState() {
    super.initState();
    loggedInAdmin = widget.loggedInAdmin;
  }

  void logout() {
    setState(() {
      loggedInAdmin = null; // Set loggedInAdmin to null to go back to the login screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin App',
      home: loggedInAdmin != null
          ? ProfilePage(
        admin: loggedInAdmin!,
        onLogout: logout,
      )
          : login(dbConnection: widget.rep),
    );
  }
}
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/Screens/Login.dart';
import 'package:school_management_system/Screens/SignUp.dart';
import 'package:school_management_system/Screens/Home.dart';

import 'Backend/FirebaseStorageManager.dart';
import 'Backend/FirestoreManager.dart';
import 'Screens/Lander.dart';

// initialisation of Firebase Authentication
FirebaseAuth authInstance = FirebaseAuth.instance;
// initialisation of Firebase Storage
FirebaseStorage storageInstance = FirebaseStorage.instance;
// initialise StorageManager class
late final FirestoreManager firestoreManager = FirestoreManager(authInstance: authInstance);
// initialise StorageManager class
late final FirebaseStorageManager storageManager = FirebaseStorageManager();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  late String initialRouteName;
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      log('Main Error: $e');
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // Show error message if initialization failed
    if(_error) {
      return Text('Something went wrong');
    }
    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Center(child: CircularProgressIndicator(color: Colors.blue));
    }

    return MaterialApp(
      home: Lander(),
      routes: {
        '/Home': (context) => Home(),
        '/Login': (context) => Login(),
        '/SignUp': (context) => SignUp(),
      },
    );
  }
}



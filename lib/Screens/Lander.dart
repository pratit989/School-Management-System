import 'dart:developer';

import 'Login.dart';
import 'Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Lander extends StatefulWidget {

  @override
  _LanderState createState() => _LanderState();
}

class _LanderState extends State<Lander> {

  bool? initialized = false;
  var userCache;

  void initialize() async {
    if (userCache != authInstance.currentUser) {
      try {
        userCache = authInstance.currentUser ?? null;
        // Get Profile Picture download URL
        setState(() {
          initialized = true;
        });
      } catch (e) {
        log('Lander Error: $e');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (authInstance.currentUser != null) {
      initialize();
    } else {initialized = null;}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized == true) {
      return Home();
    } else if (initialized == null) {
      return Login();
    } else if (initialized == false) {
      return Center(child: CircularProgressIndicator(color: Colors.blue));
    }
    return Text('Something went wrong in Lander Screen');
  }
}

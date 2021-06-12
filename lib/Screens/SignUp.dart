import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Item {
  const Item(this.name, this.icon);

  final String name;
  final Icon icon;
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String email;
  late String password;
  late String name;
  late String phoneNumber;
  // Initially password is obscure
  bool _obscureText = true;
  IconData _icon = Icons.lock_outline;

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _loginKey = GlobalKey<FormState>();

  Item? selectedUser;
  List<Item> users = <Item>[
    const Item(
        'Student',
        Icon(
          Icons.person,
          color: Colors.grey,
        )),
    const Item(
        'Teacher',
        Icon(
          Icons.corporate_fare,
          color: Colors.grey,
        )),
  ];

  var _name = TextEditingController();
  var _email = TextEditingController();
  var _password = TextEditingController();
  var _phoneNo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.blue,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                          spreadRadius: 0.5,
                          offset: Offset(0, 0), // shadow direction: bottom right
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.03),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize:
                                MediaQuery.of(context).size.height * 0.03),
                          ),
                        ),
                        Form(
                            key: _loginKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  padding: EdgeInsets.only(
                                    top:
                                    MediaQuery.of(context).size.height * 0.02,
                                  ),
                                  child: TextFormField(
                                    textCapitalization: TextCapitalization.words,
                                    validator: (value) {
                                      if (value!.isEmpty || value == 'Name') {
                                        return 'Please enter a valid name.';
                                      } else {
                                        name = value;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      hintText: 'Name',
                                    ),
                                    controller: _name,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  padding: EdgeInsets.only(
                                    top:
                                    MediaQuery.of(context).size.height * 0.02,
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty || value == 'Email' || !value.contains('@')) {
                                        return 'Please enter a valid email.';
                                      } else {
                                        email = value;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.email), hintText: 'Email'),
                                    controller: _email,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  padding: EdgeInsets.only(
                                    top:
                                    MediaQuery.of(context).size.height * 0.02,
                                  ),
                                  child: TextFormField(
                                    obscureText: _obscureText,
                                    validator: (value) {
                                      if (value!.isEmpty || value == 'Password') {
                                        return 'Please enter a valid password.';
                                      } else if (value.length < 6) {
                                        return 'Password should be at least 6 characters long';
                                      } else {
                                        password = value;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.vpn_key),
                                        suffixIcon: IconButton(
                                          icon: Icon(_icon),
                                          onPressed: () {
                                            if(_obscureText){
                                              _obscureText = false;
                                              _icon = Icons.lock_open;
                                            } else {
                                              _obscureText = true;
                                              _icon = Icons.lock_outline;
                                            }
                                            setState(() {});
                                          },
                                        ),
                                        hintText: 'Password'
                                    ),
                                    controller: _password,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  padding: EdgeInsets.only(
                                    top:
                                    MediaQuery.of(context).size.height * 0.02,
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          value == 'Phone Number') {
                                        return 'Please enter a valid phone number.';
                                      } else if (value.length < 10 || value.length > 10) {
                                        return 'Please enter a valid phone number';
                                      } else {
                                        phoneNumber = value;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.phone_android), hintText: 'Phone Number'),
                                    controller: _phoneNo,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  padding: EdgeInsets.only(
                                    top:
                                    MediaQuery.of(context).size.height * 0.02,
                                  ),
                                  child: DropdownButtonFormField<Item>(
                                    validator: (value) =>
                                    value == null ? 'field required' : null,
                                    isExpanded: true,
                                    hint: Text("Select User Type"),
                                    value: selectedUser,
                                    onChanged: (Item? value) {
                                      setState(() {
                                        selectedUser = value!;
                                      });
                                    },
                                    items: users.map((Item user) {
                                      return DropdownMenuItem<Item>(
                                        value: user,
                                        child: Row(
                                          children: <Widget>[
                                            user.icon,
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              user.name,
                                              style:
                                              TextStyle(color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            )),
                        Builder(
                          builder: (context) => Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.01,
                                  bottom:
                                  MediaQuery.of(context).size.height * 0.02),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (_loginKey.currentState!.validate()) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      try {
                                        await authInstance
                                            .createUserWithEmailAndPassword(
                                            email: email, password: password);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                            content:
                                            Text('Creating Profile')));
                                        User user =
                                        authInstance.currentUser!;
                                        user.updateDisplayName(name);
                                        try {
                                          Navigator.pushReplacementNamed(context, '/Home');
                                        } catch (error) {
                                          print("Failed to add user: $error");
                                          authInstance.currentUser!.delete();
                                        }
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'weak-password') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                              content: Text(
                                                  'The password provided is too weak.')));
                                        } else if (e.code ==
                                            'email-already-in-use') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                              content: Text(
                                                  'The account already exists for that email.')));
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    }
                                  },
                                  child: Text('Sign Up', style: TextStyle(color: Colors.black),),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue))),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.05),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/Login');
                      },
                      child: Text(
                        "Already have an account? Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

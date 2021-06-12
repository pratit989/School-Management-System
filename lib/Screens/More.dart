import 'package:flutter/material.dart';
import 'package:school_management_system/main.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Card(
            child: TextButton(
              onPressed: () {
                authInstance.signOut();
                Navigator.pushReplacementNamed(context, '/Login');
              },
              child: Row(
                children: [
                  Icon(Icons.logout,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Logout", style: TextStyle()),
                  ),
                ],
              ),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size.fromWidth(MediaQuery.of(context).size.width-10))
              ),
            ),
          ),
          Card(
            child: TextButton(
              onPressed: () {
                showAlertDialog(
                  context,
                  acceptBtnText: "Delete",
                  onPressedAcceptBtn: () {authInstance.currentUser!.delete();Navigator.pushReplacementNamed(context, '/SignUp');},
                  onPressedCancelBtn: () {Navigator.of(context).pop();},
                  title: "Delete Alert",
                  description: "Are you sure you want to delete you account permanently?"
                );
              },
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Delete Account", style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context, {
  required String description,
  required String title,
  String cancelBtnText='Cancel',
  required void Function()? onPressedCancelBtn,
  String acceptBtnText='Accept',
  required void Function()? onPressedAcceptBtn,
}) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text(cancelBtnText),
    onPressed: onPressedCancelBtn,
  );
  Widget continueButton = TextButton(
    child: Text(acceptBtnText, style: TextStyle(color: Colors.red),),
    onPressed: onPressedAcceptBtn,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(description),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

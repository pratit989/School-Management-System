import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/Backend/FirebaseStorageManager.dart';
import 'dart:io';

import '../main.dart';

class HomeWork extends StatefulWidget {
  const HomeWork({Key? key}) : super(key: key);

  @override
  _HomeWorkState createState() => _HomeWorkState();
}

class _HomeWorkState extends State<HomeWork> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Upload your work,',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20
              ),
            ),
          ),
          Row(
            children: [
              Padding(padding: EdgeInsets.all(8), child: Container(
                child: IconButton(
                    icon: Icon(Icons.upload_file, color: Colors.white,),
                    onPressed: () async {
                      FilePickerResult? result =
                      await FilePicker.platform.pickFiles();
                      if (result != null) {
                        File file = File(result.files.single.path!);
                        try {
                          storageManager.uploadFile(
                              homeWorkReferenceURL,
                              file);
                        } on FirebaseException catch (e) {
                          print(e);
                          // e.g, e.code == 'canceled'
                        }
                      } else {
                        // User canceled the picker
                      }
                    }
                ),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)
                ),
              ),),
              Text('Upload a file', style: TextStyle(fontSize: 16),)
            ],
          ),
          // Row(
          //   children: [
          //     Padding(padding: EdgeInsets.all(8), child: Container(
          //       child: IconButton(
          //           icon: Icon(Icons.group_add, color: Colors.white,),
          //           onPressed: () {}
          //       ),
          //       decoration: BoxDecoration(
          //           color: Colors.blue,
          //           borderRadius: BorderRadius.circular(15)
          //       ),
          //     ),),
          //     Text('Invite a friend', style: TextStyle(fontSize: 16),)
          //   ],
          // ),
        ],
      ),
    );
  }
}

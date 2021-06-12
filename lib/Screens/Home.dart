import 'package:flutter/material.dart';
import 'package:school_management_system/Screens/Activity.dart';
import 'package:school_management_system/Screens/HomeWork.dart';
import 'package:school_management_system/Screens/More.dart';
import 'package:school_management_system/src/pages/index.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Text> _titles = [
    // Feed
    Text(
      'Feed',
      style: TextStyle(color: Colors.black),
    ),
    // Chat
    Text(
      'HomeWork',
      style: TextStyle(color: Colors.black),
    ),
    // Meet
    Text(
      'Meet',
      style: TextStyle(color: Colors.black),
    ),
    // More
    Text(
      'More',
      style: TextStyle(color: Colors.black),
    )
  ];

  final List<Widget> _pages = [
    // Activity Widget
    ActivityPage(),
    // Chat Widget
    HomeWork(),
    // Meet Widget
    IndexPage(),
    // More
    MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(backgroundImage: AssetImage('assets/1p.jpg'),),
        ),
        title: _titles[_currentIndex],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none), label: 'Activity', activeIcon: Icon(Icons.notifications)),
          BottomNavigationBarItem(
              icon: Icon(Icons.file_copy_outlined), label: 'HomeWork', activeIcon: Icon(Icons.file_copy)),
          BottomNavigationBarItem(
              icon: Icon(Icons.videocam_outlined), label: 'Meet', activeIcon: Icon(Icons.videocam)),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz_outlined), label: 'More')
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

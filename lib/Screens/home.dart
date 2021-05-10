import 'package:flutter/material.dart';

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
      'Chat',
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
    Container(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Text(
            'Stay up to date with relevant activity such as mentions, likes, and task updates',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    ),
    // Chat Widget
    Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'To get started,',
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
                    icon: Icon(Icons.people, color: Colors.white,),
                    onPressed: () {}
                ),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)
                ),
              ),),
              Text('Create a group', style: TextStyle(fontSize: 16),)
            ],
          ),
          Row(
            children: [
              Padding(padding: EdgeInsets.all(8), child: Container(
                child: IconButton(
                    icon: Icon(Icons.group_add, color: Colors.white,),
                    onPressed: () {}
                ),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)
                ),
              ),),
              Text('Invite a friend', style: TextStyle(fontSize: 16),)
            ],
          ),
        ],
      ),
    ),
    // Meet Widget
    Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Start a meeting', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),),
            Text('Get everyone together'),
            MaterialButton(onPressed: () {}, child: Text('Meet now', style: TextStyle(color: Colors.white),), color: Colors.blue,)
          ],
        ),
      ),
    ),
    // More
    Container(
      color: Colors.white,
    ),
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
              icon: Icon(Icons.chat_outlined), label: 'Chat', activeIcon: Icon(Icons.chat)),
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

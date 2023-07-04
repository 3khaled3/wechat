import 'package:flutter/material.dart';
import 'package:wechat/views/add_view.dart';
import 'package:wechat/views/test.dart';
import 'camera_view.dart';
import 'user_view.dart';
import 'home_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _currentIndex = 0;

  final iconList = <IconData>[
    Icons.home,
    // Icons.call,
    Icons.add,
    Icons.camera_alt_outlined,
    Icons.person,
  ];

  final List<Widget> _screens = [
    const HomeView(),
    // const CallView(),
    const test(),
    const test(),
    //  const UserView(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(backgroundColor: Colors.black,unselectedIconTheme: const IconThemeData(color: Colors.grey),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            
            if (index==1) {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  const ImageScreen(),));
              
            }else  if (index==2) {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  const CameraScreen(),));
              
            }else {_currentIndex = index;}
          });
        },
        items: const [
          BottomNavigationBarItem(backgroundColor: Color.fromARGB(251, 13, 29, 25),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          //  BottomNavigationBarItem(backgroundColor: Color.fromARGB(251, 13, 29, 25),
          //   icon: Icon(Icons.call),
          //   label: 'Call',
          // ),
           BottomNavigationBarItem(backgroundColor: Color.fromARGB(251, 13, 29, 25),
            icon: Icon(Icons.add),
            label: 'add',
          ),
          BottomNavigationBarItem(backgroundColor: Color.fromARGB(251, 13, 29, 25),
            icon: Icon(Icons.camera_alt_outlined),
            label: 'camera',
          ),
          BottomNavigationBarItem(backgroundColor: Color.fromARGB(251, 13, 29, 25),
            icon: Icon(Icons.person),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}


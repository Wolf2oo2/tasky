import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/features/tasks/completed_tasks_screen.dart';
import 'package:tasky/features/home/home_screen.dart';
import 'package:tasky/features/profile/profile_screen.dart';
import 'package:tasky/features/tasks/tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screen = [
    HomeScreen(),
    TasksScreen(),
    CompletedTasksScreen(),

    ProfileScreen(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: screen[_currentIndex]),


      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(

          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,



        ),
        child: BottomNavigationBar(

          elevation: 0,
          onTap: (int? index) {
            setState(() {
              _currentIndex = index ?? 0;
            });
          },
          currentIndex: _currentIndex,

          items: [
            BottomNavigationBarItem(
              icon: _buildSvgPicture('assets/images/home.svg',0),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon:_buildSvgPicture('assets/images/todo.svg',1),

              label: "To do ",
            ),
            BottomNavigationBarItem(
              icon:_buildSvgPicture('assets/images/completed.svg',2)
              ,
              label: "Completed",
            ),
            BottomNavigationBarItem(
              icon:_buildSvgPicture( 'assets/images/profile.svg',3) ,

              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  SvgPicture _buildSvgPicture(String path,int index) {
    return SvgPicture.asset(
              path,
              colorFilter: ColorFilter.mode(
                _currentIndex == index ? Color(0xff15B86C) : Color(0xffC6C6C6),
                BlendMode.srcIn,
              ),
            );
  }
}

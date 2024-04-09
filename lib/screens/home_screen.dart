import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:task_manager_test/screens/tasks_screen.dart';
import 'package:task_manager_test/screens/users_screen.dart';

import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    UsersScreen(),
    TasksScreen(),

  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(

            tabs: [
            new Container(
            child: new Tab(icon: Icon(Icons.person), text: 'Users'),),
    new Container(
    child: new Tab(icon: Icon(Icons.task), text: 'Tasks'),),

            ],
          ),
        ),
          body: TabBarView(
          children: _tabs,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_manager_test/routes/pages.dart';
import 'package:task_manager_test/screens/home_screen.dart';

import '../models/tasks/task_model.dart';
import '../screens/log_in_screen.dart';
import '../screens/new_task_screen.dart';
import '../screens/page_not_found.dart';
import '../screens/splash_screen.dart';
import '../screens/tasks_screen.dart';
import '../screens/update_task_screen.dart';
import '../screens/users_screen.dart';

Route onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Pages.initial:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
    case Pages.logIn:
      return MaterialPageRoute(
        builder: (context) => const LogInScreen(),
      );
    case Pages.home:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
    case Pages.user:
      return MaterialPageRoute(
        builder: (context) => const UsersScreen(),
      );
    case Pages.task:
      return MaterialPageRoute(
        builder: (context) => const TasksScreen(),
      );
    case Pages.createNewTask:
      return MaterialPageRoute(
        builder: (context) => const NewTaskScreen(),
      );
    case Pages.updateTask:
      final args = routeSettings.arguments as TaskModel;
      return MaterialPageRoute(
        builder: (context) => UpdateTaskScreen(taskModel: args),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const PageNotFound(),
      );
  }
}

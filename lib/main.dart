import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_test/bloc/login/login_bloc.dart';
import 'package:task_manager_test/repositories/Auth/auth_repository.dart';
import 'package:task_manager_test/repositories/tasks/task_repository.dart';
import 'package:task_manager_test/repositories/users/user_repository.dart';
import 'package:task_manager_test/routes/app_router.dart';
import 'package:task_manager_test/routes/pages.dart';
import 'package:task_manager_test/utils/color_palette.dart';

import 'bloc/bloc_state_observer.dart';
import 'bloc/tasks/tasks_bloc.dart';
import 'bloc/users/users_bloc.dart';
import 'data/api/auth_data_provider.dart';
import 'data/api/users_data_provider.dart';
import 'data/local/tasks/tasks_data_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = BlocStateOberver();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(RepositoryProvider<AuthRepository>(
    create: (context) =>
        AuthRepository(authDataProvider: AuthDataProvider(preferences)),
    child: BlocProvider<LoginBloc>(
      create: (context) =>
          LoginBloc(context.read<AuthRepository>())..add(AppStartedEvent()),
      child: MyApp(
        preferences: preferences,
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences preferences;

  const MyApp({super.key, required this.preferences});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<TaskRepository>(
            create: (context) =>
                TaskRepository(taskDataProvider: TaskDataProvider(preferences)),
          ),
          RepositoryProvider<UserRepository>(
            create: (context) =>
                UserRepository(userDataProvider: UserDataProvider()),
          ),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider<UsersBloc>(
                create: (context) => UsersBloc(context.read<UserRepository>()),
              ),
              BlocProvider<TasksBloc>(
                create: (context) => TasksBloc(context.read<TaskRepository>()),
              ),
            ],
            child: MaterialApp(
              title: 'Task Manager',
              debugShowCheckedModeBanner: false,
              initialRoute: Pages.initial,
              onGenerateRoute: onGenerateRoute,
              theme: ThemeData(
                fontFamily: 'Sora',
                visualDensity: VisualDensity.adaptivePlatformDensity,
                canvasColor: Colors.transparent,
                colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
                useMaterial3: true,
              ),
            )));
  }
}

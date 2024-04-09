import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_test/bloc/login/login_bloc.dart';

import '../components/widgets.dart';
import '../routes/pages.dart';
import '../utils/color_palette.dart';
import '../utils/font_sizes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //startTimer();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Pages.home,
              (route) => false,
            );
          });
        } else {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Pages.logIn,
              (route) => false,
            );
          });
        }
      },
      child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/app_logo.png',
                width: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              buildText('Everything Tasks', kWhiteColor, textBold,
                  FontWeight.w600, TextAlign.center, TextOverflow.clip),
              const SizedBox(
                height: 10,
              ),
              buildText('Schedule your week with ease', kWhiteColor, textTiny,
                  FontWeight.normal, TextAlign.center, TextOverflow.clip),
            ],
          ))),
    );
  }
}

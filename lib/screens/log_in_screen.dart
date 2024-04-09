import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_test/utils/constants.dart';

import '../../../components/widgets.dart';
import '../../../routes/pages.dart';
import '../../../utils/font_sizes.dart';
import '../bloc/login/login_bloc.dart';
import '../components/build_text_field.dart';
import '../utils/color_palette.dart';
import '../utils/util.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressedEvent(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(getSnackBar(state.error, kRed));
        }
        if (state is LoginSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Pages.home,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kWhiteColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         SizedBox(
                          height: size.height * .15,
                        ),
                        SvgPicture.asset(
                          'assets/svgs/tasks.svg',
                          height: size.height * .20,
                          width: size.width,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        buildText(
                            'Welcome in ' +Constants.appName,
                            kPrimaryColor,
                            textExtraLarge,
                            FontWeight.w600,
                            TextAlign.center,
                            TextOverflow.clip),

                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  buildText('Email', kBlackColor, textMedium, FontWeight.bold,
                      TextAlign.start, TextOverflow.clip),
                  const SizedBox(
                    height: 10,
                  ),
                  BuildTextField(
                      hint: "Email",
                      controller: _emailController,
                      inputType: TextInputType.text,
                      fillColor: kWhiteColor,
                      onChange: (value) {}),
                  const SizedBox(
                    height: 20,
                  ),
                  buildText('Password', kBlackColor, textMedium, FontWeight.bold,
                      TextAlign.start, TextOverflow.clip),
                  const SizedBox(
                    height: 10,
                  ),
                  BuildTextField(
                      hint: "Password",
                      controller: _passwordController,
                      obscureText: true,
                      inputType: TextInputType.text,
                      fillColor: kWhiteColor,
                      onChange: (value) {}),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kPrimaryColor),
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust the radius as needed
                              ),
                            ),
                          ),
                          onPressed: _onLoginButtonPressed,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: buildText(
                                'Log in',
                                kWhiteColor,
                                textMedium,
                                FontWeight.w600,
                                TextAlign.center,
                                TextOverflow.clip),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

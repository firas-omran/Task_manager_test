import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/widgets.dart';
import '../../../routes/pages.dart';
import '../../../utils/font_sizes.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/users/users_bloc.dart';
import '../components/custom_app_bar.dart';
import '../components/user_item_view.dart';
import '../utils/color_palette.dart';
import '../utils/constants.dart';
import '../utils/util.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    context.read<UsersBloc>().page = 1;
    context.read<UsersBloc>().add(FetchUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: ScaffoldMessenger(
            child: Scaffold(
          backgroundColor: kWhiteColor,
          appBar: CustomAppBar(
            title: '',
            showBackArrow: false,
            actionWidgets: [
              buildText(
                  'Log out',
                  kPrimaryColor,
                  textExtraLarge,
                  FontWeight.w600,
                  TextAlign.center,
                  TextOverflow.clip),
              IconButton(
                  onPressed: () {
                    BlocProvider.of<LoginBloc>(context).add(LoggedOutEvent());
                  },
                  icon: const Icon(Icons.logout,
                  color: kPrimaryColor,)),
            ],
          ),
          body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginUnauthenticated) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Pages.logIn,
                          (route) => false,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                      return BlocConsumer<UsersBloc, UsersState>(
                          listener: (context, state) {
                        if (state is LoadUserFailure) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(getSnackBar(state.error, kRed));
                        }
                      }, builder: (context, state) {
                        if (state is UsersLoading) {
                          return const Center(
                            child: CupertinoActivityIndicator(),
                          );
                        }

                        if (state is LoadUserFailure) {
                          return Center(
                            child: buildText(
                                state.error,
                                kRed,
                                textMedium,
                                FontWeight.normal,
                                TextAlign.center,
                                TextOverflow.clip),
                          );
                        }

                        if (state is FetchUsersSuccess) {
                          return state.users.isNotEmpty
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Expanded(
                                        child: ListView.separated(
                                      controller: context
                                          .read<UsersBloc>()
                                          .scrollController,
                                      shrinkWrap: true,
                                      itemCount: state.users.length,
                                      itemBuilder: (context, index) {
                                        return UserItemView(
                                            userModel: state.users[index]);
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const Divider(
                                          color: kGrey3,
                                        );
                                      },
                                    ))
                                  ],
                                )
                              : Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      buildText(
                                          'Not Found Users',
                                          kBlackColor,
                                          textBold,
                                          FontWeight.w600,
                                          TextAlign.center,
                                          TextOverflow.clip),
                                    ],
                                  ),
                                );
                        }
                        if (state is LoadMoreUserFailure) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                  child: ListView.separated(
                                controller:
                                    context.read<UsersBloc>().scrollController,
                                shrinkWrap: true,
                                itemCount: state.users.length + 1,
                                itemBuilder: (context, index) {
                                  if (index >= state.users.length) {
                                    return Center(
                                      child: buildText(
                                          state.error,
                                          kRed,
                                          textMedium,
                                          FontWeight.normal,
                                          TextAlign.center,
                                          TextOverflow.clip),
                                    );
                                  } else {
                                    return UserItemView(
                                        userModel: state.users[index]);
                                  }
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Divider(
                                    color: kGrey3,
                                  );
                                },
                              ))
                            ],
                          );
                        }
                        if (state is LoadMoreUserLoading) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                  child: ListView.separated(
                                controller:
                                    context.read<UsersBloc>().scrollController,
                                shrinkWrap: true,
                                itemCount: state.users.length + 1,
                                itemBuilder: (context, index) {
                                  if (index >= state.users.length) {
                                    return const Center(
                                      child: CupertinoActivityIndicator(),
                                    );
                                  } else {
                                    return UserItemView(
                                        userModel: state.users[index]);
                                  }
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Divider(
                                    color: kGrey3,
                                  );
                                },
                              ))
                            ],
                          );
                        }
                        if (state is LoadMoreUserFinish) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                  child: ListView.separated(
                                controller:
                                    context.read<UsersBloc>().scrollController,
                                shrinkWrap: true,
                                itemCount: state.users.length + 1,
                                itemBuilder: (context, index) {
                                  if (index >= state.users.length) {
                                    return Center(
                                      child: buildText(
                                          state.error,
                                          kRed,
                                          textMedium,
                                          FontWeight.normal,
                                          TextAlign.center,
                                          TextOverflow.clip),
                                    );
                                  } else {
                                    return UserItemView(
                                        userModel: state.users[index]);
                                  }
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Divider(
                                    color: kGrey3,
                                  );
                                },
                              ))
                            ],
                          );
                        }
                        return Container();
                      });
                    },
                  ))),
        )));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../components/widgets.dart';
import '../../../routes/pages.dart';
import '../../../utils/color_palette.dart';
import '../../../utils/font_sizes.dart';
import '../bloc/tasks/tasks_bloc.dart';
import '../models/users/user_model.dart';

class UserItemView extends StatefulWidget {
  final UserModel userModel;

  const UserItemView({super.key, required this.userModel});

  @override
  State<UserItemView> createState() => _UserItemViewState();
}

class _UserItemViewState extends State<UserItemView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(

      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(.3),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage(widget.userModel.avatar.toString()),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: buildText(
                                widget.userModel.firstName +
                                    '  ' +
                                    widget.userModel.lastName,
                                kBlackColor,
                                textExtraLarge,
                                FontWeight.w500,
                                TextAlign.start,
                                TextOverflow.clip)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildText(widget.userModel.email, kGrey1, textMedium,
                        FontWeight.normal, TextAlign.start, TextOverflow.clip),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

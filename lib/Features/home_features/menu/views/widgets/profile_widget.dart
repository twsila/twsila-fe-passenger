import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/registeration/bloc/registeration_bloc.dart';
import 'package:taxi_for_you/Features/registeration/bloc/registeration_state.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

import '../../../../../core/utils/resources/routes_manager.dart';
import '../../../../../data/model/user-model.dart';

class CustomProfileWidget extends StatefulWidget {
  final UserModel userModel;

  const CustomProfileWidget({Key? key, required this.userModel})
      : super(key: key);
  @override
  _CustomProfileWidgetState createState() => _CustomProfileWidgetState();
}

class _CustomProfileWidgetState extends State<CustomProfileWidget> {
  ValueNotifier notifier = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 90,
      child: Row(
        children: [
          Container(
            width: 90,
            decoration: BoxDecoration(
                color: ColorManager.bottomNavUnselected,
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Image.asset(ImageAssets.userProfile),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocConsumer<RegistrationBloc, RegistrationStates>(
                  listener: ((context, state) {
                if (state is EditUserSuccessfully) {
                  setState(() {});
                }
              }), builder: ((context, state) {
                return Text(
                  (widget.userModel.firstName ?? '') +
                      ' ' +
                      (widget.userModel.lastName ?? ''),
                  style: getBoldStyle(
                      color: ColorManager.primaryTextColor, fontSize: 14),
                );
              })),
              Text(
                (widget.userModel.mobileNumber ?? ''),
                style: getBoldStyle(
                    color: ColorManager.bottomNavUnselected, fontSize: 14),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.registerRoute,
                    arguments: {
                      "user": widget.userModel,
                      "isEdit": true,
                      "notifier": notifier,
                    },
                  );
                },
                child: Row(
                  children: [
                    Text(
                      AppStrings.editProfile.tr(),
                      style: getBoldStyle(
                          color: ColorManager.primary, fontSize: 14),
                    ),
                    const SizedBox(width: 4),
                    Image.asset(ImageAssets.edit),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

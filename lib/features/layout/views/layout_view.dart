import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aqsa_key_game/core/utils/functions/repeated_functions.dart';
import 'package:aqsa_key_game/features/layout/logic/cubit/layout_cubit.dart';
import 'package:aqsa_key_game/features/layout/logic/cubit/layout_states.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        var layoutCubit = LayoutCubit.get(context);
        return OrientationBuilder(
          builder: (context, orientation) {
            ScreenUtil.configure(
                designSize: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height));
            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                if (layoutCubit.currentButtomNavIndex != 0) {
                  layoutCubit.changeButtonNavItem(0);
                } else {
                  RepeatedFunctions.showCustomDialog(
                    context,
                    "Are you sure you want to exit?",
                    primaryText: "Close",
                    secondryText: "Cancel",
                    onPrimaryTap: () {
                      SystemNavigator.pop();
                    },
                  );
                }
              },
              child: Scaffold(
                  body: layoutCubit
                      .clientScreens[layoutCubit.currentButtomNavIndex]),
            );
          },
        );
      },
    );
  }
}

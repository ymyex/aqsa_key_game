import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aqsa_key_game/core/constant/assets_data.dart';
import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';
import 'package:aqsa_key_game/core/utils/helper/spacing.dart';
import 'package:aqsa_key_game/core/utils/styles/font_manager.dart';
import 'package:aqsa_key_game/core/utils/styles/text_style_manger.dart';
import 'package:aqsa_key_game/features/layout/logic/cubit/layout_cubit.dart';
import 'package:aqsa_key_game/features/admin/login/data/repository/login_repo.dart';
import 'package:aqsa_key_game/features/admin/login/logic/cubit/login_cubit.dart';
import 'package:aqsa_key_game/features/admin/login/logic/cubit/login_state.dart';
import 'package:aqsa_key_game/core/shared/widgets/action_button.dart';

class PlayerLoginScreen extends StatefulWidget {
  const PlayerLoginScreen({super.key});

  @override
  PlayerLoginScreenState createState() => PlayerLoginScreenState();
}

class PlayerLoginScreenState extends State<PlayerLoginScreen> {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginCubit(LoginRepo()), // Providing the LoginRepo to the cubit
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 210.h,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              AssetsData.loginBanner,
              fit: BoxFit.fill,
            ),
          ),
        ),
        body: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              // Handle login success, navigate to the home page or another screen
              var layoutCubit = LayoutCubit.get(context);
              layoutCubit.changeButtonNavItem(5);
              layoutCubit.login();
            } else if (state is LoginErrorState) {
              // Handle error
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is LoginLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              controller: LayoutCubit.get(context).scrollController,
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(top: 24.h),
                        child: Text("مرحبًا بعودتك!",
                            style: getExtraBoldStyle(fontSize: FontSize.s32)),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 27.w, top: 40.h, right: 27.w),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: groupNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'من فضلك أدخل اسم المجموعة الخاصة بك';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'اسم المجموعة',
                              hintStyle: getRegularStyle(
                                  fontSize: FontSize.s16,
                                  color: AppColors.kGreyColor),
                              filled: true,
                              fillColor: AppColors.kWhiteColor,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 16.h, horizontal: 20.w),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: BorderSide(
                                    color: AppColors.kDarkGreyColor,
                                    width: 1.5.w),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: BorderSide(
                                    color: AppColors.kPrimary1Color,
                                    width: 1.5.w),
                              ),
                            ),
                          ),
                          verticalSpace(20),
                          TextFormField(
                            controller: passwordController,
                            obscureText:
                                !isPasswordVisible, // Toggle password visibility
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'من فضلك أدخل كلمة المرور الخاصة بك';
                              }
                              // You can add more validation logic here (e.g., password strength)
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'كلمة المرور',
                              hintStyle: getRegularStyle(
                                  fontSize: 16.sp,
                                  color: AppColors
                                      .kGreyColor), // Adjust fontSize as needed
                              filled: true,
                              fillColor: AppColors.kWhiteColor,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 16.h,
                                  horizontal: 20.w), // Adjust padding as needed
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: BorderSide(
                                    color: AppColors.kDarkGreyColor,
                                    width: 1.5.w),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: BorderSide(
                                    color: AppColors.kPrimary1Color,
                                    width: 1.5.w),
                              ),
                              // Suffix icon for toggling password visibility
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Choose the icon based on password visibility
                                  isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: isPasswordVisible
                                      ? AppColors.kPrimary1Color
                                      : AppColors.kGreyColor,
                                ),
                                onPressed: () {
                                  // Update the state to toggle password visibility
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    verticalSpace(32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 49),
                      child: ActionButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            var loginCubit = LoginCubit.get(context);
                            loginCubit.loginPlayer(
                              groupNameController.text,
                              passwordController.text,
                            );
                          }
                        },
                        verticalPadding: 16,
                        child: Center(
                          child: Text(
                            'تسجيل الدخول',
                            style: getExtraBoldStyle(
                                fontSize: FontSize.s16,
                                color: AppColors.kWhiteColor),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: TextButton(
                          onPressed: () {
                            var layoutCubit = LayoutCubit.get(context);
                            layoutCubit.changeButtonNavItem(4);
                          },
                          child: Text(
                            "ليس لديك حساب بعد؟",
                            style: getBoldStyle(
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:aqsa_key_game/core/constant/app_constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aqsa_key_game/core/constant/assets_data.dart';
import 'package:aqsa_key_game/core/shared/widgets/action_button.dart';
import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';
import 'package:aqsa_key_game/core/utils/helper/spacing.dart';
import 'package:aqsa_key_game/core/utils/styles/font_manager.dart';
import 'package:aqsa_key_game/core/utils/styles/text_style_manger.dart';
import 'package:aqsa_key_game/features/layout/logic/cubit/layout_cubit.dart';
import 'package:aqsa_key_game/features/admin/register/data/repository/register_repo.dart';
import 'package:aqsa_key_game/features/admin/register/logic/cubit/register_cubit.dart';
import 'package:flutter_svg/svg.dart';

class PlayerRegisterScreen extends StatefulWidget {
  const PlayerRegisterScreen({super.key});

  @override
  PlayerRegisterScreenState createState() => PlayerRegisterScreenState();
}

class PlayerRegisterScreenState extends State<PlayerRegisterScreen> {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isAdminKeyVisible = false;
  String? selectedCategory;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegisterCubit(RegisterRepo()), // Provide RegisterRepo
      child: Scaffold(
        backgroundColor: AppColors.kOffWhiteColor,
        appBar: AppBar(
          toolbarHeight: 120.h, // Responsively scaled height
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              AssetsData.registerBanner,
              fit: BoxFit.fill,
            ),
          ),
        ),
        body: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              // Handle success
              var layoutCubit = LayoutCubit.get(context);
              layoutCubit.changeButtonNavItem(2);
            } else if (state is RegisterErrorState) {
              // Handle error
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is RegisterLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              controller: LayoutCubit.get(context).scrollController,
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(top: 24.h, left: 36.w, right: 36.w),
                      child: Text(
                        "أنشئ حسابًا لبدأ رحلة فريقك في الحصول على مفتاح الأقصى..",
                        style: getBoldStyle(
                          fontSize: FontSize.s14, // Scaled font size
                        ),
                        textAlign: TextAlign.center,
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
                          verticalSpace(8),
                          DropdownButtonFormField<String>(
                            value: selectedCategory,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCategory = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'من فضلك اختر الفئة الخاصة بك';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'الفئة',
                              hintStyle: getRegularStyle(
                                fontSize: FontSize.s16,
                                color: AppColors.kGreyColor,
                              ),
                              filled: true,
                              fillColor: AppColors.kWhiteColor,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 16.h,
                                horizontal: 20.w,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: BorderSide(
                                  color: AppColors.kDarkGreyColor,
                                  width: 1.5.w,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: BorderSide(
                                  color: AppColors.kPrimary1Color,
                                  width: 1.5.w,
                                ),
                              ),
                            ),
                            icon: SvgPicture.asset(
                              AssetsData.expandIcon,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.kGreyColor, BlendMode.srcIn),
                            ),
                            items: AppConstance.categories
                                .map<DropdownMenuItem<String>>(
                                    (String category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Text(category,
                                    style: getRegularStyle(
                                        fontSize: FontSize.s16)),
                              );
                            }).toList(),
                          ),
                          verticalSpace(8),
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
                    verticalSpace(24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 49),
                      child: ActionButton(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              var registerCubit = RegisterCubit.get(context);
                              registerCubit.registerPlayer(
                                groupNameController.text,
                                selectedCategory!,
                                passwordController.text,
                              );
                            }
                          },
                          child: Center(
                            child: Text(
                              "إنشاء حساب",
                              style: getExtraBoldStyle(
                                  fontSize: FontSize.s16,
                                  color: AppColors.kWhiteColor),
                            ),
                          )),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 24.h),
                        child: TextButton(
                          onPressed: () {
                            var layoutCubit = LayoutCubit.get(context);
                            layoutCubit.changeButtonNavItem(2);
                          },
                          child: Text(
                            "هل لديك حساب بالفعل؟",
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

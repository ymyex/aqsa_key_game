import 'package:aqsa_key_game/core/network/local/cache_helper.dart';
import 'package:aqsa_key_game/core/network/remote/dio_helper/dio_helper.dart';
import 'package:aqsa_key_game/core/shared/widgets/bloc_observer.dart';
import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';
import 'package:aqsa_key_game/core/utils/routes/app_router.dart';
import 'package:aqsa_key_game/core/utils/theme/app_theme.dart';
import 'package:aqsa_key_game/features/layout/logic/cubit/layout_cubit.dart';
import 'package:aqsa_key_game/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  DioHelper.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.kWhiteColor,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.kWhiteColor,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LayoutCubit>(
          create: (context) => LayoutCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      enableScaleWH: () => false,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp.router(
          useInheritedMediaQuery: true,
          locale: const Locale('ar'),
          supportedLocales: const [
            Locale('en'), // English
            Locale('ar'), // Arabic
          ],
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          theme: getAppTheme(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}

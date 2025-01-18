import 'package:aqsa_key_game/features/player/games/games_listing/views/games_page.dart';
import 'package:aqsa_key_game/features/admin/login/views/login_player_screen.dart';
import 'package:aqsa_key_game/features/admin/register/views/register_admin_screen.dart';
import 'package:aqsa_key_game/features/admin/register/views/register_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aqsa_key_game/core/network/local/cache_helper.dart';
import 'package:aqsa_key_game/features/layout/logic/cubit/layout_states.dart';
import 'package:aqsa_key_game/features/admin/login/views/login_admin_screen.dart';
import 'package:aqsa_key_game/features/welcome/welcome_screen.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(ClientLayoutInitialState());
  static LayoutCubit get(context) => BlocProvider.of(context);
  ScrollController scrollController = ScrollController();
  bool isLoggedIn = CacheHelper.getData(key: 'id') == null ? false : true;

  int currentButtomNavIndex = CacheHelper.getData(key: 'id') == null ? 0 : 5;
  List<Widget> clientScreens = [
    const WelcomePage(),
    const AdminLoginScreen(),
    const PlayerLoginScreen(),
    const AdminRegisterScreen(),
    const PlayerRegisterScreen(),
    const PlayerGamesPage(),
  ];
  void changeButtonNavItem(int index) {
    currentButtomNavIndex = index;
    emit(ChangeButtomNavItemState());
  }

  void login() {
    isLoggedIn = CacheHelper.getData(key: 'id') == null ? false : true;
    emit(LoginState());
  }

  void logout() {
    CacheHelper.clear();
    isLoggedIn = false;
    emit(LogoutState());
  }
}

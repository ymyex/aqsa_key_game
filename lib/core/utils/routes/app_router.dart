import 'package:aqsa_key_game/features/layout/views/layout_view.dart';
import 'package:aqsa_key_game/features/login/views/login_admin_screen.dart';
import 'package:aqsa_key_game/features/login/views/login_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const String kPlayerLogin = '/AdminLogin';
  static const String kAdminLogin = '/PlayerLogin';

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LayoutView();
        },
      ),
      GoRoute(
        path: kAdminLogin,
        builder: (BuildContext context, GoRouterState state) {
          return const AdminLoginScreen();
        },
      ),
      GoRoute(
        path: kPlayerLogin,
        builder: (BuildContext context, GoRouterState state) {
          return const PlayerLoginScreen();
        },
      ),
    ],
  );
}

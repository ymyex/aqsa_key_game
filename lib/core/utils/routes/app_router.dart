import 'package:aqsa_key_game/features/player/games/games_listing/views/games_page.dart';
import 'package:aqsa_key_game/features/layout/views/layout_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const String kPlayerLogin = '/AdminLogin';
  static const String kAdminLogin = '/PlayerLogin';
  static const String kPlayerGamesPage = '/PlayerGames';

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LayoutView();
        },
      ),
      GoRoute(
        path: kPlayerGamesPage,
        builder: (BuildContext context, GoRouterState state) {
          return const PlayerGamesPage();
        },
      ),
    ],
  );
}

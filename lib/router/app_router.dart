import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/main_shell.dart';
import '../screens/daftar_tugas_screen.dart';
import '../screens/form_tugas_screen.dart';
import '../screens/statistik_screen.dart';
import '../screens/not_found_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  errorBuilder: (context, state) => const NotFoundScreen(),
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const DaftarTugasScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tambah',
              builder: (context, state) => const FormTugasScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/statistik',
              builder: (context, state) => const StatistikScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

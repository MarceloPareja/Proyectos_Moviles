import '../../design_system/layouts/lista_pruebas.dart';
import '../../design_system/layouts/register_page.dart';

import '../../design_system/layouts/cursos_start.dart';
import '../../design_system/layouts/login_screen.dart';
import '../../design_system/layouts/pruebas_start.dart';
import '../../design_system/layouts/lista_estudiantes_layout.dart';
import '../../design_system/components/bottom_bar.dart';
import '../../design_system/layouts/perfil.dart';
import 'package:app_escaneo_pruebas/design_system/providers/profesor_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
GlobalKey<NavigatorState>();

final ProfesorProvider userProvider = ProfesorProvider();


final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  refreshListenable: userProvider,

  redirect: (context, state) {
    final location = state.matchedLocation;

    final isPublicRoute = location == '/login' || location == '/register';

    if (isPublicRoute) {
      return null;
    }

    // Usuario no logueado → forzar login
    /*
    if (!userProvider.isLogged) {
      return '/login';
    }

    if (userProvider.isLogged && location == '/login') {
      return '/home';
    }*/

    return null;
  },

  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: BottomBar(
            key: state.pageKey,
            navigationShell: navigationShell,
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/courses',
              builder: (context, state) => CursosStart(),
              //subrutas o sub-paginas en cursos
              routes: [
                GoRoute(
                  path: 'students',
                  builder: (context, state) => ListaEstudiantesLayout(
                    cursoId: state.extra as int,
                  ),
                ),
                GoRoute(
                  path: 'tests',
                  builder: (context, state) => ListaPruebas(
                    curso_id: state.extra as int,
                  ),
                )
              ]
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tests',
              builder: (context, state) => PruebasStart(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => Perfil(),
            ),
          ],
        )
      ],
    ),
  ],
);
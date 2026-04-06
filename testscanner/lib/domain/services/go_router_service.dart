import 'package:testscanner/design_system/layouts/graded_students.dart';

import '../../design_system/layouts/edit_pregunta_layout.dart';

import '../../design_system/layouts/graded_test_layout.dart';
import '../../design_system/layouts/photo_layout.dart';
import '../../design_system/layouts/preguntas_prueba_layout.dart';

import '../../design_system/layouts/lista_pruebas.dart';
import '../../design_system/layouts/register_page.dart';
import '../../design_system/layouts/crear_prueba.dart';
import '../../design_system/layouts/register_page.dart';

import '../../design_system/layouts/cursos_start.dart';
import '../../design_system/layouts/login_screen.dart';
import '../../design_system/layouts/pruebas_start.dart';
import '../../design_system/layouts/lista_estudiantes_layout.dart';
import '../../design_system/components/molecules/bottom_bar.dart';
import '../../design_system/layouts/perfil.dart';
import '../../design_system/layouts/pruebas_curso_layout.dart';
import '../../design_system/layouts/preguntas_add_layout.dart';
import '../../design_system/providers/profesor_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../entities/pregunta.dart';
import '../entities/prueba_estudiante.dart';

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
    GoRoute(path: "/",
      redirect: (_, __) => "/courses",),
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
                GoRoute(path: ":curso_id",
                    builder: (context, state) => const SizedBox.shrink(),
                  routes: [
                    GoRoute(
                      path: 'students',
                      builder: (context, state) {
                        final curso_id = int.parse(state.pathParameters['curso_id']!);
                        return ListaEstudiantesLayout(curso_id: curso_id);
                      },
                    ),
                    GoRoute(
                        path: 'tests',
                        builder: (context, state) {
                          final curso_id = int.parse(state.pathParameters['curso_id']!);
                          return PruebasCursoLayout(curso_id: curso_id);
                        },
                        routes: [
                          GoRoute(
                              path: "create",
                              builder: (context, state){
                                final curso_id = int.parse(state.pathParameters['curso_id']!);
                                return CrearPrueba(curso: curso_id);
                              }
                          ),
                          GoRoute(
                              path: ":prueba_id",
                              builder: (context, state) => const SizedBox.shrink(),
                              routes: [
                                GoRoute(path: "graded",
                                builder: (context, state)
                                {
                                  final prueba_id = state.pathParameters['prueba_id']!;
                                  final curso_id = int.parse(state.pathParameters['curso_id']!);
                                  return GradedStudents(curso_id: curso_id, prueba_id: prueba_id);
                                },
                                routes:
                                [
                                  GoRoute(path: "check",
                                      builder: (context, state)
                                      {
                                        final prueba_id = state.pathParameters['prueba_id']!;
                                        final curso_id = int.parse(state.pathParameters['curso_id']!);
                                        final testData = state.extra as PruebaEstudiante;
                                        return GradedTestLayout(testData: testData, nrc: curso_id);
                                      })
                                ]),
                                GoRoute(path: "questions/add",
                                    builder: (context, state) {
                                  final prueba_id = state.pathParameters['prueba_id']!;
                                  final curso_id = int.parse(state.pathParameters['curso_id']!);
                                  return PreguntasAddLayout(prueba_id: prueba_id, curso_id: curso_id);
                                }),
                                GoRoute(path: "questions",
                                    builder: (context, state) {
                                      final prueba_id = state.pathParameters['prueba_id']!;
                                      final curso_id = int.parse(state.pathParameters['curso_id']!);
                                      return PreguntasPruebaLayout(prueba_id: prueba_id, curso_id: curso_id);
                                    },
                                  routes: [
                                    GoRoute(path: "/edit/:pregunta_id",
                                        builder: (context, state) {
                                          final prueba_id = state.pathParameters['prueba_id']!;
                                          final curso_id = int.parse(state.pathParameters['curso_id']!);
                                          final pregunta_id = state.pathParameters['pregunta_id']!;
                                          final Pregunta pregunta = state.extra as Pregunta;
                                          return EditPreguntaLayout(prueba_id: prueba_id, pregunta_id: pregunta_id, curso_id: curso_id);
                                        }
                                    )
                                  ]
                                    ),
                              ]

                          )
                  ]
                )
                  ]
                )
              ]
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tests',
              builder: (context, state) => PhotoLayout(),
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
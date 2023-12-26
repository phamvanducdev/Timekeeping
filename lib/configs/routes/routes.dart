import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timekeeping/features/auth/login_screen.dart';
import 'package:timekeeping/features/home/home_screen.dart';

GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomeScreen();
      },
      routes: [
        // Todo
        GoRoute(
          path: 'settings',
          builder: (context, state) {
            return const Text('Settings');
          },
        ),
      ],
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
  ],
);

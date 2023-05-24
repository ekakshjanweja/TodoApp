import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:todo/features/auth/views/login_page.dart';
import 'package:todo/features/home/views/create_todo_page.dart';
import 'package:todo/features/home/views/home_page.dart';

final loggedOutRoute = RouteMap(
  routes: {
    '/': (route) => const MaterialPage(child: LoginPage()),
  },
);

final loggedInRoute = RouteMap(
  routes: {
    '/': (route) => const MaterialPage(child: HomePage()),
    CreateTodoPage.routeName: (route) =>
        const MaterialPage(child: CreateTodoPage()),
  },
);

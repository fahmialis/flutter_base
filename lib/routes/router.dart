import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roll_dice/screens/counter/counter_screen.dart';
import 'package:roll_dice/screens/second/second_screen.dart';
import 'package:roll_dice/widgets/scaffold.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>();

class MainRouter {
  static const root = '/';
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
      initialLocation: '/',
      navigatorKey: globalNavigatorKey,
      errorBuilder: ((context, state) => const MainWrapper(
            child: Center(child: Text('not found')),
          )),
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) => const MainWrapper(
                  child: CounterScreen(
                    title: 'main screeen',
                  ),
                )),
        GoRoute(
            path: '/second',
            builder: (context, state) => const MainWrapper(
                  child: SecondScreen(),
                )),
      ]);
}

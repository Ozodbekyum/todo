import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/add_fetch_todo.dart';
import 'package:todo/providers/auth.dart';
import 'package:todo/screens/auth_screen.dart';
import 'package:todo/screens/overview_screen.dart';
import 'package:todo/screens/splash_screen.dart';

import 'providers/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SharedPrefs(),
        ),
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddFetchTodo(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _splash = true;

  @override
  void initState() {
    Provider.of<SharedPrefs>(context, listen: false).getUser().then((_) {
      Future.delayed(const Duration(seconds: 1)).then((_) {
        setState(() {
          _splash = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: GoRouter(
        errorBuilder: (context, state) => const SplashScreen(),
        initialLocation: '/authScreen',
        redirect: (context, state) {
          if (Provider.of<SharedPrefs>(context, listen: false).isLogin) {
            return '/overviewScreen';
          } else if (_splash) {
            return '/splashScreen';
          } else {
            return null;
          }
        },
        routes: [
          GoRoute(
            path: '/authScreen',
            name: AuthScreen.routeName,
            builder: (context, state) => const AuthScreen(),
          ),
          GoRoute(
            path: '/overviewScreen',
            name: OverviewScreen.routeName,
            builder: (context, state) => OverviewScreen(),
          ),
          GoRoute(
            path: '/splashScreen',
            name: SplashScreen.routeName,
            builder: (context, state) => const SplashScreen(),
          ),
        ],
      ),
    );
  }
}

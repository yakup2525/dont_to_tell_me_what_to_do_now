// app_navigator.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/features.dart';
import '/core/core.dart';

class AppNavigator extends StatefulWidget {
  const AppNavigator({
    super.key,
  });

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  late HeroController _heroControllerAppNavigator;

  @override
  void initState() {
    _heroControllerAppNavigator = HeroController(
      createRectTween: (Rect? begin, Rect? end) {
        return CurvedRectArcTween(begin: begin, end: end);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      observers: [_heroControllerAppNavigator],
      key: NavigationService.instance.navigatorKey,
      initialRoute: AppRoutes.initialRoute.routeName,
      onGenerateRoute: (RouteSettings settings) {
        final AppRoutes route = _getRouteFromName(settings.name);
        switch (route) {
          case AppRoutes.initialRoute:
            return animateToPage(BlocProvider(
              create: (BuildContext context) => LoginCubit(),
              child: const LoginScreen(),
            ));
          case AppRoutes.register:
            return animateToCupertinoPage(BlocProvider(
              create: (BuildContext context) => RegisterCubit(),
              child: const RegisterScreen(),
            ));
          case AppRoutes.resetPassword:
            return animateToCupertinoPage(BlocProvider(
              create: (BuildContext context) => PasswordResetCubit(),
              child: const PasswordresetScreen(),
            ));
          case AppRoutes.home:
            return animateToMaterialPage(const HomeScreen());
          default:
            return animateToPage(const LoginScreen());
        }
      },
    );
  }

  AppRoutes _getRouteFromName(String? name) {
    return AppRoutes.values.firstWhere((e) => e.routeName == name);
  }
}

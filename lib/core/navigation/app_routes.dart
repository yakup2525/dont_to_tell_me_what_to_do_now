// app_routes.dart
enum AppRoutes {
  initialRoute,
  register,
  home,
  resetPassword,
}

extension AppRoutesExtension on AppRoutes {
  String get routeName {
    switch (this) {
      case AppRoutes.initialRoute:
        return '/';
      case AppRoutes.register:
        return '/register';
      case AppRoutes.home:
        return '/home';
      case AppRoutes.resetPassword:
        return '/resetPassword';
      default:
        return '/';
    }
  }
}

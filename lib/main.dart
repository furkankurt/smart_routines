import 'package:flutter/material.dart';
import 'package:smart_routines/app/domain/constants/app_constants.dart';
import 'package:smart_routines/bootstrap.dart';
import 'package:smart_routines/core/injection/injection.dart';
import 'package:smart_routines/core/router/app_router.dart';
import 'package:smart_routines/core/theme/app_theme.dart';

/// The entry point of the app that bootstraps the app and runs the app.
/// The entry point initializes the dependency injection container and runs the
/// app by calling the [bootstrap] function with the [SmartRoutinesApp] widget.
///
/// The [bootstrap] function initializes the app by setting up error handling,
/// initializing dependencies, and running the provided widget builder.
void main() {
  bootstrap(() => const SmartRoutinesApp());
}

/// The main widget of the app that initializes the app and sets up the
/// dependency injection container.
///
/// The widget is a [MaterialApp] widget that uses the [AppRouter] to define
/// the routes of the app.
///
/// It uses the [AppTheme] to define the theme of the app and the
/// [AppConstants] to define the title of the app.
class SmartRoutinesApp extends StatelessWidget {
  const SmartRoutinesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: di.get<AppRouter>().config(),
    );
  }
}

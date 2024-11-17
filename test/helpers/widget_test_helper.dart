import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_routines/core/router/app_router.dart';
import 'package:smart_routines/core/theme/app_theme.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
        home: widget,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
      ),
    );
  }

  Future<void> pumpRouterApp({
    RootStackRouter? router,
    String? initialLink,
    PageRouteInfo? initialRoute,
    NavigatorObserversBuilder observers =
        AutoRouterDelegate.defaultNavigatorObserversBuilder,
  }) async {
    final appRouter = router ?? AppRouter();
    return pumpWidget(
      MaterialApp.router(
        locale: const Locale('en'),
        routeInformationParser: appRouter.defaultRouteParser(),
        routerDelegate: appRouter.delegate(
          deepLinkBuilder: (link) => initialLink != null
              ? DeepLink.path(initialLink)
              : initialRoute != null
                  ? DeepLink.single(initialRoute)
                  : link,
          navigatorObservers: observers,
        ),
      ),
    ).then((_) => pumpAndSettle());
  }
}

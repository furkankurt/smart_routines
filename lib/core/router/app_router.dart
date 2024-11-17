import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_routines/app/presentation/pages/dashboard/page/dashboard_page.dart';
import 'package:smart_routines/app/presentation/pages/routines/page/routines_page.dart';
import 'package:smart_routines/app/presentation/widgets/main_wrapper.dart';

part 'app_router.gr.dart';

/// The main router of the app that defines the routes of the app.
/// The router is created using the [AutoRouterConfig] annotation from the
/// [auto_route](https://pub.dev/packages/auto_route) package. This annotation
/// tells the auto_route package to generate the router based on the routes
/// defined in the [routes] getter.
///
/// The router extends the [RootStackRouter] class from the auto_route package.
/// The [RootStackRouter] class is a router
///
/// The router defines the following routes:
/// - [MainWrapperRoute]: The main wrapper route that contains the dashboard and
///  routines pages.
/// - [DashboardRoute]: The dashboard page that displays the smart models.
/// - [RoutinesRoute]: The routines page that displays the routines.
///
/// The router is created using the [singleton] annotation from the
/// [injectable](https://pub.dev/packages/injectable) package. This annotation
/// tells the dependency injection container to create a single instance of the
/// router and to reuse that instance whenever it is needed.
@singleton
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MainWrapperRoute.page,
          initial: true,
          children: [
            AutoRoute(
              path: 'dashboard',
              page: DashboardRoute.page,
            ),
            AutoRoute(
              path: 'routines',
              page: RoutinesRoute.page,
            ),
          ],
        ),
      ];
}

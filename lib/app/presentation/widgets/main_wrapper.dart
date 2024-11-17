import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smart_routines/app/domain/constants/app_constants.dart';
import 'package:smart_routines/core/router/app_router.dart';

class RouteDestination {
  const RouteDestination({
    required this.route,
    required this.icon,
    required this.label,
  });

  final PageRouteInfo<dynamic> route;
  final IconData icon;
  final String label;
}

/// A wrapper page that displays the main content of the app and the
/// navigation bar. The navigation bar is displayed at the bottom of the
/// screen on mobile devices and on the left side of the screen on larger
/// devices.
///
/// The navigation bar contains the destinations that the user can navigate
/// to. The user can select a destination by tapping on the icon or label
/// of the destination. When a destination is selected, the app will navigate
/// to the corresponding route.
@RoutePage()
class MainWrapperPage extends StatelessWidget {
  const MainWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(_destinations()[tabsRouter.activeIndex].label),
                  centerTitle: true,
                ),
                body: child,
                bottomNavigationBar: NavigationBar(
                  selectedIndex: tabsRouter.activeIndex,
                  onDestinationSelected: tabsRouter.setActiveIndex,
                  destinations: _destinations()
                      .map(
                        (e) => NavigationDestination(
                          icon: Icon(e.icon),
                          label: e.label,
                        ),
                      )
                      .toList(),
                ),
              );
            }
            return Scaffold(
              extendBody: true,
              body: Row(
                children: [
                  NavigationRail(
                    selectedIndex: tabsRouter.activeIndex,
                    labelType: NavigationRailLabelType.none,
                    leading: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        AppConstants.appName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    destinations: _destinations()
                        .map(
                          (destination) => NavigationRailDestination(
                            icon: Icon(destination.icon),
                            label: Text(destination.label),
                          ),
                        )
                        .toList(),
                    onDestinationSelected: tabsRouter.setActiveIndex,
                  ),
                  const VerticalDivider(thickness: 1, width: 1),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: child,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<RouteDestination> _destinations() => [
        const RouteDestination(
          route: DashboardRoute(),
          icon: Icons.dashboard,
          label: 'Dashboard',
        ),
        const RouteDestination(
          route: DashboardRoute(),
          icon: Icons.schema_outlined,
          label: 'Routines',
        ),
      ];
}

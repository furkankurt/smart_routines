import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';
import 'package:smart_routines/app/presentation/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:smart_routines/core/injection/injection.dart';

import '../../../fixtures/json_fixtures.dart';
import '../../../helpers/widget_test_helper.dart';

class MockDashboardCubit extends MockCubit<DashboardState>
    implements DashboardCubit {}

void main() {
  late MockDashboardCubit mockDashboardCubit;
  final mockSmartModel = SmartModel.fromJson(smartModelJson);

  setUp(() {
    mockDashboardCubit = MockDashboardCubit();
    di.allowReassignment = true;
    di.registerFactory<DashboardCubit>(() => mockDashboardCubit);

    when(() => mockDashboardCubit.state)
        .thenReturn(DashboardState.loaded([mockSmartModel]));
  });

  testWidgets('MainWrapperPage displays bottom navigation bar on small screens',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 600);

    await tester.pumpRouterApp(
      initialLink: '/',
    );

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);

    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });

  testWidgets('MainWrapperPage displays navigation rail on large screens',
      (WidgetTester tester) async {
    final dpi = tester.view.devicePixelRatio;
    tester.view.physicalSize = Size(600 * dpi, 800 * dpi);

    await tester.pumpRouterApp(
      initialLink: '/',
    );

    expect(find.byType(NavigationBar), findsNothing);
    expect(find.byType(NavigationRail), findsOneWidget);

    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}

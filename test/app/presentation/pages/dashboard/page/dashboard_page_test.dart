import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';
import 'package:smart_routines/app/presentation/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:smart_routines/app/presentation/pages/dashboard/page/dashboard_page.dart';
import 'package:smart_routines/core/injection/injection.dart';

import '../../../../../fixtures/json_fixtures.dart';
import '../../../../../helpers/widget_test_helper.dart';

class MockDashboardCubit extends MockCubit<DashboardState>
    implements DashboardCubit {}

void main() {
  late MockDashboardCubit mockDashboardCubit;
  final mockSmartModel = SmartModel.fromJson(smartModelJson);

  setUp(() {
    mockDashboardCubit = MockDashboardCubit();
    di.allowReassignment = true;
    di.registerFactory<DashboardCubit>(() => mockDashboardCubit);

    registerFallbackValue(mockSmartModel);
  });

  testWidgets('renders loading indicator when state is initial',
      (tester) async {
    when(() => mockDashboardCubit.state)
        .thenReturn(const DashboardState.initial());

    await tester.pumpApp(const DashboardPage());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders loading indicator when state is loading',
      (tester) async {
    when(() => mockDashboardCubit.state)
        .thenReturn(const DashboardState.loading());

    await tester.pumpApp(const DashboardPage());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders smart models when state is loaded', (tester) async {
    final smartModels = [
      SmartModel(id: '1', name: 'Device 1', type: ModelType.device),
      SmartModel(id: '2', name: 'Service 1', type: ModelType.service),
    ];
    when(() => mockDashboardCubit.state)
        .thenReturn(DashboardState.loaded(smartModels));

    await tester.pumpApp(const DashboardPage());

    expect(find.text('Devices'), findsOneWidget);
    expect(find.text('Device 1'), findsOneWidget);
    expect(find.text('Services'), findsOneWidget);
    expect(find.text('Service 1'), findsOneWidget);
  });

  testWidgets('calls addOrUpdateModel when a power property is changed',
      (tester) async {
    when(() => mockDashboardCubit.state).thenReturn(
      DashboardState.loaded([mockSmartModel]),
    );

    when(() => mockDashboardCubit.addOrUpdateModel(any()))
        .thenAnswer((_) async {});

    await tester.pumpApp(const DashboardPage());
    await tester.pumpAndSettle();

    final smartModelWidget = find.text('Off');

    await tester.tap(smartModelWidget);
    await tester.pumpAndSettle();

    verify(() => mockDashboardCubit.addOrUpdateModel(any())).called(1);
  });

  testWidgets('should show details when a smart model is tapped',
      (tester) async {
    when(() => mockDashboardCubit.state).thenReturn(
      DashboardState.loaded([mockSmartModel]),
    );

    await tester.pumpApp(const DashboardPage());
    await tester.pumpAndSettle();

    final smartModelWidget = find.text(mockSmartModel.name);

    await tester.tap(smartModelWidget);
    await tester.pumpAndSettle();

    expect(find.text('Power'), findsOneWidget);
  });

  testWidgets('should update model property on model details modal',
      (tester) async {
    when(() => mockDashboardCubit.state).thenReturn(
      DashboardState.loaded([mockSmartModel]),
    );

    when(() => mockDashboardCubit.addOrUpdateModel(any()))
        .thenAnswer((_) async {});

    await tester.pumpApp(const DashboardPage());
    await tester.pumpAndSettle();

    final smartModelWidget = find.text(mockSmartModel.name);

    await tester.tap(smartModelWidget);
    await tester.pumpAndSettle();

    final powerSwitch = find.text('Power');

    await tester.tap(powerSwitch);
    await tester.pumpAndSettle();

    final updateButton = find.text('Update Model');

    await tester.tap(updateButton);
    await tester.pumpAndSettle();

    verify(() => mockDashboardCubit.addOrUpdateModel(any())).called(1);
  });
}

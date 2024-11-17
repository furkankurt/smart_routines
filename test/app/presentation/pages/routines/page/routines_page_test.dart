import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_routines/app/data/models/routine/routine.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';
import 'package:smart_routines/app/presentation/pages/routines/routines.dart';
import 'package:smart_routines/app/presentation/pages/routines/widgets/routine_widget.dart';
import 'package:smart_routines/core/injection/injection.dart';

import '../../../../../fixtures/json_fixtures.dart';
import '../../../../../helpers/widget_test_helper.dart';

class MockRoutinesCubit extends MockCubit<RoutinesState>
    implements RoutinesCubit {}

void main() {
  late MockRoutinesCubit mockRoutinesCubit;
  final mockSmartModel = SmartModel.fromJson(smartModelJson);
  final mockAlarmService = SmartModel.fromJson(alarmServiceJson);
  final mockRoutine = Routine.fromJson(routineJson);

  setUp(() {
    mockRoutinesCubit = MockRoutinesCubit();
    di.allowReassignment = true;
    di.registerFactory<RoutinesCubit>(() => mockRoutinesCubit);

    registerFallbackValue(mockRoutine);
    registerFallbackValue(mockSmartModel);
  });

  testWidgets('RoutinesPage displays loading indicator when state is initial',
      (tester) async {
    when(() => mockRoutinesCubit.state)
        .thenReturn(const RoutinesState.initial());

    await tester.pumpApp(const RoutinesPage());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('RoutinesPage displays loading indicator when state is loading',
      (tester) async {
    when(() => mockRoutinesCubit.state)
        .thenReturn(const RoutinesState.loading());

    await tester.pumpApp(const RoutinesPage());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('RoutinesPage displays routines when state is loaded',
      (tester) async {
    final routines = [mockRoutine];
    final smartModels = [mockSmartModel];

    when(() => mockRoutinesCubit.state)
        .thenReturn(RoutinesState.loaded(routines, smartModels));

    await tester.pumpApp(const RoutinesPage());

    expect(find.byType(RoutineWidget), findsNWidgets(routines.length));
  });

  testWidgets(
      'RoutinesPage displays empty list when state is loaded with no routines',
      (tester) async {
    when(() => mockRoutinesCubit.state)
        .thenReturn(const RoutinesState.loaded([], []));

    await tester.pumpApp(const RoutinesPage());

    expect(find.byType(RoutineWidget), findsNothing);
  });

  testWidgets(
      'should show add routine modal when '
      'FloatingActionButton tapped and state is loading', (tester) async {
    when(() => mockRoutinesCubit.state)
        .thenReturn(const RoutinesState.loading());

    await tester.pumpApp(const RoutinesPage());
    await tester.pump();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    final routineDetailsWidget = find.text('Add Routine');

    expect(routineDetailsWidget, findsOneWidget);
  });

  testWidgets(
      'should show add routine modal when '
      'FloatingActionButton tapped and state is loaded', (tester) async {
    when(() => mockRoutinesCubit.state)
        .thenReturn(RoutinesState.loaded([], [mockSmartModel]));

    await tester.pumpApp(const RoutinesPage());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    final routineDetailsWidget = find.text('Add Routine');

    expect(routineDetailsWidget, findsOneWidget);
  });

  testWidgets(
      'should add routine when RoutineDetailsWidget returns a new routine',
      (tester) async {
    when(() => mockRoutinesCubit.state)
        .thenReturn(RoutinesState.loaded([], [mockSmartModel]));

    when(() => mockRoutinesCubit.addOrUpdateRoutine(any()))
        .thenAnswer((_) async {});

    await tester.pumpApp(const RoutinesPage());
    await tester.pumpAndSettle();

    /// Opens the Add Routine modal
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    final routineDetailsWidget = find.text('Add Routine');

    expect(routineDetailsWidget, findsOneWidget);

    /// Fills the Routine Name field
    final routineNameFinder = find.widgetWithText(TextField, 'Routine Name');
    await tester.enterText(routineNameFinder, 'New Routine');
    await tester.pumpAndSettle();

    /// Changes the Routine State to Active
    final routineStateFinder = find.text('Routine state');
    await tester.tap(routineStateFinder);
    await tester.pumpAndSettle();

    /// Opens the Trigger Settings modal
    final triggerButtonFinder = find.text('Click here to set trigger');
    await tester.tap(triggerButtonFinder);
    await tester.pumpAndSettle();
    expect(find.text('Trigger Settings'), findsOneWidget);

    /// Selects the Smart Model dropdown
    final modelSelectFinder = find.text('Smart Model');
    await tester.tap(modelSelectFinder);
    await tester.pumpAndSettle();

    /// Selects the Smart Model
    final modelNameFinder = find.text(mockSmartModel.name);
    await tester.tap(modelNameFinder);
    await tester.pumpAndSettle();

    /// Selects the Property dropdown
    final propertySelectFinder = find.text('Property');
    expect(propertySelectFinder, findsOneWidget);
    await tester.tap(propertySelectFinder);
    await tester.pumpAndSettle();

    /// Selects the Property
    final propertyNameFinder = find.text('Brightness');
    await tester.tap(propertyNameFinder);
    await tester.pumpAndSettle();

    /// Selects the Condition dropdown
    final conditionSelectFinder = find.text('Condition');
    expect(conditionSelectFinder, findsOneWidget);
    await tester.tap(conditionSelectFinder);
    await tester.pumpAndSettle();

    /// Selects the Condition
    final conditionNameFinder = find.text('Equals');
    await tester.tap(conditionNameFinder);
    await tester.pumpAndSettle();

    /// Fills the Value field
    final valueFinder = find.widgetWithText(TextField, 'Brightness');
    await tester.enterText(valueFinder, '50');
    await tester.pumpAndSettle();

    /// Saves the Trigger Settings
    final saveButtonFinder = find.text('Save Trigger');
    await tester.tap(saveButtonFinder);
    await tester.pumpAndSettle();

    /// Checks if the trigger description is correct
    final triggerDescriptionFinder =
        find.text('When "Bedroom Light" brightness equals 50');
    expect(triggerDescriptionFinder, findsOneWidget);

    /// Opens the Action Settings modal
    final actionButtonFinder = find.text('Add Action');
    await tester.tap(actionButtonFinder);
    await tester.pumpAndSettle();

    /// Selects the Smart Model dropdown
    final actionModelSelectFinder = find.text('Smart Model');
    await tester.tap(actionModelSelectFinder);
    await tester.pumpAndSettle();

    /// Selects the Smart Model
    final actionModelNameFinder = find.text(mockSmartModel.name);
    await tester.tap(actionModelNameFinder);
    await tester.pumpAndSettle();

    /// Selects the Property dropdown
    final actionPropertySelectFinder = find.text('Property');
    expect(actionPropertySelectFinder, findsOneWidget);
    await tester.tap(actionPropertySelectFinder);
    await tester.pumpAndSettle();

    /// Selects the Property
    final actionPropertyNameFinder = find.text('Power');
    await tester.tap(actionPropertyNameFinder);
    await tester.pumpAndSettle();

    /// Switches the Power state
    final actionValueFinder = find.text('Power state of the light');
    await tester.tap(actionValueFinder);
    await tester.pumpAndSettle();

    /// Saves the Action Settings
    final actionSaveButtonFinder = find.text('Save Action');
    await tester.tap(actionSaveButtonFinder);
    await tester.pumpAndSettle();

    /// Checks if the action description is correct
    final actionDescriptionFinder =
        find.text('1: Set "Bedroom Light" power to On');
    expect(actionDescriptionFinder, findsOneWidget);
    final actionSettingsFinder = find.text('Action Settings');
    expect(actionSettingsFinder, findsNothing);

    /// Saves the Routine
    final scrollable = find.byType(Scrollable).last;
    final saveRoutineButtonFinder = find.widgetWithText(FilledButton, 'Save');
    await tester.scrollUntilVisible(
      saveRoutineButtonFinder,
      100,
      scrollable: scrollable,
    );
    await tester.pump();
    await tester.tap(saveRoutineButtonFinder);
    await tester.pumpAndSettle();

    verify(() => mockRoutinesCubit.addOrUpdateRoutine(any())).called(1);
  });

  testWidgets('should show routine details modal when RoutineWidget tapped',
      (tester) async {
    when(() => mockRoutinesCubit.state).thenReturn(
      RoutinesState.loaded(
        [mockRoutine],
        [mockSmartModel, mockAlarmService],
      ),
    );

    await tester.pumpApp(const RoutinesPage());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(RoutineWidget).first);
    await tester.pumpAndSettle();

    final routineDetailsWidget = find.text('${mockRoutine.name} Routine');

    expect(routineDetailsWidget, findsOneWidget);
  });

  testWidgets('should change routine state when RoutineWidget switch tapped',
      (tester) async {
    when(() => mockRoutinesCubit.state).thenReturn(
      RoutinesState.loaded(
        [mockRoutine],
        [mockSmartModel, mockAlarmService],
      ),
    );

    when(() => mockRoutinesCubit.addOrUpdateRoutine(any()))
        .thenAnswer((_) async {});

    await tester.pumpApp(const RoutinesPage());
    await tester.pumpAndSettle();

    final routineSwitchFinder = find.byType(SwitchListTile);
    await tester.tap(routineSwitchFinder);
    await tester.pumpAndSettle();

    verify(() => mockRoutinesCubit.addOrUpdateRoutine(any())).called(1);
  });

  testWidgets(
      'should change routine name when '
      'RoutineWidget tapped and routine edited', (tester) async {
    when(() => mockRoutinesCubit.state).thenReturn(
      RoutinesState.loaded(
        [mockRoutine],
        [mockSmartModel, mockAlarmService],
      ),
    );

    when(() => mockRoutinesCubit.addOrUpdateRoutine(any()))
        .thenAnswer((_) async {});

    await tester.pumpApp(const RoutinesPage());
    await tester.pumpAndSettle();

    final routineWidgetFinder = find.byType(RoutineWidget).first;
    await tester.tap(routineWidgetFinder);
    await tester.pumpAndSettle();

    final routineNameFinder = find.widgetWithText(TextField, mockRoutine.name);
    await tester.enterText(routineNameFinder, 'New Routine Name');
    await tester.pumpAndSettle();

    final scrollable = find.byType(Scrollable).last;
    final saveRoutineButtonFinder = find.widgetWithText(FilledButton, 'Save');
    await tester.scrollUntilVisible(
      saveRoutineButtonFinder,
      100,
      scrollable: scrollable,
    );
    await tester.pump();
    await tester.tap(saveRoutineButtonFinder);
    await tester.pumpAndSettle();

    verify(() => mockRoutinesCubit.addOrUpdateRoutine(any())).called(1);
  });

  testWidgets('should delete routine when RoutineWidget delete tapped',
      (tester) async {
    when(() => mockRoutinesCubit.state).thenReturn(
      RoutinesState.loaded(
        [mockRoutine],
        [mockSmartModel, mockAlarmService],
      ),
    );

    when(() => mockRoutinesCubit.deleteRoutine(any())).thenAnswer((_) async {});

    await tester.pumpApp(const RoutinesPage());
    await tester.pumpAndSettle();

    final routineWidgetFinder = find.byType(RoutineWidget).first;
    await tester.tap(routineWidgetFinder);
    await tester.pumpAndSettle();

    final deleteButtonFinder = find.byIcon(Icons.delete).first;
    await tester.tap(deleteButtonFinder);
    await tester.pumpAndSettle();

    verify(() => mockRoutinesCubit.deleteRoutine(any())).called(1);
  });
}

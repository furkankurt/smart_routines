import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';
import 'package:smart_routines/app/data/services/routine_service.dart';
import 'package:smart_routines/app/presentation/pages/dashboard/cubit/dashboard_cubit.dart';

import '../../../../../fixtures/json_fixtures.dart';

class MockRoutineService extends Mock implements RoutineService {}

void main() {
  late DashboardCubit dashboardCubit;
  late MockRoutineService mockRoutineService;
  final mockSmartModel = SmartModel.fromJson(smartModelJson);

  setUp(() {
    mockRoutineService = MockRoutineService();
    dashboardCubit = DashboardCubit(mockRoutineService);
  });

  tearDown(() {
    dashboardCubit.close();
  });

  group('DashboardCubit', () {
    test('initial state is DashboardState.initial', () {
      expect(dashboardCubit.state, equals(const DashboardState.initial()));
    });

    blocTest<DashboardCubit, DashboardState>(
      'emits [loading, loaded] when load is called',
      build: () {
        when(() => mockRoutineService.smartModelsStream).thenAnswer(
          (_) => Stream.value({mockSmartModel.id: mockSmartModel}),
        );

        return dashboardCubit;
      },
      act: (cubit) => cubit.load(),
      expect: () => [
        const DashboardState.loading(),
        DashboardState.loaded([mockSmartModel]),
      ],
    );

    blocTest<DashboardCubit, DashboardState>(
      'calls addOrUpdateSmartModel on RoutineService '
      'when addOrUpdateModel is called',
      build: () {
        registerFallbackValue(mockSmartModel);
        when(() => mockRoutineService.addOrUpdateSmartModel(any()))
            .thenAnswer((_) async {});
        return dashboardCubit;
      },
      act: (cubit) async {
        await cubit.addOrUpdateModel(mockSmartModel.copyWith(id: 'new-id'));
      },
      verify: (_) {
        verify(
          () => mockRoutineService.addOrUpdateSmartModel(any()),
        ).called(1);
      },
    );
  });
}

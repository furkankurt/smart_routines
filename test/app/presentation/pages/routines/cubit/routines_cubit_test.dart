import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_routines/app/data/models/routine/routine.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';
import 'package:smart_routines/app/data/services/routine_service.dart';
import 'package:smart_routines/app/presentation/pages/routines/cubit/routines_cubit.dart';

import '../../../../../fixtures/json_fixtures.dart';

class MockRoutineService extends Mock implements RoutineService {}

void main() {
  late RoutinesCubit routinesCubit;
  late MockRoutineService mockRoutineService;
  final mockSmartModel = SmartModel.fromJson(smartModelJson);
  final mockRoutine = Routine.fromJson(routineJson);

  setUp(() {
    mockRoutineService = MockRoutineService();
    routinesCubit = RoutinesCubit(mockRoutineService);

    registerFallbackValue(mockRoutine);
    registerFallbackValue(mockSmartModel);
  });

  tearDown(() {
    routinesCubit.close();
  });

  group('RoutinesCubit', () {
    test('initial state is RoutinesState.initial', () {
      expect(routinesCubit.state, equals(const RoutinesState.initial()));
    });

    blocTest<RoutinesCubit, RoutinesState>(
      'emits [loading, loaded] when load is called',
      build: () {
        when(() => mockRoutineService.routinesStream)
            .thenAnswer((_) => Stream.value({mockRoutine.id: mockRoutine}));
        when(() => mockRoutineService.smartModelsStream).thenAnswer(
          (_) => Stream.value({mockSmartModel.id: mockSmartModel}),
        );
        return routinesCubit;
      },
      act: (cubit) => cubit.load(),
      expect: () => [
        const RoutinesState.loading(),
        RoutinesState.loaded([mockRoutine], [mockSmartModel]),
      ],
    );

    blocTest<RoutinesCubit, RoutinesState>(
      'calls addOrUpdateRoutine on RoutineService '
      'when addOrUpdateRoutine is called',
      build: () {
        when(() => mockRoutineService.addOrUpdateRoutine(any()))
            .thenAnswer((_) async {});
        return routinesCubit;
      },
      act: (cubit) => cubit.addOrUpdateRoutine(mockRoutine.copyWith(id: '1')),
      verify: (_) {
        verify(() => mockRoutineService.addOrUpdateRoutine(any())).called(1);
      },
    );

    test('getSmartModel returns SmartModel from RoutineService', () {
      when(() => mockRoutineService.getSmartModel(any()))
          .thenReturn(mockSmartModel);

      final result = routinesCubit.getSmartModel(mockSmartModel.id);

      expect(result, equals(mockSmartModel));
    });

    blocTest<RoutinesCubit, RoutinesState>(
      'calls deleteRoutine on RoutineService when deleteRoutine is called',
      build: () {
        when(() => mockRoutineService.deleteRoutine(any()))
            .thenAnswer((_) async {});
        return routinesCubit;
      },
      act: (cubit) => cubit.deleteRoutine(mockRoutine),
      verify: (_) {
        verify(() => mockRoutineService.deleteRoutine(any())).called(1);
      },
    );
  });
}

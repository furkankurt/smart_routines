part of 'routines_cubit.dart';

@freezed
class RoutinesState with _$RoutinesState {
  const factory RoutinesState.initial() = _Initial;
  const factory RoutinesState.loading() = _Loading;
  const factory RoutinesState.loaded(
    List<Routine> routines,
    List<SmartModel> smartModels,
  ) = _Loaded;
}

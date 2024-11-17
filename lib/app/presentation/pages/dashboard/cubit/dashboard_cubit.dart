import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';
import 'package:smart_routines/app/data/services/routine_service.dart';

part 'dashboard_cubit.freezed.dart';
part 'dashboard_state.dart';

/// [DashboardCubit] is a [Cubit] that manages the state of the dashboard page.
/// It is responsible for loading the smart models from the database and
/// updating the state of the dashboard page.
///
/// The cubit listens to changes in the smart models stream and emits the
/// corresponding states to the UI. It also provides a method to add or update
/// a smart model in the database.
///
/// The cubit is created using the [LazySingleton] annotation from the
/// [injectable](https://pub.dev/packages/injectable) package. This annotation
/// tells the dependency injection container to create a single instance of
/// the cubit and to reuse that instance whenever it is needed.
@lazySingleton
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this._routineService) : super(const DashboardState.initial());

  final RoutineService _routineService;

  void load() {
    emit(const DashboardState.loading());

    _routineService.smartModelsStream.listen((smartModels) {
      emit(DashboardState.loaded(smartModels.values.toList()));
    });
  }

  Future<void> addOrUpdateModel(SmartModel model) async {
    await _routineService.addOrUpdateSmartModel(model);
  }
}

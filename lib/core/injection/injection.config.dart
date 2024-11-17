// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:drift/drift.dart' as _i500;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:smart_routines/app/data/database/app_database.dart' as _i659;
import 'package:smart_routines/app/data/repositories/smart_model_repository_impl.dart'
    as _i638;
import 'package:smart_routines/app/data/services/routine_service.dart' as _i356;
import 'package:smart_routines/app/domain/repositories/smart_model_repository.dart'
    as _i840;
import 'package:smart_routines/app/presentation/pages/dashboard/cubit/dashboard_cubit.dart'
    as _i6;
import 'package:smart_routines/app/presentation/pages/routines/cubit/routines_cubit.dart'
    as _i414;
import 'package:smart_routines/core/router/app_router.dart' as _i239;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final lazyDatabaseInjectionModule = _$LazyDatabaseInjectionModule();
    gh.singleton<_i239.AppRouter>(() => _i239.AppRouter());
    gh.lazySingleton<_i500.QueryExecutor>(
        () => lazyDatabaseInjectionModule.openConnection());
    gh.lazySingleton<_i659.AppDatabase>(
        () => _i659.AppDatabase(gh<_i500.QueryExecutor>()));
    gh.lazySingleton<_i840.SmartModelRepository>(
      () => _i638.SmartModelRepositoryImpl(gh<_i659.AppDatabase>()),
      dispose: (i) => i.dispose(),
    );
    await gh.lazySingletonAsync<_i356.RoutineService>(
      () {
        final i = _i356.RoutineService(gh<_i840.SmartModelRepository>());
        return i.initializeData().then((_) => i);
      },
      preResolve: true,
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i6.DashboardCubit>(
        () => _i6.DashboardCubit(gh<_i356.RoutineService>()));
    gh.lazySingleton<_i414.RoutinesCubit>(
        () => _i414.RoutinesCubit(gh<_i356.RoutineService>()));
    return this;
  }
}

class _$LazyDatabaseInjectionModule extends _i659.LazyDatabaseInjectionModule {}

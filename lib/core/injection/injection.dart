// coverage:ignore-file
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_routines/core/injection/injection.config.dart';

final di = GetIt.instance;

/// [configureDependencies] is a function that initializes the dependency
/// injection container and registers all the dependencies in the application.
///
/// The function is annotated with the [InjectableInit] annotation from the
/// [injectable](https://pub.dev/packages/injectable) package. This annotation
/// tells the dependency injection container to run the function when the
/// application is initialized.
@InjectableInit()
Future<void> configureDependencies() async {
  await di.init();
  await di.allReady();
}

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_routines/app/data/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDownAll(() async {
    await db.close();
  });

  group('AppDatabase', () {
    test('should seed the db with given fixtures', () async {
      final smartModels = await db.select(db.smartModels).get();
      final modelProperties = await db.select(db.modelProperties).get();
      final routines = await db.select(db.routines).get();

      expect(smartModels.length, 7);
      expect(modelProperties.length, 10);
      expect(routines.length, 2);
    });

    test('should return the correct schema version', () {
      expect(db.schemaVersion, 1);
    });
  });
}

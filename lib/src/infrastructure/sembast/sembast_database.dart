import 'package:path/path.dart' as path;
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastDatabase {
  late Database _instance;
  Database get instance => _instance;
  late final String dbPath;

  static final airportStore = stringMapStoreFactory.store('airports');
  static final runwayStore = stringMapStoreFactory.store('runways');
  static final navAidStore = stringMapStoreFactory.store('navAids');
  static final mainStore = StoreRef<String, String>.main();

  static final _$true = true.toString();

  static const _kAirportsLoaded = 'airports_loaded';
  static Future<bool> airportsLoaded(DatabaseClient db) async {
    return mainStore
        .record(_kAirportsLoaded)
        .get(db)
        .then((value) => value == _$true);
  }

  static void setAirportsLoaded(bool value, DatabaseClient db) {
    mainStore.record(_kAirportsLoaded).put(db, value.toString());
  }

  static const _kRunwaysLoaded = 'runways_loaded';
  static Future<bool> runwaysLoaded(DatabaseClient db) async {
    return mainStore
        .record(_kRunwaysLoaded)
        .get(db)
        .then((value) => value == _$true);
  }

  static void setRunwaysLoaded(bool value, DatabaseClient db) {
    mainStore.record(_kRunwaysLoaded).put(db, value.toString());
  }

  static const _kNavAidsLoaded = 'navAids_loaded';
  static Future<bool> navAidsLoaded(DatabaseClient db) async {
    return mainStore
        .record(_kNavAidsLoaded)
        .get(db)
        .then((value) => value == _$true);
  }

  static void setNavAidsLoaded(bool value, DatabaseClient db) {
    mainStore.record(_kNavAidsLoaded).put(db, value.toString());
  }

  bool _isInitialized = false;

  Future<void> init(String dbDirectory) async {
    if (_isInitialized) return;

    _isInitialized = true;

    dbPath = path.join(dbDirectory, 'db.sembast');
    _instance = await databaseFactoryIo.openDatabase(dbPath);
  }
}

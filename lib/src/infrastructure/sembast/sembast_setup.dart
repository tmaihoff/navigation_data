// ignore_for_file: avoid_classes_with_only_static_members

import 'package:aviation_entities/airport.dart';
import 'package:aviation_entities/nav_aid.dart';
import 'package:aviation_entities/runway.dart';
import 'package:get_it/get_it.dart';
import 'package:navigation_data/src/domain/airport/airport_repository.dart';
import 'package:navigation_data/src/domain/airport/airport_search_service.dart';
import 'package:navigation_data/src/infrastructure/sembast/sembast_airport_repository.dart';
import 'package:navigation_data/src/infrastructure/sembast/sembast_database.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_dart/shared_dart.dart';

class SembastSetup {
  static final database = SembastDatabase();
  static final db = database.instance;

  static Future<void> invalidateData() async {
    SembastDatabase.setAirportsLoaded(false, db);
    SembastDatabase.setRunwaysLoaded(false, db);
    SembastDatabase.setNavAidsLoaded(false, db);
    logger.i('sembast data invalidated');
  }

  static Future<void> initialize(
    String dbDirectory, {
    required List<Airport> airports,
    required List<RunwaySet> runways,
    required List<NavAid> navAids,
  }) async {
    logger.i('initializing sembast database');

    await database.init(dbDirectory);

    if (!await SembastDatabase.airportsLoaded(db)) {
      await _loadToSembast(
        db,
        SembastDatabase.airportStore,
        airports.map((a) => a.toJson()),
      );
      SembastDatabase.setAirportsLoaded(true, db);
    }

    if (!await SembastDatabase.runwaysLoaded(db)) {
      await _loadToSembast(
        db,
        SembastDatabase.runwayStore,
        runways.map((r) => r.toJson()),
      );
      SembastDatabase.setRunwaysLoaded(true, db);
    }

    if (!await SembastDatabase.navAidsLoaded(db)) {
      await _loadToSembast(
        db,
        SembastDatabase.navAidStore,
        navAids.map((n) => n.toJson()),
      );
      SembastDatabase.setNavAidsLoaded(true, db);
    }

    logger.i('registering repositories and services');

    _registerSembastRepositories(db);
    _registerAirportSearchService();

    logger.i('sembast initialization complete');
  }
}

Future<void> _loadToSembast(
    DatabaseClient db, StoreRef store, Iterable<dynamic> values) async {
  logger.i('writing ${values.length} objects to sembast store ${store.name}');
  store.delete(db);
  await store.addAll(db, values.toList());
}

void _registerSembastRepositories(DatabaseClient db) {
  final airportRepository = SembastAirportRepository(db);
  GetIt.instance.registerSingleton<AirportRepository>(airportRepository);
}

void _registerAirportSearchService() {
  GetIt.instance.registerSingleton<AirportSearchService>(
    AirportSearchService(
      GetIt.I.get<AirportRepository>(),
    ),
  );
}

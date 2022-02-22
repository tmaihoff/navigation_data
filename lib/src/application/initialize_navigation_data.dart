// ignore_for_file: avoid_classes_with_only_static_members

import 'package:aviation_entities/airport.dart';
import 'package:aviation_entities/nav_aid.dart';
import 'package:aviation_entities/runway.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:navigation_data/src/infrastructure/in_memory_repository/in_memory_setup.dart';

class NavigationData {
  static const kDataPath = 'packages/navigation_data/data/';
  static const kAirportsFileName = 'airports_json';
  static const kRunwaysFileName = 'runways_json';
  static const kNavAidsFileName = 'navaids_json';

  static Future<void> initialize({
    required bool isWeb,
    required String dbDirectory,
  }) async {
    final airports = await _loadAirportsFromFile();
    final runways = await _loadRunwaysFromFile();
    final navAids = await _loadNavAidsFromFile();

    if (isWeb) {
      await InMemorySetup.initialize(
        airports: airports,
        runways: runways,
        navAids: navAids,
      );
    } else {
      await InMemorySetup.initialize(
        airports: airports,
        runways: runways,
        navAids: navAids,
      );
      // await SembastSetup.initialize(
      //   dbDirectory,
      //   airports: airports,
      //   runways: runways,
      //   navAids: navAids,
      // );
    }
  }

  static Future<void> invalidateData(bool isWeb) async {
    if (isWeb) {
      // no action
    } else {
      // SembastSetup.invalidateData();
    }
  }

  // TODO: Test these methods
  static Future<List<Airport>> _loadAirportsFromFile() async {
    final jsonString = await rootBundle.loadString(
      '$kDataPath$kAirportsFileName',
      cache: false,
    );

    return compute(Airport.listFromJsonString, jsonString);
  }

  static Future<List<RunwaySet>> _loadRunwaysFromFile() async {
    final jsonString = await rootBundle.loadString(
      '$kDataPath$kRunwaysFileName',
      cache: false,
    );

    return compute(RunwaySet.listFromJsonString, jsonString);
  }

  static Future<List<NavAid>> _loadNavAidsFromFile() async {
    final jsonString = await rootBundle.loadString(
      '$kDataPath$kNavAidsFileName',
      cache: false,
    );

    return compute(NavAid.listFromJsonString, jsonString);
  }
}

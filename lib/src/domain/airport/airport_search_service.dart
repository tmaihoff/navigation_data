import 'package:aviation_entities/airport.dart';
import 'package:flutter/foundation.dart';
import 'package:navigation_data/src/domain/airport/airport_repository.dart';

class AirportSearchService {
  final AirportRepository airportRepository;

  AirportSearchService(this.airportRepository);

  Future<List<Airport>> searchAirports(String searchInput) {
    return compute(_searchAirports, searchInput);
  }

  Future<List<Airport>> _searchAirports(String searchInput) async {
    if (searchInput.trim().isEmpty) {
      return [];
    }

    final startsWithIcao =
        await airportRepository.findAllByIcaoCodeStartsWith(searchInput)
          ..sort((a, b) => a.icaoCode.compareTo(b.icaoCode));

    final startsWithIata =
        await airportRepository.findAllByIataCodeStartsWith(searchInput)
          ..sort((a, b) => a.iataCode.compareTo(b.iataCode));

    final startsWithName =
        await airportRepository.findAllByNameStartsWith(searchInput)
          ..sort((a, b) => a.name.compareTo(b.name));

    final byIcao = await airportRepository.findAllByIcaoCodeLike(searchInput)
      ..sort((a, b) => a.icaoCode.compareTo(b.icaoCode));

    final byIata = await airportRepository.findAllByIataCodeLike(searchInput)
      ..sort((a, b) => a.iataCode.compareTo(b.iataCode));

    final byName = await airportRepository.findAllByNameLike(searchInput)
      ..sort((a, b) => a.name.compareTo(b.name));

    if (searchInput.trim().length == 3) {
      return {
        ...byIata,
        ...startsWithIcao,
        ...startsWithName,
        ...byIcao,
        ...byName,
      }.toList();
    }

    return {
      ...startsWithIcao,
      ...startsWithIata,
      ...startsWithName,
      ...byIcao,
      ...byIata,
      ...byName,
    }.toList();
  }
}

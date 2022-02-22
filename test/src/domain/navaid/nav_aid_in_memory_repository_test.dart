import 'package:aviation_entities/nav_aid.dart';
import 'package:aviation_units/aviation_units.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:navigation_data/src/infrastructure/in_memory_repository/nav_aid_in_memory_repository.dart';

void main() {
  late NavAidInMemoryRepository repo;
  group('navaid in memory repository:', () {
    const mockedAll = [
      NavAid(
        type: NavAidType.dme,
        identifier: 'id1',
        name: 'name1',
        frequency: '111.000',
        latitude: 0,
        longitude: 0,
        elevation: Length.zero,
        magneticVariation: Angle.zero,
      ),
      NavAid(
        type: NavAidType.dme,
        identifier: 'id1',
        name: 'name1',
        frequency: '111.000',
        latitude: 1,
        longitude: 0,
        elevation: Length.zero,
        magneticVariation: Angle.zero,
      ),
      NavAid(
        type: NavAidType.dme,
        identifier: 'id1',
        name: 'name1',
        frequency: '111.000',
        latitude: 0,
        longitude: 1,
        elevation: Length.zero,
        magneticVariation: Angle.zero,
      ),
    ];
    setUp(() async {
      repo = NavAidInMemoryRepository(mockedAll);
    });

    test('find all', () async {
      expect(repo.findAll(), mockedAll);
    });

    test('find by location', () async {
      expect(
        repo.findAllByLocation(lat: 0, lon: 0, offset: const Length(m: 1)),
        [mockedAll[0]],
      );
      expect(
        repo.findAllByLocation(lat: 0, lon: 0, offset: const Length(nm: 60)),
        [mockedAll[0], mockedAll[1], mockedAll[2]],
      );
      expect(
        repo.findAllByLocation(lat: 2, lon: 2, offset: const Length(nm: 60)),
        [],
      );
    });
  });
}

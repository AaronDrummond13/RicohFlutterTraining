import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

import '../images.dart';

class SembastDB {
  DatabaseFactory dbFactory = databaseFactoryIo;
  late Database _db;
  final store = intMapStoreFactory.store('images');
  static final SembastDB _singleton = SembastDB.interal();

  SembastDB.interal();

  factory SembastDB() {
    return _singleton;
  }

  Future<Database> init() async {
    return _db ??= await _openDb();
  }

  Future _openDb() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final dbPath = join(docsDir.path, 'images.db');
    final db = await dbFactory.openDatabase(dbPath);
    return db;
  }

  Future<int> addImages(Images images) async {
    int id = await store.add(_db, images.toMap());
    return id;
  }

  Future getImages() async {
    await init();
    final finder = Finder(sortOrders: [SortOrder('name')]);
    final snapshot = await store.find(_db, finder: finder);
    return snapshot.map((item) {
      final images = Images.fromMap(item.value);
      images.id = item.key;
      return images;
    }).toList();
  }

  Future updateImages(Images images) async {
    final finder = Finder(filter: Filter.byKey(images.id));
    await store.update(_db, images.toMap(), finder: finder);
  }

  Future deleteImages(Images images) async {
    final finder = Finder(filter: Filter.byKey(images.id));
    await store.delete(_db, finder: finder);
  }

  Future deleteAll() async {
    await store.delete(_db);
  }
}

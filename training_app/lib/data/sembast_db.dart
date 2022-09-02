import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

import '../images.dart';

class SembastDB {
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database? _db;
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
    if (_db == null) {
      //throw database is null error
    }
    int id = await store.add(_db!, images.toMap());
    return id;
  }
}

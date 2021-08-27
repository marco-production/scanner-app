import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scanner/src/app/models/scanner.dart';
import 'package:sqflite/sqflite.dart' show Database, openDatabase;

class DBProvider {

  static Database? _database;

  /// * PATRON DE DISEÑO SINGLETON
  /// ****************************
  ///   Instancia de la clase DBProvider, al constructor privado.
  ///   Al constructor estar privado solo se pueden acceder a los atributos desde la misma clase.
  static final DBProvider db = DBProvider._();

  DBProvider._();

  /// Sino existe una conexion se crea una nueva conexion
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    print('Conexion exitosa!');

    return _database!;
  }

  initDB() async {

    /// Es importante que cada vez que se crea una nueva instancia para crear una conexion
    /// se aumente la version de la base de datos para que el dispositivo detecte los cambios y actualice la BD.

    /// Se optiene el path donde la App guarda los documentos temporales, que posteriormente se borran si se desintala la aplicacion.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    /// El join se utiliza para unir Path
    final path = join(documentsDirectory.path, 'ScannerDB.db');

    /// Se crea una nueva version de la base de datos, aqui creamos la tabla.
    return await openDatabase(
        path,
        version: 1,
        onOpen: (db) {},
        onCreate: ( Database db, int version ) async {
          await db.execute(
              'CREATE TABLE scanners ('
                  ' id INTEGER PRIMARY KEY,'
                  ' type TEXT,'
                  ' value TEXT'
                  ')'
          );
        }
    );
  }

  ///* INSERTAR DATOS *///

  /// Forma #1 - Ejecutar el Query directamente.
  Future<int> insertScannerRaw(Scanner scanner) async {

    int? id = scanner.id;
    String? type = scanner.type;
    String value = scanner.value;

    //Se verifica que la conexion esta arriba
    final db = await database;
    final res = db.rawInsert("INSERT INTO scanners(id, type, value) VALUES (${id}, '${type}', '${value}');");
    return res;
  }

  /// Forma #2 - Se especifica la tabla y se mapean los datos.
  Future<int> insertScanner(Scanner scanner) async {

    final db = await database;
    final res = db.insert('scanners', scanner.toJson());
    return res;
  }

  /// GET DATOS *///

  /// Obtener un registro
  Future<Scanner?> getScannerById( int id ) async {

    final db = await database;
    final getScanner = await db.query('scanners', where: 'id = ?', whereArgs: [id]);

    if(getScanner.isNotEmpty) {
      return Scanner.fromMap(getScanner.first);
    }
    return null;
  }

  /// Obtener todos los registros
  Future<List<Scanner>> getScanners() async {

    final db = await database;
    final getScanners = await db.query('scanners');

    //getScanners.map((e) => Scanner.fromMap(e)).toList();
    return getScanners.isNotEmpty ? List<Scanner>.from(getScanners.map((e) => Scanner.fromMap(e))) : [];
  }

  /// Obtener los registros por tipo
  Future<List<Scanner>> getScannersByType( String type ) async {

    final db = await database;
    final getScanners = await db.query('scanners', where: 'type = ?', whereArgs: [type]);

    return getScanners.isNotEmpty ? List<Scanner>.from(getScanners.map((e) => Scanner.fromMap(e))) : [];
  }

  ///* UPDATE DATOS *///
  Future<int> UpdateScannerById(Scanner scanner) async {

    final db = await database;
    final getScanner = await db.update('scanners', scanner.toJson() , where: 'id = ?', whereArgs: [scanner.id]);

    return getScanner;
  }

  ///* DELETE DATOS *///

  ///Eliminar todos los registros
  Future<int> DeleteScanners() async {

    final db = await database;
    final res = db.delete('scanners');
    return res;
  }

  ///Eliminar todos los registros
  Future<int> DeleteScannerById( int id) async {

    final db = await database;
    final res = db.delete('scanners', where: 'id = ?', whereArgs: [id]);
    return res;
  }
}
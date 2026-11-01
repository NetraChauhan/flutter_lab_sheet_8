import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

Future<Database> openLabDb(String name,List<String> createSql) async{
  if(kIsWeb) databaseFactory=databaseFactoryFfiWeb;
  return openDatabase(name,version:1,
    onCreate:(db,v)async{for(final sql in createSql){await db.execute(sql);}},
    onOpen:(db)async{for(final sql in createSql){await db.execute(sql);}},
  );
}

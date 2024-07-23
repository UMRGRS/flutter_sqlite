import 'dart:io';

import 'package:database/config/config.dart';
import 'package:flutter/foundation.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

void main() {
  if(Platform.isWindows || Platform.isLinux || Platform.isMacOS || Platform.isAndroid){
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  else if (kIsWeb){
    databaseFactory = databaseFactoryFfiWeb;
  }

  runApp(const App());
}

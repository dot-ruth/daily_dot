// a model to store the first day the app is launched , for the heet map 
import 'package:isar/isar.dart';

//run cmd to generate file: dart run build_runner build
part 'app_settings.g.dart';

@Collection()
class AppSettings {
  Id id = Isar.autoIncrement;
  DateTime? firstLaunchDate;

  // color set fields
  int? colorValue1;
  int? colorValue2;
  int? colorValue3;
  int? colorValue4;
  int? colorValue5;

}
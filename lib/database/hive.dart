import 'package:ghmc/model/database_models/download_records.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../util/utils.dart';

const dbname = "records";

class HiveUtils<T> {
  static var db;

// this function need to intialised for smooth working of records
  static initalised() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    Hive
      ..init(documentDirectory.path)
      ..registerAdapter(DownloadModelAdapter());
    db = await Hive.openBox(dbname);
  }

  addRecord(T data) async {
    if (db == null) {
      "Hive initalisation failed".printerror;
      return;
    }
    db.add(data);
    "Record added Successfully".printinfo;
  }

  getRecordsById(String _id) async {
    Box s = db as Box;
    s.values.length.toString().printwarn;
    List<T>? ls = s.values
        .where((element) => (element as DownloadModel).id == _id)
        .cast<T>()
        .toList();
    //List<DownloadModel> lsdata = ls as List<DownloadModel>;

    ls.forEach((element) {
      (element as DownloadModel).file_name!.printverbose;
    });
  }
}

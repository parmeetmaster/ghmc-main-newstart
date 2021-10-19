import 'package:hive/hive.dart';
part 'download_records.g.dart';

@HiveType(typeId: 0)
class DownloadModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? download_link;

  @HiveField(2)
  String? file_name;

  @HiveField(3)
  String? download_path;

  @HiveField(4)
  String? file_type;

  DownloadModel(
      {required this.id,
      required this.download_link,
      required this.file_name,
      required this.download_path,
      required this.file_type});
}

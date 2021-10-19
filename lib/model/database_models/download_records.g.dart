// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_records.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadModelAdapter extends TypeAdapter<DownloadModel> {
  @override
  final int typeId = 0;

  @override
  DownloadModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownloadModel(
      id: fields[0] as String?,
      download_link: fields[1] as String?,
      file_name: fields[2] as String?,
      download_path: fields[3] as String?,
      file_type: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DownloadModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.download_link)
      ..writeByte(2)
      ..write(obj.file_name)
      ..writeByte(3)
      ..write(obj.download_path)
      ..writeByte(4)
      ..write(obj.file_type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

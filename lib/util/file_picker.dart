import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class FilePick {
  Future<File>? pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
    );
    return File((result!.files.first.path)!);
  }

  Future<List<File>> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      allowCompression: true,
      type: FileType.image,
    );
    List<File>? files=[];
      result!.files.forEach((element) {
        print("files adding ${element.path}");
        files.add(new File(element.path!));

      });

    return files ;
  }

  Future<File?> takecameraPic() async {
    PickedFile? result = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
      imageQuality: 5,
    );
    return File((result!.path));
  }
}

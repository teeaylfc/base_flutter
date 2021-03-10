import 'dart:io';

class DeleteFile {
  void delete(path) {
    File deleleFile = File(path);
    deleleFile.delete();
  }
}

final deleteFile = DeleteFile();

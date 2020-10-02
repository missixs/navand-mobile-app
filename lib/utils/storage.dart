import 'dart:async';
import 'dart:io';
import 'package:navand/utils/formUtils.dart';
import 'package:path_provider/path_provider.dart';

class TokenStorage {

  Future<String> get _localPath async {
    Directory directory;
    try {
      // code that might throw an exception
      directory = await getApplicationDocumentsDirectory();
    } catch (e) {
      print(e);
      // code for handling exception
    }
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/token.txt');
  }

  Future<String> readToken() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return new uuid
      print(e.toString());
      String token = generateToken();
      await writeToken(token);
      return token;
    }
  }

  Future<File> writeToken(String token) async {
    final file = await _localFile;
    return file.writeAsString('$token');
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:live/model/magazine.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class magazine_viewmodel extends GetxController {

   String ? status;
  String get getstatus=>status!;


  Future <List<Magazine>> getmagazines(http.Client client) async
  {
    try
    {
      final  response = await client
          .get(Uri.parse("https://liveegy.com/app/api.php"));
      return parsemagazine(response.body);
    }
    on TimeoutException catch (_) {
      status = "failed";
      client.close();
      update();
    } on SocketException catch (_) {
      status = "failed";
      client.close();
      update();
    }
    update();
    return [];
  }

  List<Magazine> parsemagazine(String responseBody) {

    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Magazine>((json) => Magazine.fromJson(json)).toList();
  }

  static Future <File> getpddf (String url) async
  {
    final http.Response response =await http.get(Uri.parse(url));
    final bytes=response.bodyBytes;
    return _storeFile(url,bytes);
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:live/model/post.dart';
import 'package:http/http.dart' as http;


class postviewmodel extends GetxController {

  List<PostElement> postlist=[];
  List<PostElement> get  getpost=> postlist;
  String? status;
  String get getstatus=>status!;

  Future getposts(http.Client client) async
  {
    try
    {
      final  response = await client
          .get(Uri.parse('https://liveegy.com/api/get_posts'));
      return  parsepost(response.body);
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

  }

  List<PostElement> parsepost(String responseBody) {

    var parsed = jsonDecode(responseBody);
    post p = post.fromJson(parsed);
    List<PostElement> _posts = p.posts!;
    return _posts;
  }
}
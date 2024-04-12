import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import '../../model/category.dart';


class categoryviewmodel extends GetxController {

    List<Post> _localpost=[];
    List<Post> get  localpost=>_localpost;
    ValueNotifier<bool> get loading => _loading;
    ValueNotifier<bool> _loading = ValueNotifier(false);
    String ? status;
    String get getstatus=>status!;



    Future <List<Post>> getpage(int id,int page,http.Client client) async
    {
        _loading.value=true;
        var client=await http.Client();

        try{
            final  response = await client
                .get(Uri.parse("https://liveegy.com/api/get_category_posts?id=$id&page=$page"));

            if(response.statusCode==200 && response.body != "")
            {      status="success";
            _loading.value=false;
            client.close();
            return parsepost(response.body);
            }
        }
        on TimeoutException catch (_) {
            status="failed";
            client.close();
            update();
        } on SocketException catch (_) {
            status="failed";
            client.close();
            update();
        }
        update();
        return [];
    }

    Future <List<Post>> getcategory(int id,http.Client client) async
    {
        var client=await http.Client();

        try {
            final response = await client
                .get(Uri.parse(
                "https://liveegy.com/api/get_category_posts?id=$id"));

            return parsepost(response.body);
        }
        on TimeoutException catch (_) {
            status="failed";
            client.close();
            update();
        } on SocketException catch (_) {
            status="failed";
            client.close();
            update();
        }
        update();
        return [];
    }


    List<Post> parsepost(String responseBody) {

        var parsed = jsonDecode(responseBody);
        if(parsed != null)
        {
            Categories _category = Categories.fromJson(parsed);
            List<Post>?_posts = _category.posts;
            return _posts!;
        }
        return [];
    }

    Future  getpnumofages(int id,http.Client client) async
    {
        try {
            final response = await client
                .get(Uri.parse(
                "https://liveegy.com/api/get_category_posts?id=$id"));
            if (response.statusCode == 200) {
                var parsed = jsonDecode(response.body);
                Categories _category = Categories.fromJson(parsed);
                return _category.pages;
            }
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
}
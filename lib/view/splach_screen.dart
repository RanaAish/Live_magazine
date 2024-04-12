import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:live/view/ControlView.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class splachscreen extends StatefulWidget {
  @override
  _splachscreenState createState() => _splachscreenState();
}

class _splachscreenState extends State<splachscreen> {


  @override
  void initState() {
    Future.delayed(Duration(seconds: 2),(){
      Get.offAll(Controllview());
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:
        Container(
            alignment: Alignment.center,child:
        SizedBox(
          height:200.h,
          width: 200.w,
          child:Image.asset('assets/images/logo (1).png'),
        )));
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../splach_screen.dart';


class tryagain extends StatelessWidget {

  final  double t;
  tryagain({this.t=70});

  @override
  Widget build(BuildContext context) {
    return Column(children:[
      Padding(padding: EdgeInsets.only(top: t.h),child:Center(child:Lottie.asset("assets/images/nointrnet.json",width: 300.w,
          height: 300.h))),
      SizedBox(height:20.h),
      Text(" الرجاء اعاده المحاوله",style:TextStyle(fontSize:20,fontWeight:FontWeight.bold,color:Colors.black)),
      SizedBox(height:30.h),
      Container(
          width:290.w,
          height:35.h,
          decoration: BoxDecoration(color:Colors.grey,borderRadius: BorderRadius.circular(15),border: Border.all(width: 1.7.w,color:Colors.grey)),
          child:ElevatedButton(child: Text('اعد المحاوله',style:
          TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),onPressed:()
          {
            Get.offAll(splachscreen());
          }))
    ]);
  }
}

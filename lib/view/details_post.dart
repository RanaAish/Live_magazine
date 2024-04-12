import 'package:flutter/material.dart';
import 'package:live/constants.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live/core/view_model/checkconnection.dart';
import 'package:flutter_html/flutter_html.dart';
//import 'package:flutter_html/style.dart';
import 'package:live/view/widgets/cachedimage.dart';
import 'package:live/view/widgets/customtext.dart';
import'package:live/view/widgets/noconnection.dart';



class details_post extends StatelessWidget {


  final GetXNetworkManager _networkManager = Get.find<GetXNetworkManager>();
   late String contentofpost ;


  @override
  Widget build(BuildContext context) {
    if(Get.arguments.content.contains('<iframe'))
    {
      contentofpost=Get.arguments.content.replaceAll('?controls=0', "");
    }
    else
    {
      contentofpost=Get.arguments.content;
    }


    return  Directionality(
        textDirection: TextDirection.rtl,
        child:Scaffold(
            appBar: AppBar(
                backgroundColor: primarycolor,
                title: customtext(
                  text:Get.arguments.title.replaceAll(new RegExp("[0-9&:#;.]"),''),
                  color: Colors.white,
                ),
                leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ))),
            body:GetBuilder<GetXNetworkManager>(builder: (builder)=>_networkManager.connectionType == 1 ?
            Container(
              height: double.infinity,
              child:SingleChildScrollView(
                scrollDirection:Axis.vertical,
                child: Padding(
                  padding:EdgeInsets.all(8),
                  child:Flex(
                    direction:Axis.vertical,
                    children: [
                      cachedimage(url:Get.arguments.attachments[0].images["full"].url),
                      SizedBox(height: 25.h,),
                      Center(child: customtext(text:Get.arguments.title.replaceAll(new RegExp("[0-9&:#;.]"),''),fontSize:
                      20,
                        alignment: Alignment.center,
                        color:
                        primarycolor,height: 1.3,)
                      ),
                      SizedBox(height: 23.h,),
                      Padding(padding: EdgeInsets.only(right:10.w,left:15.w),child:
                      Row(  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Image.asset('assets/images/usericon.png',width: 30,height:30),
                            customtext(text:'${Get.arguments.author.firstName}',
                              fontSize:
                              16,),],),
                          Row(children: [ customtext(text:'${Get.arguments.modified}',
                            fontSize:
                            16,), Icon(Icons.calendar_today),],),
                        ],
                      ),),
                      SizedBox(height: 15.h,),
                      Container(
                          width: 500.w,
                          child:
                          Row(children: [

                            Flexible(
                                child: Html(


                                  data:contentofpost,
                                  style: {
                                    'h1': Style(
                                        color: primarycolor
                                    ),
                                    'p': Style(
                                        color: Colors.black87,
                                        fontSize: FontSize(17.0)
                                    ),
                                    'ul': Style(
                                        margin: Margins.only(top: 20,bottom: 20),
                                        ),

                                  },
                                ))
                          ])),

                    ],
                  ) ,
                ),
              ) ,):noconnection())));
  }
}
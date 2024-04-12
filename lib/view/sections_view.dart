import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:live/constants.dart';
import 'package:live/core/view_model/checkconnection.dart';
import 'package:live/core/view_model/home_viewmodel.dart';
import 'package:get/get.dart';
import 'package:live/view/posts_of_category.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:live/view/widgets/customtext.dart';
import'package:live/view/widgets/noconnection.dart';
import 'package:live/model/staticdata.dart';
import 'ControlView.dart';



class sections_view extends StatelessWidget {

  final GetXNetworkManager _networkManager = Get.find<GetXNetworkManager>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: kSecondaryGreyColor,
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: IconButton(
                    icon: Icon(Icons.menu, color: primarycolor),
                    onPressed: null,
                    iconSize: 30,
                  ))
            ],
            title: Padding(
              padding: EdgeInsets.only(left: 60.w),
              child: Center(
                child: Image.asset(
                  "assets/images/logo (1).png",
                  width: 130.w,
                  height: 130.h,
                ),
              ),
            )),
        body: GetBuilder<GetXNetworkManager>(builder: (builder) =>
        _networkManager.connectionType == 1 ? SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(
                    right: 30.w, left: 30.w, top: 30.h),
                    child: GridView.builder(
                        physics:
                        ScrollPhysics(),
                        // to disable GridView's scrolling
                        shrinkWrap: true,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemCount: staticdata.names.length-1,
                        itemBuilder: (BuildContext context, i) {
                          if (i == 1) {
                            return
                              Container(
                                  child: Column(children: [
                                    Image.asset(
                                        'assets/images/homepage.png',
                                        width: 50.w,
                                        height: 50.h),
                                    SizedBox(height: 10.h,),
                                    GetBuilder<HomeViewModel>(
                                        init: HomeViewModel(),
                                        builder: (control) {
                                          return GestureDetector(
                                              onTap: () {
                                                control.changeselectedvalue(3);
                                                Get.to(Controllview());
                                              }, child:
                                          customtext(
                                            text: 'الرئيسيه',
                                            color: primarycolor,
                                            fontSize: 20,
                                            alignment: Alignment
                                                .center,));
                                        }),
                                  ],));
                          }
                          else {
                            return GestureDetector(
                                onTap: () {
                                  Get.to(postofcategory(indexofdata: i,
                                  ));
                                },
                                child: Container(
                                    child: Column(children: [
                                      Image.asset(
                                          'assets/images/${staticdata.ids[i]}.png',
                                          width: 50.w,
                                          height: 50.h),
                                      SizedBox(height: 10.h,),
                                      customtext(
                                        text: staticdata.names[i],
                                        color: primarycolor,
                                        fontSize: 20,),
                                    ],)));
                          }
                        })),
                GestureDetector(
                    onTap: () {
                      Get.to(postofcategory(indexofdata: 12,
                      ));},
                    child: Container(
                        child: Column(children: [
                          Image.asset(
                              'assets/images/3936.png',
                              width: 50.w,
                              height: 50.h),
                          SizedBox(height: 10.h,),
                          customtext(
                            text: staticdata.names[12],
                            color: primarycolor,
                            fontSize: 20,),
                        ],))),
                Padding(padding: EdgeInsets.only(
                    left: 100.w, right: 100.w, bottom: 30.h,top:40.h),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween,
                      children: [
                        InkWell(child: Image.asset(
                          'assets/images/facebook-logo.png',
                          width: 40.w, height: 40.h,),
                          onTap: () {
                            launch(
                                'https://www.facebook.com/AbukabdaLive/');
                          },),
                        InkWell(child: Image.asset(
                          'assets/images/instagram.png',
                          width: 40.w, height: 40.h,),
                            onTap: () {
                              launch(
                                  'https://www.instagram.com/livemagazinefr/');
                            }),
                        InkWell(child: Image.asset(
                          'assets/images/twitter.png',
                          width: 40.w, height: 40.h,),
                            onTap: () {
                              launch(
                                  'https://twitter.com/hashtag/livemagazine');
                            }),
                        InkWell(child: Image.asset(
                          'assets/images/youtube.png',
                          width: 40.w, height: 40.h,),
                            onTap: () {
                              launch(
                                  'https://www.youtube.com/channel/UCl831da31Ibeu_rXEbgKbAg');
                            })
                      ],),
                  ),)
              ],
            ))
            : noconnection()
        ));
  }
}

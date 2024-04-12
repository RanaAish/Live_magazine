import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:live/core/view_model/magazine_viewmodel.dart';
import 'package:live/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live/view/widgets/cachedimage.dart';
import 'package:live/view/widgets/circular_progress.dart';
import 'package:live/view/widgets/customtext.dart';
import'package:live/view/widgets/noconnection.dart';
import 'package:live/core/view_model/checkconnection.dart';
import 'package:live/view/PDFViewerPage.dart';
import 'package:http/http.dart' as http;
import 'package:live/model/magazine.dart';
import 'package:live/view/widgets/try_again.dart';

class  magazine_widget extends StatefulWidget {
  @override
  _magazine_widgetState createState() => _magazine_widgetState();
}

class _magazine_widgetState extends State< magazine_widget> {
  final GetXNetworkManager _networkManager = Get.find<GetXNetworkManager>();

  void openPDF(BuildContext context, File file) => Get.to(PDFViewerPage(file: file));
  ScrollController _scrollController = new ScrollController();
  bool click=false;


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return GetBuilder<GetXNetworkManager>(builder: (builder)=>_networkManager.connectionType == 1 ? GetBuilder<magazine_viewmodel>(
        init: magazine_viewmodel(),
        builder: (controler) =>controler.status=="failed"?tryagain(): FutureBuilder  <List<Magazine>> (
            future: controler.getmagazines(http.Client()),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Scrollbar(
                    controller: _scrollController,
                    //isAlwaysShown: true,
                    thickness: 8,
                    radius: Radius.circular(20),
                    child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        child: Container(
                            child: Stack(children: [
                              GridView.builder(
                                  physics:
                                  ScrollPhysics(), // to disable GridView's scrolling
                                  shrinkWrap: true,
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context, i) {
//   final file =  magazine_viewmodel.getpddf(snapshot.data[i].link);
                                    return new  Container(
                                        height: 500,
//  padding: EdgeInsets.all(5),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top:5.h,
                                              bottom: 5.h,
                                              left: 3.w,
                                              right: 3.w
                                          ),

                                          child:GestureDetector(
                                              onTap: () async{
                                                setState(() {
                                                  click=true;
                                                });
                                                final file = await magazine_viewmodel.getpddf(snapshot.data[i].link);
                                                Get.to(PDFViewerPage(file: file));
                                                if (this.mounted) {
                                                setState(() {
                                                  click=false;
                                                });}
//openPDF(context, file);
                                              },child:Column(
                                            children: [
                                              Expanded(child:Container(
                                                  height:250.h, //143
                                                  child:  cachedimage(
                                                    url:
                                                    '${snapshot.data[i].img}',width: 150,height: 150,
                                                  ))),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              customtext(text:snapshot.data[i].title,
                                                  fontweight:
                                                  FontWeight.bold,
                                                  fontSize: 17,
                                                  color: primarycolor),

                                            ],
                                          )),
                                        ));
                                  }),
                              Positioned(top:400.h,right: 180.w,child:click? circular_progress():SizedBox(height: 0,width: 0,))
                            ],
                            ) )));
              }

              else {
                return circular_progress();
              }
            })):noconnection());
  }
}

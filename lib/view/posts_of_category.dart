import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live/Helper/binding.dart';
import 'package:live/constants.dart';
import 'package:live/core/view_model/category_viewmodel.dart';
import 'package:live/model/category.dart';
import 'package:live/model/staticdata.dart';
import 'package:live/view/widgets/circular_progress.dart';
import 'package:live/view/widgets/noconnection.dart';
import 'package:live/core/view_model/checkconnection.dart';
import 'package:live/view/widgets/magazine_widget.dart';
import 'package:live/view/widgets/cachedimage.dart';
import 'package:live/view/widgets/customtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:live/view/widgets/try_again.dart';
import 'details_post.dart';

class postofcategory extends StatefulWidget {

  int ?indexofdata;
  postofcategory({Key? key, @required this.indexofdata}) : super(key: key);

  @override
  _postofcategoryState createState() => _postofcategoryState();
}

class _postofcategoryState extends State<postofcategory> {
  late int totalength;
  categoryviewmodel obj = new categoryviewmodel();
  final GetXNetworkManager _networkManager = Get.find<GetXNetworkManager>();



  @override
  void initState() {
    Binding().dependencies();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: primarycolor,
                title: Text(
                  staticdata.names[widget.indexofdata!],
                  style: TextStyle(color: Colors.white),
                ),
                leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ))),
            body: GetBuilder<GetXNetworkManager>(builder: (builder)=>_networkManager.connectionType == 1 ? Container(child:staticdata.names[widget.indexofdata!] != "المجلة"
                ?  GetBuilder<categoryviewmodel>(
                init: categoryviewmodel(),
                builder: (controler) =>
                controler.status=="failed"?tryagain():
                PagewiseListView(
                    pageSize: 15,
                    padding: EdgeInsets.all(5.0),
                    itemBuilder: (context, entry, index) {
                      if( entry.attachments!.length !=0)
                      {
                        return  Container(
                            padding: EdgeInsets.only(right: 8.w,top: 4.h,bottom: 2.h,left: 8.w),
                            width: 300.w,
                            height: 150.h,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(details_post(),arguments: entry);
                              },
                              child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius:
                                  BorderRadius.circular(5.0)),
                                  child: Row(
                                      mainAxisAlignment:MainAxisAlignment.start,
                                      children: [
                                        Flexible(child:  Padding(padding:EdgeInsets.only(top: 5.h,left: 10.w,right: 10.w,bottom:5.h),
                                          child:cachedimage(url: '${ entry!.attachments![0].images!["thumbnail"]!.url}'),
                                        )),
                                        Container(
                                            width: 220.w,
                                            height: 220.h,
                                            child:
                                            Row(children: [
                                              Flexible(
                                                  child: customtext(
                                                    text: entry.title!.replaceAll(new RegExp("[0-9&:#;.]"),''),
                                                    fontSize:17,
                                                    height:1.7,
                                                    maxLine: 2,
                                                  )
                                              )]))
                                      ])),
                            ));
                      }
                      else
                      {
                        return SizedBox(width: 0,height:0,);
                      }

                    },
                    pageFuture: (pageIndex) {

                      pageIndex=(pageIndex!+1);
                      return controler.getpage(staticdata.ids[widget.indexofdata!],pageIndex, http.Client());
                    },
                    loadingBuilder: (context) {return circular_progress();}
                )):magazine_widget()):noconnection(),
            )));
  }

}

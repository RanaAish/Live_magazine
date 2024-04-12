import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live/core/view_model/checkconnection.dart';
import 'PDFViewerPage.dart';
import 'package:live/view/widgets/magazine_widget.dart';

class magazine_view extends StatelessWidget {


  final GetXNetworkManager _networkManager = Get.find<GetXNetworkManager>();

  void openPDF(BuildContext context, File file) => Get.to(PDFViewerPage(file: file));


  @override
  Widget build(BuildContext context) {

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(

            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                title: Padding(
                  padding: EdgeInsets.only(left: 60.w),
                  child: Center(
                    child: Image.asset(
                      "assets/images/logo (1).png",
                      width: 130.w,
                      height: 130.h,
                    ),
                  ),
                ),
                backgroundColor: kSecondaryGreyColor,
                leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: primarycolor,
                    ))),
            body: magazine_widget()));
  }
}

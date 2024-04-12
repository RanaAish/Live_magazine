import 'package:flutter/material.dart';
import 'package:live/view/ControlView.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:live/core/view_model/home_viewmodel.dart';
import 'package:get/get.dart';
import 'package:live/constants.dart';


class bottomnavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
        init: HomeViewModel(),
        builder: (controler) =>
            Container(
                decoration: BoxDecoration(
                  color:primarycolor,
                  boxShadow: [
                    BoxShadow(
                    ),],),
                child:BottomNavigationBar(
                    iconSize: 28,
                    currentIndex: controler.navigatovalue,
                    onTap: (selectedvalue){
                      controler.changeselectedvalue(selectedvalue);
                      Get.off(Controllview());
                    },
                    elevation: 0.0,

                    backgroundColor:primarycolor,
                    unselectedItemColor: Colors.white,
                    showUnselectedLabels: false,
                    fixedColor: Colors.white ,
                    type:BottomNavigationBarType.fixed ,
                    items: [
                      BottomNavigationBarItem(icon:Image.asset('assets/images/magazine.png',color:Colors.white,width:26,height:26),label: "المجله"),
                      BottomNavigationBarItem(icon:Image.asset('assets/images/homepage live nehal icon.png',color:Colors.white,width:26,height:26),label:'لايف نهال'),
                      BottomNavigationBarItem(icon:Image.asset('assets/images/homepage category icon.png',color:Colors.white,width:26,height:26),label: "الاقسام"),
                      BottomNavigationBarItem(icon: Image.asset('assets/images/homepage.png',color:Colors.white,width:26,height:26),label: "الرئيسيه"),
                    ])));
  }
}

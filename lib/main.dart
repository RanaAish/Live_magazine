import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:live/view/ControlView.dart';
import 'dart:ui' as ui;
import 'Helper/binding.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'core/view_model/post_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Binding().dependencies();
  Get.put(postviewmodel());
  await ScreenUtil.ensureScreenSize();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    RenderErrorBox.backgroundColor = Colors.transparent;
    RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
    return MaterialApp(
        debugShowCheckedModeBanner:false,
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar', 'AE'), // OR Locale('ar', 'AE') OR Other RTL locales
        ],
        locale: Locale("fa", "IR"),
        builder:(context, child){
          return   ScreenUtilInit(
          designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    // Use builder only if you need to use library outside ScreenUtilInit context
    builder: (_ , child) {
    return  GetMaterialApp(
              debugShowCheckedModeBanner:false,
              initialBinding: Binding(),
              home: Scaffold(
                body:Controllview(),
              ));});});
  }
}

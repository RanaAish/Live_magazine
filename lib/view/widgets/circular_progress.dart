import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';



class circular_progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 0),
        child: Center(
            child: SizedBox(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(primarycolor),
                strokeWidth: 5,
              ),
              width: 40.w,
              height: 40.h,
            )));;
  }
}

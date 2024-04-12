import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class noconnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child:SizedBox(
        height: 400,
        width: 400,
        child: Lottie.asset("assets/images/12701-no-internet-connection.json",width: 300,height: 300)
    ),);
  }
}

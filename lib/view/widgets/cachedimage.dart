import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
class cachedimage extends StatelessWidget {

  String ? url;
  double? width,height,widthofimg,hightofimg;
  cachedimage({Key? key, this.url,this.width=200,this.height=150,widthofimg,heightofimg}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  CachedNetworkImage(
        imageUrl: this.url!,width: widthofimg,height:hightofimg ,
        placeholder: (context, url) => Image.asset(
            'assets/images/livelogo.png',
            width: width,
            height: height),
        errorWidget: (context, url, error) => new Icon(Icons.error));
  }
}

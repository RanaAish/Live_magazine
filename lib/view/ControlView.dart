import 'package:flutter/material.dart';
import 'package:live/core/view_model/home_viewmodel.dart';
import 'package:get/get.dart';
import 'package:live/view/widgets/bottomnavigation.dart';

class Controllview extends GetWidget<HomeViewModel>
{

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
        builder: (controller) => Scaffold(
          body: controller.currentscreen,
          bottomNavigationBar:bottomnavigation( ),
        ));
  }}

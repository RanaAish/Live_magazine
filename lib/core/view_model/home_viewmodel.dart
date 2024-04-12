import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:live/view/home_view.dart';
import 'package:live/view/magaizine_view.dart';
import 'package:live/view/posts_of_category.dart';
import 'package:live/view/sections_view.dart';


class HomeViewModel extends GetxController {

  int _navigationvalue=3;

  Widget _currentscreen=home_view();

  get navigatovalue =>_navigationvalue;
  get currentscreen => _currentscreen;


  void changeselectedvalue(int selectedvalue)
  {
    _navigationvalue=selectedvalue;
    update();
    switch(selectedvalue)
    {
      case 0:
        {
          _currentscreen=magazine_view();
          break;
        }
      case 1:
        {
          _currentscreen=postofcategory(indexofdata: 0,
          );
          break;
        }
      case 2:
        {
          _currentscreen= sections_view();
          break;
        }
      case 3:
        {
          _currentscreen=home_view();
          break;
        }

    }
  }
}
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:live/core/view_model/category_viewmodel.dart';
import 'package:live/core/view_model/checkconnection.dart';
import 'package:live/core/view_model/home_viewmodel.dart';
import 'package:get/get.dart';




class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put( categoryviewmodel());
    Get.lazyPut<GetXNetworkManager>(() => GetXNetworkManager());
    Get.lazyPut(() => HomeViewModel());

  }
}

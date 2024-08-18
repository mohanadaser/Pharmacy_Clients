
import 'package:get/get.dart';
import 'package:pharmacy_clients/controller/network/network_controller.dart';



class DependencyInjection {
  
  static void init() {
    Get.put<NetworkController>(NetworkController(),permanent:true);
  }
}
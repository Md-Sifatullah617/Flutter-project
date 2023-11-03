import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomepageController extends GetxController {
  var isSelected = false.obs;
  var isPrinterConnected = false.obs;
  var time = ''.obs;
  var date = ''.obs;

  //create function to show date and time
  void showDateAndTime() {
    date.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
    time.value = DateFormat('HH:mm:ss').format(DateTime.now());
  }
}

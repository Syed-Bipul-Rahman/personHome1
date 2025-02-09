import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CustomWeekViewController extends GetxController {
  var selectedDate = DateTime.now().obs; // Observable date

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }
}
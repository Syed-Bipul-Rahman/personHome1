import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:home_health_app/main.dart';
import 'package:home_health_app/utils/app_colors.dart';
import 'package:home_health_app/utils/app_icons.dart';
import 'package:home_health_app/utils/style.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class CustomWeekViewController extends GetxController {
  var selectedDate = DateTime.now().obs;

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }
}
class CustomWeekView extends StatelessWidget {
  const CustomWeekView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomWeekViewController());

    final now = DateTime.now();

    return Obx(() {
      final selectedDate = controller.selectedDate.value;
      String formattedDate = DateFormat('d E').format(selectedDate);

      final firstDayOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
      final daysOfWeek = List.generate(7, (index) {
        final date = firstDayOfWeek.add(Duration(days: index));
        return {
          'day': DateFormat('EEE').format(date),
          'date': date.day,
          'isToday': date.day == now.day &&
              date.month == now.month &&
              date.year == now.year,
        };
      });

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //================================== Month Year ==================================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Row(
                  children: [
                    Text(
                      DateFormat('MMMM yyyy').format(selectedDate),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
                const Spacer(),
                SvgPicture.asset(
                  AppIcons.calenderFillIcon,
                  height: 20,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // ================================= Week Days =================================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: daysOfWeek.map((dayInfo) {
              final isToday = dayInfo['isToday'] as bool;
              return Column(
                children: [
                  Text(
                    dayInfo['day'] as String,
                    style: AppStyles.fontSize14(
                      color: isToday
                          ? AppColors.blackColor
                          : AppColors.iconGrayColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      color: isToday
                          ? AppColors.dateHighlighterColor
                          : Colors.transparent,
                      shape: BoxShape.rectangle,
                    ),
                    child: Text(
                      '${dayInfo['date']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: isToday ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),

          const SizedBox(height: 12),

          Center(
            child: Row(
              children: [
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.dividerColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 1,
                    color: AppColors.dividerColor,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
        ],
      );
    });
  }
}


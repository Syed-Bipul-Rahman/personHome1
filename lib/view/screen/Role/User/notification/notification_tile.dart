import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_health_app/helpers/route.dart';
import 'dart:async';
import '../../../../../helpers/prefs_helpers.dart';
import '../../../../../models/notification/notification_model.dart';
import '../../../../../utils/app_strings.dart';

class NotificationTile extends StatefulWidget {
  final NotificationModel notification;

  const NotificationTile({required this.notification, Key? key})
      : super(key: key);

  @override
  _NotificationTileState createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  // late Timer _timer;
  // late String _timeDifference;

  @override
  void initState() {
    super.initState();
    // Initial calculation of the time difference
    // _timeDifference = getTimeDifference(widget.notification.createdAt.toString());
    // Update the time difference every minute
    // _timer = Timer.periodic(Duration(minutes: 1), _updateTimeDifference);
  }

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }

  //
  // void _updateTimeDifference(Timer timer) {
  //   setState(() {
  //     _timeDifference =
  //         getTimeDifference(widget.notification.createdAt.toString());
  //   });
  // }

  String getTimeDifference(String givenTime) {
    DateTime targetTime = DateTime.parse(givenTime);
    DateTime currentTime = DateTime.now();
    Duration difference = currentTime.difference(targetTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.notification.type == "booking") {
          Get.toNamed(AppRoutes.notificationDetailsScreen, parameters: {
            "notificationId": widget.notification.id!,
          });
        }else if(widget.notification.role=="caregiver"){
          PrefsHelper.remove(AppStrings.accessToken);
          Get.offAllNamed(AppRoutes.signInScreen);

        } else {
          Get.toNamed(AppRoutes.paymentScreen, parameters: {
            "notificationId": widget.notification.id!,
          });
        }
      },
      child: ListTile(
        dense: true,
        title: Text(widget.notification.title!),
        subtitle: Text(
          // _timeDifference,
          "Time",
          style: TextStyle(color: Colors.grey),
        ),
        leading: SizedBox(
          width: 50.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // widget.notification.isRead
              //     ? SizedBox()
              //     : Container(
              //   margin: EdgeInsets.only(right: 8.r),
              //   height: 8.h,
              //   width: 8.w,
              //   decoration: BoxDecoration(
              //     color: Colors.blue,
              //     shape: BoxShape.circle,
              //   ),
              // ),
              Container(
                height: 32.h,
                width: 32.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

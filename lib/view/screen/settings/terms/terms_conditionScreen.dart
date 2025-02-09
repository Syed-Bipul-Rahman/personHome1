import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../../../utils/app_strings.dart';

class TermsConditionscreen extends StatefulWidget {
  const TermsConditionscreen({super.key});

  @override
  State<TermsConditionscreen> createState() => _TermsConditionscreen();
}

class _TermsConditionscreen extends State<TermsConditionscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: Text(AppStrings.helpAndSupport.tr,
          style: TextStyle(fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lacus eu molestie pulvinar rhoncus integer proin elementum. Pretium sit fringilla massa tristique aenean commodo leo. Aliquet viverra amet sit porta elementum et pellentesque posuere,Aliquet viverra amet sit porta elementum et pellentesque posuere,Aliquet viverra amet sit porta elementum et pellentesque posuere',
                textAlign: TextAlign.justify,)
            ],
          ),
        ),
      ),
    );
  }
}

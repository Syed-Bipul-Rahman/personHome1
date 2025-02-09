import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:home_health_app/controller/settings/profileInfoController.dart';
import 'package:home_health_app/utils/app_colors.dart';
import 'package:home_health_app/view/base/custom_button.dart';
import 'package:home_health_app/view/base/custom_dropdown.dart';
import 'package:intl/intl.dart';

import '../../../../../service/api_constants.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/style.dart';
import '../../../../base/borderless_textfields_with_enable_desabled.dart';
import '../../../../base/custom_text.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  ProfileInfoController _profileInfoController =
      Get.put(ProfileInfoController());

  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.personalInformation,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18.w),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.hintColor,
                            width: 1.0,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage: _profileInfoController
                                      .userInfo.value.image?.url !=
                                  null
                              ? NetworkImage(ApiConstants.baseUrl +
                                  _profileInfoController
                                      .userInfo.value.image!.url)
                              : AssetImage(AppImages.placeholder)
                                  as ImageProvider,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _profileInfoController.userInfo.value.firstName ??
                                'Not Found',
                            style: AppStyles.fontSize20(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            _profileInfoController.userInfo.value.email ??
                                'Not Found',
                            style: AppStyles.fontSize16(
                                color: AppColors.greyColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  isEditable == false
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              isEditable = !isEditable;
                            });
                          },
                          child: Row(
                            children: [
                              // Text(
                              //   AppStrings.editProfile,
                              //   style: AppStyles.fontSize16(
                              //       color: AppColors.primaryColor,
                              //       fontWeight: FontWeight.w500),
                              // ),
                              SizedBox(width: 4.w),
                              const Icon(Icons.edit_outlined,
                                  color: AppColors.primaryColor),
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 16.0),

              //======================== phone Number =============================
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.phoneNumber,
                    style: AppStyles.fontSize16(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8.0),
                  _profileInfoController
                              .userInfo.value.phoneNumber.runtimeType ==
                          String
                      ? BorderlessCustomTextFieldEnabled(
                          prefixIcon: Icon(Icons.call_rounded),
                          hintText: _profileInfoController
                                  .userInfo.value.phoneNumber ??
                              AppStrings.dummyPhoneNumber.tr,
                          controller: _profileInfoController.phoneNumberCtrl,
                          enabled: isEditable,
                        )
                      : BorderlessCustomTextFieldEnabled(
                          prefixIcon: Icon(Icons.call_rounded),
                          hintText: _profileInfoController
                              .userInfo.value.phoneNumber
                              .toString(),
                          controller: _profileInfoController.phoneNumberCtrl,
                          enabled: isEditable,
                        ),
                ],
              ),
              SizedBox(height: 16.0),

              //======================== email =============================
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.email,
                    style: AppStyles.fontSize16(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8.0),
                  BorderlessCustomTextFieldEnabled(
                    hintText: _profileInfoController.userInfo.value.email ??
                        AppStrings.dummyEmail.tr,
                    controller: _profileInfoController.emailCtrl,
                    enabled: false,
                  ),
                ],
              ),
              SizedBox(height: 16.0),

              //======================== Gender =============================
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.gender,
                    style: AppStyles.fontSize16(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8.0),

                  CustomDropdown(
                      items: _profileInfoController.gender,
                      hint: _profileInfoController.userInfo.value.gender ??
                          "Select",
                      controller: _profileInfoController.genderCtrl,
                      onChanged: (value) {
                        setState(() {
                          _profileInfoController.selectedGender.value = value!;
                          _profileInfoController.userInfo.value.gender = value;
                        });
                        print(_profileInfoController.selectedGender.value);
                      }),

                  // BorderlessCustomTextFieldEnabled(
                  //   hintText: AppStrings.male.tr,
                  //   controller:  _profileInfoController.genderCtrl,
                  //   enabled: isEditable,
                  // ),
                ],
              ),
              SizedBox(height: 16.0),

              //======================== Date of birth =============================

              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       AppStrings.dateOfBirth,
              //       style: AppStyles.fontSize16(
              //         color: AppColors.blackColor,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //     SizedBox(height: 8.0),
              //     GestureDetector(
              //       onTap: isEditable ? () async {
              //         DateTime initialDate;
              //         try {
              //           // Try to parse existing date if available
              //           initialDate = _profileInfoController.userInfo.value.dataOfBirth != null
              //               ? DateFormat('dd/MM/yyyy').parse(_profileInfoController.userInfo.value.dataOfBirth!)
              //               : DateTime.now();
              //         } catch (e) {
              //           // If parsing fails, use current date
              //           initialDate = DateTime.now();
              //         }
              //
              //         final DateTime? picked = await showDatePicker(
              //           context: context,
              //           initialDate: initialDate,
              //           firstDate: DateTime(1900),
              //           lastDate: DateTime.now(),
              //         );
              //
              //         if (picked != null) {
              //           // Format date for display
              //           String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
              //           // Format date for backend (ISO format)
              //           String isoDate = DateFormat('yyyy-MM-dd').format(picked);
              //
              //           // Update controller and value
              //           _profileInfoController.dateOfBirthCtrl.text = formattedDate;
              //           _profileInfoController.userInfo.value.dataOfBirth = formattedDate;
              //         }
              //       } : null,
              //       child: Container(
              //         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              //         decoration: BoxDecoration(
              //           border: Border.all(color: Colors.grey[300]!),
              //           borderRadius: BorderRadius.circular(8),
              //         ),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               _profileInfoController.userInfo.value.dataOfBirth ??
              //                   AppStrings.notSet.tr,
              //               style: TextStyle(
              //                 color: _profileInfoController.userInfo.value.dataOfBirth != null ?
              //                 AppColors.blackColor : Colors.grey,
              //               ),
              //             ),
              //             if (isEditable) Icon(Icons.calendar_today, size: 20),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.dateOfBirth,
                    style: AppStyles.fontSize16(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: isEditable
                        ? () async {
                            DateTime initialDate;
                            try {
                              initialDate = _profileInfoController
                                          .userInfo.value.dataOfBirth !=
                                      null
                                  ? DateFormat('dd-MM-yyyy').parse(
                                      _profileInfoController
                                          .userInfo.value.dataOfBirth!)
                                  : DateTime.now();
                            } catch (e) {
                              initialDate = DateTime.now();
                            }

                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: initialDate,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );

                            if (picked != null) {
                              // Format date as dd-MM-yyyy
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(picked);
                              print("DOB==================>" + formattedDate);
                              setState(() {
                                _profileInfoController.dateOfBirthCtrl.text =
                                    formattedDate;
                                _profileInfoController
                                    .userInfo.value.dataOfBirth = formattedDate;
                              });
                            }
                          }
                        : null,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _profileInfoController.userInfo.value.dataOfBirth ??
                                AppStrings.notSet.tr,
                            style: TextStyle(
                              color: _profileInfoController
                                          .userInfo.value.dataOfBirth !=
                                      null
                                  ? AppColors.blackColor
                                  : Colors.grey,
                            ),
                          ),
                          if (isEditable) Icon(Icons.calendar_today, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.0),
              isEditable
                  ? CustomButton(
                      onTap: () {
                        _profileInfoController.updateProfile();
                      },
                      text: AppStrings.saveChanges,
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

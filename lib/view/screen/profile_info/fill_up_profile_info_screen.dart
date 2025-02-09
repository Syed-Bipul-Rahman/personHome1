import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:home_health_app/helpers/route.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../controller/settings/profileInfoController.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../base/borderless_custom_textField.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';

class FillUpProfileInfoScreen extends StatefulWidget {
  @override
  State<FillUpProfileInfoScreen> createState() =>
      _FillUpProfileInfoScreenState();
}

class _FillUpProfileInfoScreenState extends State<FillUpProfileInfoScreen> {

  final ProfileInfoController _profileInfoController =
  Get.put(ProfileInfoController());
  var userid;
  var userToken;


  PlatformFile? _pickedImage;


  Future<void> _pickImage() async {
    // Request storage permissions
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.photos,
      Permission.mediaLibrary,
    ].request();

    bool hasPermission = statuses.values.any((status) => status.isGranted);

    if (hasPermission) {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: false,
        );

        if (result != null) {
          setState(() {
            _pickedImage = result.files.first;
            _profileInfoController.imagePath?.value= _pickedImage!.path!;

            print("Image picked successfully: ${_pickedImage?.path}");
          });
        } else {
          print("No image selected");
        }
      } catch (e) {
        print("Error picking image: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error picking image. Please try again."),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Permission Required"),
            content: Text(
                "Storage permission is required to pick an image. Please enable it in app settings."
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  AppSettings.openAppSettings();
                  Navigator.of(context).pop();
                },
                child: Text("Open Settings"),
              ),
            ],
          );
        },
      );
    }
  }

@override
  void initState() {
    //get token and user id from arguments
    final arguments = Get.arguments;
    userid = arguments['userId'];
    userToken = arguments['userToken'];
    print('=========> User ID: $userid');
    print('=========> User Token: $userToken');

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.fillYourProfile,
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
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // CircleAvatar to display the picked image or default icon
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[300],
                          child: _pickedImage != null
                              ? ClipOval(
                            child: Image.file(
                              File(_pickedImage!.path!),
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          )
                              : const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey,
                          ),
                        ),

                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black38),
                              ),
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.camera_alt,
                                size: 20,
                                color: Colors.black38,
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                    const SizedBox(height: 16),
                    // Text label
                    CustomText(
                      text: AppStrings.uploadProfilePicture.tr,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ================================Gender===============================
                    InputDecorator(
                      decoration: InputDecoration(
                        fillColor: AppColors.fillColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.w),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.w),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.w),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          iconDisabledColor: AppColors.primaryColor,
                          icon: Icon(Icons.arrow_drop_down_outlined),
                          iconEnabledColor: AppColors.primaryColor,
                          isExpanded: true,
                          value: _profileInfoController.selectedGender.value.isEmpty
                              ? null
                              : _profileInfoController.selectedGender.value,
                          hint: Text('Select'),
                          items: _profileInfoController.gender.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _profileInfoController.selectedGender.value = newValue ?? '';
                              print('=========> Selected Gender : ${_profileInfoController.selectedGender}');
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    // ================================Date of Birth===============================
                    BorderlessCustomTextField(
                      hintText: AppStrings.dateOfBirth,
                      suffixIcons: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.calendar_today),
                      ),
                      controller: _profileInfoController.dOBcTRL,
                    ),
                    SizedBox(height: 8.h),
                    // ================================Mobile Number Text Field===============================
                    BorderlessCustomTextField(
                      hintText: AppStrings.mobileNumber,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      controller: _profileInfoController.phoneNumCTRL,
                    ),
                    SizedBox(height: 8.h),
                    // ================================Address Text Field===============================
                    BorderlessCustomTextField(
                      hintText: AppStrings.address,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      controller: _profileInfoController.addressCTRL,
                    ),

                    const SizedBox(height: 16),
                    // Text label
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.locationPickerScreen,parameters: {
                          'userToken': userToken,
                        });
                      },
                      child: CustomText(
                        text: AppStrings.pickupFromMap.tr,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    onTap: () {

                      _profileInfoController.updateProfileInfo(userid);

                    },
                    text: AppStrings.continueText.tr,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
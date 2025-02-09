import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_health_app/utils/app_colors.dart';
import 'package:home_health_app/utils/style.dart';
import 'package:home_health_app/view/screen/auth/join_as_screen.dart';

class OnboardingScreen extends StatefulWidget {
@override
_OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  // Onboarding content
  final List<Map<String, String>> _onboardingData = [
    {
      'image': 'assets/images/caregiverOne.png',
      'title': 'Find personal caregivers',
    },
    {
      'image': 'assets/images/caregiverTwo.png',
      'title': 'Help with Homemaking tasks',
    },
    {
      'image': 'assets/images/caregiverThree.png',
      'title': 'Professional health care',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPage(
                image: _onboardingData[index]['image']!,
                title: _onboardingData[index]['title']!,
              );
            },
          ),
          // Skip Button
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () {},
              child: Text(
                'Skip',style: AppStyles.fontSize14(color: AppColors.colorA1A8B0),
                ),
              ),
            ),

          Positioned(
            bottom: 90,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Page Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    _onboardingData.length,
                        (index) => _buildDot(index),
                  ),
                ),
                ElevatedButton(
                  onPressed: _currentPage == _onboardingData.length - 1
                      ? () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => JoinAsScreen()),
                    );
                  }
                      : () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 3),
                      curve: Curves.ease,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.all(15.r),
                    shape: CircleBorder(),
                  ),
                  child: Icon(
                    _currentPage == _onboardingData.length - 1
                        ? Icons.arrow_forward_outlined
                        : Icons.arrow_forward_outlined,
                    size: 24,
                    color: AppColors.whiteColor, // Icon color
                  ),
                ),

              ],
            ),
          )

        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      height: 4.h,
      width: 15.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(56.r)),
        color: _currentPage == index ? AppColors.primaryColor : Colors.grey,
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;


  OnboardingPage({
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 417.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),

          SizedBox(height: 40),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 20),

        ],
      ),
    );
  }
}


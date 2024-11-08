import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management_mobile/constants/constant.dart';
import 'package:laundry_management_mobile/screens/authentication/signin_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const SignInScreen()));
              }, //to login screen. We will update later
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: [
              CreatePage(
                image: 'assets/images/machine.jpeg',
                title: Constants.titleOne,
                description: Constants.descriptionOne,
              ),
              CreatePage(
                image: 'assets/images/fer.jpeg',
                title: Constants.titleTwo,
                description: Constants.descriptionTwo,
              ),
              CreatePage(
                image: 'assets/images/basket.jpeg',
                title: Constants.titleThree,
                description: Constants.descriptionThree,
              ),
            ],
          ),
          Positioned(
            bottom: 80.h,
            left: 30.w,
            child: Row(
              children: _buildIndicator(),
            ),
          ),
          Positioned(
            bottom: 60.h,
            right: 30.w,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Constants.darkBlueColor,
              ),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (currentIndex < 2) {
                        currentIndex++;
                        if (currentIndex < 3) {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        }
                      } else {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => const SignInScreen()));
                      }
                    });
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 24.sp,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  //Extra Widgets

  //Create the indicator decorations widget
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10.h,
      width: isActive ? 20.w : 8.w,
      margin: EdgeInsets.only(right: 5.w),
      decoration: BoxDecoration(
        color: Constants.darkBlueColor,
        borderRadius: BorderRadius.circular(5.r),
      ),
    );
  }

//Create the indicator list
  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}

class CreatePage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const CreatePage({
    super.key,
    required this.image,
    required this.title,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 50.w, right: 50.w, bottom: 80.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200.h,
            child: Image.asset(image),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Constants.darkBlueColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 8.h
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style:TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey
            ),
          ),
          SizedBox(
            height: 15.h
          ),
        ],
      ),
    );
  }
}
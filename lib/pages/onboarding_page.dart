import 'package:edu_vista/pages/login_page.dart';
import 'package:edu_vista/services/pref.service.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/widgets/custom_elevated_button.dart';
import 'package:edu_vista/widgets/onboarding/elevated_button_rounded.dart';
import 'package:edu_vista/widgets/onboarding/onboard_indicator.dart';
import 'package:edu_vista/utils/image_utility.dart';
import 'package:edu_vista/widgets/onboarding/onboard_item_widget.dart';
import 'package:flutter/material.dart';

// Your Flutter code with potential adjustments
// Your Flutter code with added SingleChildScrollView for scrolling
class OnBoardingPage extends StatefulWidget {
  static const String id = 'OnBoardingPage';

  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late final PageController _pageController;
  int currentIndex = 0;

  final _kDuration = const Duration(milliseconds: 300);
  final _kCurve = Curves.ease;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (currentIndex != 0)
                      TextButton(
                        onPressed: () {
                          _skipFunction(currentIndex - 1);
                        },
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    if (currentIndex != 3)
                      TextButton(
                        onPressed: () {
                          _skipFunction(3);
                        },
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: onChangedFunction,
                  children: const <Widget>[
                    OnBoardItemWidget(
                      title: 'Certification and Badges',
                      image: ImageUtility.badges,
                      description: 'Earn a certificate after completion of every course',
                      imageHeight: 180,
                    ),
                    OnBoardItemWidget(
                      title: 'Progress Tracking',
                      image: ImageUtility.progresTraking,
                      description: 'Check your progress in every course',
                      imageHeight: 180,
                    ),
                    OnBoardItemWidget(
                      title: 'Offline Access',
                      image: ImageUtility.offLine,
                      description: 'Access your courses offline',
                      imageHeight: 180,
                    ),
                    OnBoardItemWidget(
                      title: 'Course Catalog',
                      image: ImageUtility.courseCatalog,
                      description: 'View the catalog of available courses',
                      imageHeight: 180,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Row(
                        children: [
                          OnBoardIndicator(
                            positionIndex: index,
                            currentIndex: currentIndex,
                          ),
                          if (index < 3) const SizedBox(width: 10),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  getButtons(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getButtons() {
    return currentIndex == 3
        ? CustomElevatedButton(
            onPressed: onLogin,
            text: 'Login',
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentIndex != 0)
                  ElevatedButtonRounded(
                    onPressed: previousFunction,
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                    backgroundColor: WidgetStateProperty.all<Color>(
                      ColorUtility.grayLight,
                    ),
                  ),
                ElevatedButtonRounded(
                  onPressed: nextFunction,
                  icon: const Icon(
                    Icons.arrow_forward,
                    size: 30,
                  ),
                  backgroundColor: WidgetStateProperty.all<Color>(
                    ColorUtility.deepYellow,
                  ),
                ),
              ],
            ),
          );
  }

  void nextFunction() {
    _pageController.nextPage(duration: _kDuration, curve: _kCurve);
  }

  void previousFunction() {
    _pageController.previousPage(duration: _kDuration, curve: _kCurve);
  }

  void _skipFunction(int index) {
    _pageController.jumpToPage(index);
  }

  void onLogin() {
    PreferencesService.isOnBoardingSeen = true;
    Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
  }
}
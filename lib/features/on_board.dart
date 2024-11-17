import 'package:flutter/material.dart';
import 'package:kaku/features/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaku/utils/extension/int_sized.dart';
import 'package:kaku/utils/extension/string.dart';
import 'package:kaku/utils/extension/widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final onboardingData = [
    {
      "image": "assets/image1.png",
      "title": "Be Yourself, Stand Out from the Crowd",
      "description": "Tell your story. Share your interests, hobbies, and what you’re looking for.",
    },
    {
      "image": "assets/image2.png",
      "title": "Find Your Perfect Match Today",
      "description": "Discover real connections with Kaku intelligent matchmaking.",
    },
    {
      "image": "assets/image3.png",
      "title": "Connect, Discover, Thrive",
      "description": "Join a vibrant community where connections flourish and trends emerge.",
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemCount: onboardingData.length,
        itemBuilder: (context, index) {
          final data = onboardingData[index];
          return Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ClipPath(
                  clipper: GradientCurveClipper(),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF9C27B0), Color(0xFF7B1FA2)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Center(child: Image.asset(data["image"]!)),
                  ),
                ),
              ),
              Column(
                children: [
                  Spacer(),
                  data["title"]!.boldText(fontSize: 20).center(),
                  8.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: data["description"]!.text(fontSize: 16, color: Colors.grey).center(),
                  ),
                  200.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingData.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        height: 5,
                        width: 60,
                        decoration: BoxDecoration(
                          color: _currentPage == index ? Colors.purple : Colors.purple.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  24.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7B1FA2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        fixedSize: const Size(double.infinity, 55),
                      ),
                      child: (_currentPage == onboardingData.length - 1 ? 'Get Started' : 'Next')
                          .boldText(color: Colors.white),
                    ),
                  ),
                  24.height,
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class GradientCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height - 50)
      ..quadraticBezierTo(size.width * 0.5, size.height, size.width, size.height - 50)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

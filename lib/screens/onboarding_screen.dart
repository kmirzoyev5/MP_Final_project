import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Premium Coffee',
      'description': 'Discover the finest coffee from expert baristas and get it delivered fresh to your doorstep.',
      'image': 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'Fast Delivery',
      'description': 'Hot coffee delivered to your home, office, or wherever you are.',
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'Live Tracking',
      'description': 'Real-time tracking of your coffee order from brew to delivery.',
      'image': 'https://images.unsplash.com/photo-1442512595331-e89e73853f31?auto=format&fit=crop&w=800&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(_pages[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _pages[index]['title']!,
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _pages[index]['description']!,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.grey[600],
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 48,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(
                    _pages.length,
                    (index) => Container(
                      margin: const EdgeInsets.only(right: 8),
                      height: 8,
                      width: _currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage == _pages.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

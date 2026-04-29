import 'package:flutter/material.dart';

void main() {
  runApp(const RealfrndApp());
}

class RealfrndApp extends StatelessWidget {
  const RealfrndApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Realfrnd App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE91E63), // Pink theme for dating/friendship
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "किस्मत या App?",
      "description": "कभी सोचा है… कुछ लोग किस्मत से मिलते हैं, और कुछ एक App से?",
      "icon": "favorite_border"
    },
    {
      "title": "अपने की तलाश",
      "description": "ज़िंदगी की भीड़ में हर कोई किसी अपने को ढूंढ रहा है…\nकोई दोस्त… कोई हमसफ़र…",
      "icon": "people_outline"
    },
    {
      "title": "नई शुरुआत",
      "description": "Realfrnd App सिर्फ एक App नहीं…\nये नई दोस्ती का दरवाज़ा है।",
      "icon": "door_front_door_outlined"
    }
  ];

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case "favorite_border":
        return Icons.favorite_border;
      case "people_outline":
        return Icons.people_outline;
      case "door_front_door_outlined":
        return Icons.door_front_door_outlined;
      default:
        return Icons.star_border;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFCE4EC), // Light pink
              Color(0xFFF8BBD0), // Darker pink
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getIcon(onboardingData[index]["icon"]!),
                          size: 120,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 40),
                        Text(
                          onboardingData[index]["title"]!,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          onboardingData[index]["description"]!,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingData.length,
                  (index) => buildDot(index, context),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage == onboardingData.length - 1) {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      _currentPage == onboardingData.length - 1
                          ? "अभी डाउनलोड करें"
                          : "आगे बढ़ें",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: _currentPage == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _currentPage == index
            ? Theme.of(context).colorScheme.primary
            : Colors.grey.shade400,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realfrnd App'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.celebration, size: 80, color: Colors.pink),
              SizedBox(height: 20),
              Text(
                'आपकी नई कहानी की शुरुआत!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'यहाँ मिलेंगे नए लोग, नई बातें, और हर दिन नया एहसास।',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

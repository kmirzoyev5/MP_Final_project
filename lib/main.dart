import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/product_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'screens/onboarding_screen.dart';

import 'providers/favorites_provider.dart';
import 'providers/address_provider.dart';
import 'providers/admin_provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const CoffeeShopApp());
}

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => ProductProvider()),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => FavoritesProvider()),
        ChangeNotifierProvider(create: (ctx) => OrderProvider()),
        ChangeNotifierProvider(create: (ctx) => AddressProvider()),
        ChangeNotifierProvider(create: (ctx) => AdminProvider()),
      ],
      child: MaterialApp(
        title: 'Coffee Shop App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.brown,
          primaryColor: const Color(0xFF6F4E37),
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          useMaterial3: true,
        ),
        home: const OnboardingScreen(),
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        ],
      ),
    );
  }
}

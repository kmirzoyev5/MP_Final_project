import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'screens/onboarding_screen.dart';

import 'providers/favorites_provider.dart';
import 'providers/address_provider.dart';

void main() {
  runApp(const CoffeeShopApp());
}

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => FavoritesProvider()),
        ChangeNotifierProvider(create: (ctx) => AddressProvider()),
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../pages/home_screen.dart';

final menu = [
  {
    'icon': Iconsax.home,
    'destination': const CoffeeAppHomeScreen(),
  },
  {
    'icon': Iconsax.heart ,
    'destination': const Center(child: Text('Favorite')),
  },
  {
    'icon': Iconsax.shopping_bag,
    'destination': const Center(child: Text('Shopping')),
  },
  {
    'icon':Iconsax.notification,
    'destination': const Center(child: Text('Notification')),
  },
];
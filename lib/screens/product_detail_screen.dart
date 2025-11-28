import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            leading: IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_back, color: Colors.black),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              Consumer<FavoritesProvider>(
                builder: (ctx, favorites, child) => IconButton(
                  icon: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      favorites.isFavorite(product.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () {
                    favorites.toggleFavorite(product.id);
                  },
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.shopping_cart, color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Consumer<CartProvider>(
                      builder: (ctx, cart, child) => cart.itemCount > 0
                          ? CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.red,
                              child: Text(
                                cart.itemCount.toString(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}

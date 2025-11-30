import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/favorites_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  // We need the list of all products to filter favorites.
  // Ideally this should come from a ProductsProvider.
  // For now we'll pass it or duplicate the mock data (duplication for simplicity here).
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final allProducts = Provider.of<ProductProvider>(context).products;
    final favoriteProducts = allProducts
        .where((prod) => favoritesProvider.isFavorite(prod.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: favoriteProducts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No favorites yet',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(24),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: favoriteProducts[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: favoriteProducts[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

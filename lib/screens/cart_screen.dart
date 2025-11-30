import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Your Cart',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) {
                var cartItem = cart.items.values.toList()[i];
                var productId = cart.items.keys.toList()[i];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(cartItem.imageUrl),
                      ),
                      title: Text(
                        cartItem.name,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (cartItem.size != null)
                            Text(
                              'Size: ${cartItem.size}',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          Text(
                            'Total: \$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              cart.removeSingleItem(productId);
                            },
                          ),
                          Text(
                            '${cartItem.quantity}x',
                            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              cart.incrementItem(productId);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (cart.items.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Your cart is empty!')),
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CheckoutScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Checkout',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}

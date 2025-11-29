import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context); // Listen to changes

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Your Cart', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: cart.items.isEmpty 
              ? const Center(child: Text("Cart is empty"))
              : ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) {
                  var item = cart.items.values.toList()[i];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(backgroundImage: NetworkImage(item.imageUrl)), // Assuming URL is valid
                      title: Text(item.name),
                      subtitle: Text("\$${(item.price * item.quantity).toStringAsFixed(2)}"),
                      trailing: Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    IconButton(
      icon: const Icon(Icons.remove), 
      onPressed: () => cart.removeSingleItem(item.id),
    ),
    Text('${item.quantity}'),
    IconButton(
      icon: const Icon(Icons.add), 
      onPressed: () => cart.incrementItem(item.id),
    ),
  ],
),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.brown,
                  ),
                  child: Text(
                    'Total: \$${cart.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
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
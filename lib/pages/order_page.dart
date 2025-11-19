import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // Example order items
  final List<Map<String, dynamic>> items = [
    {"name": "Burger", "price": 25000, "qty": 0},
    {"name": "Fries", "price": 12000, "qty": 0},
    {"name": "Cola", "price": 9000, "qty": 0},
  ];

  int get totalPrice {
    int sum = 0;
    for (var item in items) {
      sum += item["price"] * item["qty"];
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Page"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, i) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(items[i]["name"]),
                    subtitle: Text("${items[i]["price"]} so'm"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (items[i]["qty"] > 0) items[i]["qty"]--;
                            });
                          },
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        Text("${items[i]["qty"]}"),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              items[i]["qty"]++;
                            });
                          },
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Total Price Section
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "$totalPrice so'm",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Order Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // You can add navigation or API call here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Order placed!")),
                  );
                },
                child: const Text("Place Order"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool deliverSelected = true;
  int quantity = 1;
  String note = ""; // placeholder for note

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios, size: 18),
        title: const Text("Order", style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// TAB SWITCH – Deliver / Pick Up
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  _deliveryTab("Deliver", deliverSelected, () {
                    setState(() => deliverSelected = true);
                  }),
                  _deliveryTab("Pick Up", !deliverSelected, () {
                    setState(() => deliverSelected = false);
                  }),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// DELIVERY ADDRESS
            const Text("Delivery Address",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Jl. Kpg Sutoyo",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 3),
                  Text(
                    "Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai.",
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      _smallButton(Icons.edit, "Edit Address"),
                      const SizedBox(width: 10),
                      _smallButton(Icons.note_add_outlined, "Add Note"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// PRODUCT ITEM CARD
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "https://via.placeholder.com/60",
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),

                  /// NAME + QUANTITY
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Caffe Mocha",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 2),
                        Text("Deep Foam",
                            style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      _qtyBtn(Icons.remove, () {
                        if (quantity > 1) setState(() => quantity--);
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(quantity.toString(),
                            style: const TextStyle(fontSize: 16)),
                      ),
                      _qtyBtn(Icons.add, () {
                        setState(() => quantity++);
                      }),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            /// DISCOUNT
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.local_offer_outlined, color: Colors.orange),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text("1 Discount is Applied",
                        style: TextStyle(fontSize: 14)),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 14)
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// PAYMENT SUMMARY
            const Text("Payment Summary",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _priceRow("Price", "\$ 4.53"),
                  const SizedBox(height: 6),
                  _priceRow("Delivery Fee", deliverSelected ? "\$ 1.0" : "\$ 0.0", oldPrice: "\$ 2.0"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// PAYMENT METHOD
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.account_balance_wallet_outlined, color: Colors.orange),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text("Cash/Wallet",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                  ),
                  Text("\$ 5.53",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                  SizedBox(width: 5),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ORDER BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showOrderSummary();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffC87959),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text("Order",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- WIDGET HELPERS -----------------

  Widget _deliveryTab(String title, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? const Color(0xffC87959) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
                color: active ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _smallButton(IconData icon, String text) {
    return GestureDetector(
      onTap: () {
        if (text == "Edit Address") {
          _showEditAddressDialog();
        } else if (text == "Add Note") {
          _showAddNoteDialog();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 5),
            Text(text, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }

  Widget _priceRow(String title, String price, {String? oldPrice}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 14, color: Colors.black87)),
        Row(
          children: [
            if (oldPrice != null)
              Text(
                oldPrice,
                style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                    fontSize: 12),
              ),
            const SizedBox(width: 5),
            Text(price,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  /// ---------------- DIALOGS -----------------

  void _showEditAddressDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Address"),
        content: const Text("This is a placeholder for editing address."),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"))
        ],
      ),
    );
  }

  void _showAddNoteDialog() {
    TextEditingController controller = TextEditingController(text: note);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Note"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter your note"),
        ),
        actions: [
          TextButton(
              onPressed: () {
                setState(() => note = controller.text);
                Navigator.pop(context);
              },
              child: const Text("Save")),
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
        ],
      ),
    );
  }

  void _showOrderSummary() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Order Summary"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Item: Caffe Mocha x $quantity"),
            Text("Note: ${note.isEmpty ? 'No note' : note}"),
            Text("Delivery: ${deliverSelected ? 'Deliver' : 'Pick Up'}"),
            const SizedBox(height: 10),
            const Text("Total: \$5.53") // placeholder total
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"))
        ],
      ),
    );
  }
}

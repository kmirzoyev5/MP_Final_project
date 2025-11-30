import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/address_provider.dart';

class AddressScreen extends StatelessWidget {
  final bool isSelectionMode;

  const AddressScreen({super.key, this.isSelectionMode = false});

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);
    final addresses = addressProvider.addresses;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shipping Address',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: addresses.isEmpty
          ? Center(
              child: Text(
                'No addresses added yet.',
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return InkWell(
                  onTap: isSelectionMode
                      ? () {
                          Navigator.pop(context, index);
                        }
                      : null,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelectionMode
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300]!,
                        width: isSelectionMode ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                address['label']!,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                address['address']!,
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!isSelectionMode)
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                            onPressed: () {
                              addressProvider.removeAddress(index);
                            },
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddAddressDialog(context),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAddAddressDialog(BuildContext context) {
    final labelController = TextEditingController();
    final addressController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Add New Address', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: labelController,
              decoration: const InputDecoration(labelText: 'Label (e.g., Home, Work)'),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Full Address'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (labelController.text.isNotEmpty && addressController.text.isNotEmpty) {
                Provider.of<AddressProvider>(context, listen: false)
                    .addAddress(labelController.text, addressController.text);
                Navigator.pop(ctx);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

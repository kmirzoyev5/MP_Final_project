import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../models/order.dart';

class LiveOrdersScreen extends StatelessWidget {
  const LiveOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Live Orders',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .orderBy('dateTime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No orders found',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final order = OrderModel.fromFirestore(
                doc.data() as Map<String, dynamic>,
                doc.id,
              );

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order #${order.id.substring(0, 8)}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(order.status).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              order.status,
                              style: GoogleFonts.poppins(
                                color: _getStatusColor(order.status),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        DateFormat('MMM dd, yyyy - HH:mm').format(order.dateTime),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      const Divider(height: 24),
                      ...order.products.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${item.quantity}x ${item.name}',
                                      style: GoogleFonts.poppins(fontSize: 14),
                                    ),
                                    if (item.size != null)
                                      Text(
                                        'Size: ${item.size}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Text(
                                '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total: \$${order.amount.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Update Status:',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          DropdownButton<String>(
                            value: order.status,
                            items: ['Pending', 'Accepted', 'Processing', 'Delivering', 'Delivered', 'Cancelled']
                                .map((status) => DropdownMenuItem(
                                      value: status,
                                      child: Text(status),
                                    ))
                                .toList(),
                            onChanged: (newStatus) {
                              if (newStatus != null) {
                                _updateOrderStatus(context, order.id, newStatus);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Accepted':
        return Colors.teal;
      case 'Processing':
        return Colors.blue;
      case 'Delivering':
        return Colors.purple;
      case 'Delivered':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Future<void> _updateOrderStatus(
    BuildContext context,
    String orderId,
    String status,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .update({'status': status});

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order $status successfully')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating order: $e')),
        );
      }
    }
  }
}

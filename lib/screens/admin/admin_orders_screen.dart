import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../providers/admin_provider.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AdminProvider>(context, listen: false).fetchAllOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders Management',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<AdminProvider>(
        builder: (context, admin, _) {
          if (admin.allOrders.isEmpty) {
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
                    'No orders yet',
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
            itemCount: admin.allOrders.length,
            itemBuilder: (context, index) {
              final order = admin.allOrders[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.all(16),
                  childrenPadding: const EdgeInsets.all(16),
                  title: Text(
                    'Order #${order.id.substring(0, 8)}',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('MMM dd, yyyy - HH:mm').format(order.dateTime),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${order.amount.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(order.status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          order.status,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: _getStatusColor(order.status),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  children: [
                    const Divider(),
                    const SizedBox(height: 8),
                    ...order.products.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.name,
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                            ),
                            Text(
                              'x${item.quantity}',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(width: 16),
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
                    const Divider(),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Update Status:',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
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
      case 'completed':
        return Colors.green;
      case 'Cancelled':
      case 'cancelled':
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
      await Provider.of<AdminProvider>(context, listen: false)
          .updateOrderStatus(orderId, status);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order status updated to $status')),
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

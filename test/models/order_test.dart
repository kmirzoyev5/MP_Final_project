import 'package:flutter_test/flutter_test.dart';
import 'package:food_ordering_app/models/order.dart';
import 'package:food_ordering_app/providers/cart_provider.dart';

void main() {
  group('Order Calculation Tests', () {
    test('should calculate order amount correctly with single item', () {
      // Arrange
      final products = [
        CartItem(
          id: 'p1',
          name: 'Espresso',
          price: 3.99,
          imageUrl: 'url',
          quantity: 2,
        ),
      ];

      // Act
      double amount = 0;
      for (var product in products) {
        amount += product.price * product.quantity;
      }

      // Assert
      expect(amount, 7.98);
    });

    test('should calculate order amount with multiple items', () {
      // Arrange
      final products = [
        CartItem(id: 'p1', name: 'Espresso', price: 3.99, imageUrl: 'url', quantity: 2),
        CartItem(id: 'p2', name: 'Latte', price: 5.00, imageUrl: 'url', quantity: 1),
        CartItem(id: 'p3', name: 'Cappuccino', price: 4.50, imageUrl: 'url', quantity: 3),
      ];

      // Act
      double amount = 0;
      for (var product in products) {
        amount += product.price * product.quantity;
      }

      // Assert
      expect(amount, 26.48);
    });

    test('should handle fractional quantities correctly', () {
      // Arrange
      final products = [
        CartItem(id: 'p1', name: 'Coffee Beans', price: 12.99, imageUrl: 'url', quantity: 2),
        CartItem(id: 'p2', name: 'Milk', price: 3.50, imageUrl: 'url', quantity: 1),
      ];

      // Act
      double amount = 0;
      for (var product in products) {
        amount += product.price * product.quantity;
       }

      // Assert
      expect(amount, closeTo(29.48, 0.01));
    });

    test('should create order with correct status', () {
      // Arrange
      final products = [
        CartItem(id: 'p1', name: 'Espresso', price: 3.99, imageUrl: 'url', quantity: 1),
      ];
      final orderDate = DateTime(2024, 11, 30, 12, 0);
      
      // Act
      final order = OrderModel(
        id: 'order123',
        amount: 3.99,
        products: products,
        dateTime: orderDate,
        status: 'Pending',
      );

      // Assert
      expect(order.id, 'order123');
      expect(order.amount, 3.99);
      expect(order.products.length, 1);
      expect(order.status, 'Pending');
      expect(order.dateTime, orderDate);
    });

    test('should handle orders with different statuses', () {
      // Arrange
      final products = [
        CartItem(id: 'p1', name: 'Latte', price: 5.00, imageUrl: 'url', quantity: 1),
      ];

      // Act
      final pendingOrder = OrderModel(
        id: 'o1',
        amount: 5.00,
        products: products,
        dateTime: DateTime.now(),
        status: 'Pending',
      );

      final completedOrder = OrderModel(
        id: 'o2',
        amount: 5.00,
        products: products,
        dateTime: DateTime.now(),
        status: 'Completed',
      );

      final canceledOrder = OrderModel(
        id: 'o3',
        amount: 5.00,
        products: products,
        dateTime: DateTime.now(),
        status: 'Canceled',
      );

      // Assert
      expect(pendingOrder.status, 'Pending');
      expect(completedOrder.status, 'Completed');
      expect(canceledOrder.status, 'Canceled');
    });

    test('should maintain product details in order', () {
      // Arrange
      final products = [
        CartItem(
          id: 'p1',
          name: 'Mocha',
          price: 5.50,
          imageUrl: 'https://example.com/mocha.jpg',
          quantity: 2,
        ),
      ];

      // Act
      final order = OrderModel(
        id: 'order456',
        amount: 11.00,
        products: products,
        dateTime: DateTime.now(),
        status: 'Pending',
      );

      // Assert
      expect(order.products[0].id, 'p1');
      expect(order.products[0].name, 'Mocha');
      expect(order.products[0].price, 5.50);
      expect(order.products[0].quantity, 2);
      expect(order.products[0].imageUrl, 'https://example.com/mocha.jpg');
    });

    test('should handle large orders', () {
      // Arrange
      final products = List.generate(
        10,
        (index) => CartItem(
          id: 'p$index',
          name: 'Coffee $index',
          price: 4.00 + index * 0.50,
          imageUrl: 'url',
          quantity: index + 1,
        ),
      );

      // Act
      double amount = 0;
      for (var product in products) {
        amount += product.price * product.quantity;
      }

      final order = OrderModel(
        id: 'largeOrder',
        amount: amount,
        products: products,
        dateTime: DateTime.now(),
        status: 'Pending',
      );

      // Assert
      expect(order.products.length, 10);
      expect(order.amount, greaterThan(0));
      expect(order.products.first.name, 'Coffee 0');
      expect(order.products.last.name, 'Coffee 9');
    });

    test('should handle zero amount order', () {
      // Arrange
      final products = <CartItem>[];

      // Act
      final order = OrderModel(
        id: 'emptyOrder',
        amount: 0.0,
        products: products,
        dateTime: DateTime.now(),
        status: 'Canceled',
      );

      // Assert
      expect(order.amount, 0.0);
      expect(order.products.isEmpty, true);
    });
  });

  group('Order Date and Time Tests', () {
    test('should store order date correctly', () {
      // Arrange
      final orderDate = DateTime(2024, 11, 30, 14, 30);
      final products = [
        CartItem(id: 'p1', name: 'Espresso', price: 3.99, imageUrl: 'url', quantity: 1),
      ];

      // Act
      final order = OrderModel(
        id: 'order789',
        amount: 3.99,
        products: products,
        dateTime: orderDate,
        status: 'Completed',
      );

      // Assert
      expect(order.dateTime.year, 2024);
      expect(order.dateTime.month, 11);
      expect(order.dateTime.day, 30);
      expect(order.dateTime.hour, 14);
      expect(order.dateTime.minute, 30);
    });

    test('should handle orders from different dates', () {
      // Arrange
      final products = [
        CartItem(id: 'p1', name: 'Latte', price: 5.00, imageUrl: 'url', quantity: 1),
      ];

      final order1 = OrderModel(
        id: 'o1',
        amount: 5.00,
        products: products,
        dateTime: DateTime(2024, 11, 1),
        status: 'Completed',
      );

      final order2 = OrderModel(
        id: 'o2',
        amount: 5.00,
        products: products,
        dateTime: DateTime(2024, 11, 30),
        status: 'Completed',
      );

      // Act
      final daysDifference = order2.dateTime.difference(order1.dateTime).inDays;

      // Assert
      expect(daysDifference, 29);
    });
  });
}

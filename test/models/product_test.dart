import 'package:flutter_test/flutter_test.dart';
import 'package:food_ordering_app/models/product.dart';

void main() {
  group('Product Model Tests', () {
    test('should create a Product instance with all required fields', () {
      // Arrange & Act
      final product = Product(
        id: '1',
        name: 'Espresso',
        description: 'Strong and bold coffee',
        price: 3.99,
        imageUrl: 'https://example.com/espresso.jpg',
        category: 'Hot Coffee',
      );

      // Assert
      expect(product.id, '1');
      expect(product.name, 'Espresso');
      expect(product.description, 'Strong and bold coffee');
      expect(product.price, 3.99);
      expect(product.imageUrl, 'https://example.com/espresso.jpg');
      expect(product.category, 'Hot Coffee');
    });

    test('should create Product from Firestore data correctly', () {
      // Arrange
      final firestoreData = {
        'name': 'Cappuccino',
        'description': 'Creamy and delicious',
        'price': 4.50,
        'imageUrl': 'https://example.com/cappuccino.jpg',
        'category': 'Hot Coffee',
      };

      // Act
      final product = Product.fromFirestore(firestoreData, 'cap123');

      // Assert
      expect(product.id, 'cap123');
      expect(product.name, 'Cappuccino');
      expect(product.description, 'Creamy and delicious');
      expect(product.price, 4.50);
      expect(product.imageUrl, 'https://example.com/cappuccino.jpg');
      expect(product.category, 'Hot Coffee');
    });

    test('should handle missing fields in Firestore data with defaults', () {
      // Arrange
      final firestoreData = <String, dynamic>{};

      // Act
      final product = Product.fromFirestore(firestoreData, 'test456');

      // Assert
      expect(product.id, 'test456');
      expect(product.name, '');
      expect(product.description, '');
      expect(product.price, 0.0);
      expect(product.imageUrl, '');
      expect(product.category, '');
    });

    test('should convert int price to double in Firestore', () {
      // Arrange
      final firestoreData = {
        'name': 'Latte',
        'description': 'Smooth milk coffee',
        'price': 5, // Integer price
        'imageUrl': 'https://example.com/latte.jpg',
        'category': 'Hot Coffee',
      };

      // Act
      final product = Product.fromFirestore(firestoreData, 'latte789');

      // Assert
      expect(product.price, isA<double>());
      expect(product.price, 5.0);
    });

    test('should convert Product to Map correctly', () {
      // Arrange
      final product = Product(
        id: '999',
        name: 'Mocha',
        description: 'Chocolate coffee blend',
        price: 5.50,
        imageUrl: 'https://example.com/mocha.jpg',
        category: 'Hot Coffee',
      );

      // Act
      final productMap = product.toMap();

      // Assert
      expect(productMap['name'], 'Mocha');
      expect(productMap['description'], 'Chocolate coffee blend');
      expect(productMap['price'], 5.50);
      expect(productMap['imageUrl'], 'https://example.com/mocha.jpg');
      expect(productMap['category'], 'Hot Coffee');
      expect(productMap.containsKey('id'), false); // ID not included in toMap
    });

    test('should handle partial Firestore data', () {
      // Arrange
      final firestoreData = {
        'name': 'Americano',
        'price': 3.00,
      };

      // Act
      final product = Product.fromFirestore(firestoreData, 'amer001');

      // Assert
      expect(product.id, 'amer001');
      expect(product.name, 'Americano');
      expect(product.price, 3.00);
      expect(product.description, '');
      expect(product.imageUrl, '');
      expect(product.category, '');
    });
  });
}

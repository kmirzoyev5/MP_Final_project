import 'package:flutter_test/flutter_test.dart';
import 'package:food_ordering_app/providers/address_provider.dart';

void main() {
  group('AddressProvider Tests', () {
    late AddressProvider addressProvider;

    setUp(() {
      addressProvider = AddressProvider();
    });

    test('should have default addresses on initialization', () {
      // Assert
      expect(addressProvider.addresses.length, 2);
      expect(addressProvider.addresses[0]['label'], 'Home');
      expect(addressProvider.addresses[1]['label'], 'Work');
    });

    test('should add new address correctly', () {
      // Arrange
      const label = 'Office';
      const address = '789 Corporate Drive\\nLos Angeles, CA 90001';

      // Act
      addressProvider.addAddress(label, address);

      // Assert
      expect(addressProvider.addresses.length, 3);
      expect(addressProvider.addresses[2]['label'], label);
      expect(addressProvider.addresses[2]['address'], address);
    });

    test('should remove address at specific index', () {
      // Arrange
      final initialCount = addressProvider.addresses.length;

      // Act
      addressProvider.removeAddress(0); // Remove Home

      // Assert
      expect(addressProvider.addresses.length, initialCount - 1);
      expect(addressProvider.addresses[0]['label'], 'Work');
    });

    test('should add multiple addresses', () {
      // Arrange
      const label1 = 'Gym';
      const address1 = '111 Fitness St\\nMiami, FL 33101';
      const label2 = 'School';
      const address2 = '222 Education Ave\\nBoston, MA 02101';

      // Act
      addressProvider.addAddress(label1, address1);
      addressProvider.addAddress(label2, address2);

      // Assert
      expect(addressProvider.addresses.length, 4);
      expect(addressProvider.addresses[2]['label'], label1);
      expect(addressProvider.addresses[3]['label'], label2);
    });

    test('should remove all addresses sequentially', () {
      // Act
      addressProvider.removeAddress(0);
      addressProvider.removeAddress(0);

      // Assert
      expect(addressProvider.addresses.isEmpty, true);
    });

    test('should maintain address data integrity after add and remove', () {
      // Arrange
      const newLabel = 'Office';
      const newAddress = '999 Test St\\nSeattle, WA 98101';
      addressProvider.addAddress(newLabel, newAddress);

      // Act
      addressProvider.removeAddress(1); // Remove Work

      // Assert
      expect(addressProvider.addresses.length, 2);
      expect(addressProvider.addresses[0]['label'], 'Home');
      expect(addressProvider.addresses[1]['label'], 'Office');
      expect(addressProvider.addresses[1]['address'], newAddress);
    });

    test('should return a copy of addresses list', () {
      // Act
      final addressesList1 = addressProvider.addresses;
      final addressesList2 = addressProvider.addresses;

      // Assert
      expect(identical(addressesList1, addressesList2), false);
      expect(addressesList1.length, addressesList2.length);
    });

    test('should handle empty label and address', () {
      // Act
      addressProvider.addAddress('', '');

      // Assert
      expect(addressProvider.addresses.length, 3);
      expect(addressProvider.addresses[2]['label'], '');
      expect(addressProvider.addresses[2]['address'], '');
    });

    test('should preserve existing addresses when adding new ones', () {
      // Arrange
      final homeAddress = addressProvider.addresses[0]['address'];
      final workAddress = addressProvider.addresses[1]['address'];

      // Act
      addressProvider.addAddress('New Place', 'New Address');

      // Assert
      expect(addressProvider.addresses[0]['address'], homeAddress);
      expect(addressProvider.addresses[1]['address'], workAddress);
    });

    test('should handle address with special characters', () {
      // Arrange
      const label = 'Café & Restaurant';
      const address = '456 Main St., Apt #12B\\nSan José, CA 95101';

      // Act
      addressProvider.addAddress(label, address);

      // Assert
      expect(addressProvider.addresses.last['label'], label);
      expect(addressProvider.addresses.last['address'], address);
    });
  });
}

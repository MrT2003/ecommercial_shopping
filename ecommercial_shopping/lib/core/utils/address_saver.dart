import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommercial_shopping/core/providers/order_provider.dart';

class AddressSaver {
  static void save(BuildContext context, WidgetRef ref) {
    final address = ref.read(addressProvider);
    final city = ref.read(cityProvider);
    final country = ref.read(countryProvider);

    if (address.isNotEmpty && city.isNotEmpty && country.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Address is stored'),
          content: Text('Address: $address, City: $city, Country: $country'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Closed'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all information!')),
      );
    }
  }
}

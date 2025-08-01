import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addressProvider = StateProvider<String>((ref) => '');
final cityProvider = StateProvider<String>((ref) => '');
final countryProvider = StateProvider<String>((ref) => '');

class AddressScreen extends ConsumerWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Fillin Address'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Trường nhập địa chỉ
            TextField(
              onChanged: (value) {
                ref.read(addressProvider.notifier).state = value;
              },
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // Trường nhập thành phố
            TextField(
              onChanged: (value) {
                ref.read(cityProvider.notifier).state = value;
              },
              decoration: InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // Trường nhập quốc gia
            TextField(
              onChanged: (value) {
                ref.read(countryProvider.notifier).state = value;
              },
              decoration: InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),
            // Nút lưu
            ElevatedButton(
              onPressed: () => _saveAddress(context, ref),
              child: Text('Lưu'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Hàm lưu thông tin nhập vào
void _saveAddress(BuildContext context, WidgetRef ref) {
  final address = ref.read(addressProvider);
  final city = ref.read(cityProvider);
  final country = ref.read(countryProvider);

  if (address.isNotEmpty && city.isNotEmpty && country.isNotEmpty) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Địa chỉ đã được lưu'),
        content:
            Text('Địa chỉ: $address, Thành phố: $city, Quốc gia: $country'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Đóng'),
          ),
        ],
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Vui lòng điền đầy đủ thông tin!')),
    );
  }
}

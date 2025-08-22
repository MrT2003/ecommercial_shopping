import 'package:ecommercial_shopping/core/providers/order_provider.dart';
import 'package:ecommercial_shopping/core/utils/address_saver.dart';
import 'package:ecommercial_shopping/presentation/widgets/order/_order_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressScreen extends ConsumerWidget {
  AddressScreen({super.key});
  final TextEditingController _addressCon = TextEditingController();
  final TextEditingController _cityCon = TextEditingController();
  final TextEditingController _countryCon = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Filling Address'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            OrderTextField(
              label: 'Address',
              hint: '123 Tan Phu Street',
              icon: Icons.location_on,
              controller: _addressCon,
              onChanged: (v) => ref.read(addressProvider.notifier).state = v,
            ),
            OrderTextField(
              label: 'City',
              hint: 'Ho Chi Minh',
              icon: Icons.location_city,
              controller: _cityCon,
              onChanged: (v) => ref.read(cityProvider.notifier).state = v,
            ),
            OrderTextField(
              label: 'Country',
              hint: 'Vietnam',
              icon: Icons.flag,
              controller: _countryCon,
              onChanged: (v) => ref.read(countryProvider.notifier).state = v,
            ),
            SizedBox(height: 32),
            // Nút lưu
            ElevatedButton(
              onPressed: () => AddressSaver.save(context, ref),
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

import 'package:ecommercial_shopping/core/services/order_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderServiceProvider = Provider<OrderService>((ref) => OrderService());

final addressProvider = StateProvider<String>((ref) => '');
final cityProvider = StateProvider<String>((ref) => '');
final countryProvider = StateProvider<String>((ref) => '');

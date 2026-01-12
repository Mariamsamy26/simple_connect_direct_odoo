import 'dart:io';
import 'package:odoo_rpc/odoo_rpc.dart';

Future<void> main() async {
  final client = OdooClient('https://erp.gosmart.eg');

  try {
    await client.authenticate('GO_Smart', 'mostafa.thabet@gosmart.eg', 'gosmart+001');

    final result = await client.callKw({
      'model': 'self.ordering',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'fields': [
          'order_id',
          'client_terminal_sequence_id',
          'fawry_reference',
          'payment_option',
          'card_number',
          'is_void',
          'is_refunded',
        ],
        'limit': 20,
      },
    });

    print('Self Ordering records:');
    print(result);
  } on OdooException catch (e) {
    print('Odoo error: $e');
    client.close();
    exit(-1);
  }

  client.close();
}

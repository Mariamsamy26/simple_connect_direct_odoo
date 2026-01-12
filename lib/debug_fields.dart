import 'package:odoo_rpc/odoo_rpc.dart';

Future<void> main() async {
  final client = OdooClient('https://erp.gosmart.eg');

  try {
    print('Authenticating...');
    await client.authenticate(
      'GO_Smart',
      'mostafa.thabet@gosmart.eg',
      'gosmart+001',
    );
    print('Authenticated successfully.');

    print('Fetching fields for model self.ordering...');
    final fields = await client.callKw({
      'model': 'self.ordering',
      'method': 'fields_get',
      'args': [],
      'kwargs': {
        'attributes': ['string', 'type'],
      },
    });

    if (fields is Map) {
      print('Available fields:');
      fields.forEach((key, value) {
        print('- $key (${value['type']}): ${value['string']}');
      });
    } else {
      print('Unexpected response format: $fields');
    }
  } on OdooException catch (e) {
    print('Odoo error: $e');
  } catch (e) {
    print('Error: $e');
  } finally {
    client.close();
  }
}

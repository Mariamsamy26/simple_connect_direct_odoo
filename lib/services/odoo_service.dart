import 'package:oddo_test/models/self_ordering.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class OdooService {
  static final OdooService _instance = OdooService._internal();
  factory OdooService() => _instance;

  late OdooClient client;
  bool _isLoggedIn = false;

  OdooService._internal() {
    client = OdooClient('https://erp.gosmart.eg');
  }

  Future<void> login({
    required String db,
    required String username,
    required String password,
  }) async {
    await client.authenticate(db, username, password);
    _isLoggedIn = true;
  }

  Future<List<SelfOrdering>> getSelfOrderingList() async {
    if (!_isLoggedIn) {
      await login(
        db: 'GO_Smart',
        username: 'mostafa.thabet@gosmart.eg',
        password: 'gosmart+001',
      );
    }

    final result = await client.callKw({
      'model': 'self.ordering',
      'method': 'search_read',
      'args': [],
      'kwargs': {'fields': SelfOrdering.fields, 'order': 'id desc'},
    });

    return List<SelfOrdering>.from(result.map((x) => SelfOrdering.fromJson(x)));
  }

  Future<int> addSelfOrdering(SelfOrdering selfOrdering) async {
    if (!_isLoggedIn) {
      await login(
        db: 'GO_Smart',
        username: 'mostafa.thabet@gosmart.eg',
        password: 'gosmart+001',
      );
    }

    final recordId = await client.callKw({
      'model': 'self.ordering',
      'method': 'create',
      'args': [selfOrdering.toJson()],
      'kwargs': {},
    });

    return recordId;
  }
}

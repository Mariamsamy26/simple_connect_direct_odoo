import 'package:flutter/material.dart';
import '../models/self_ordering.dart';
import '../services/odoo_service.dart';

class SelfOrderingProvider extends ChangeNotifier {
  final _service = OdooService();

  bool loading = false;
  String? errorMessage;
  List<SelfOrdering> orders = [];

  Future<void> loadOrders() async {
    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final raw = await _service.getSelfOrderingList();
      orders = raw;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> addSelfOrdering(SelfOrdering selfOrdering) async {
    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await _service.addSelfOrdering(selfOrdering);
      await loadOrders();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}

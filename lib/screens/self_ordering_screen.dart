import 'package:flutter/material.dart';
import 'package:oddo_test/screens/add_self_ordering.dart';
import 'package:provider/provider.dart';
import '../providers/self_ordering_provider.dart';

class SelfOrderingScreen extends StatefulWidget {
  const SelfOrderingScreen({super.key});

  @override
  State<SelfOrderingScreen> createState() => _SelfOrderingScreenState();
}

class _SelfOrderingScreenState extends State<SelfOrderingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SelfOrderingProvider>().loadOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SelfOrderingProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Self Ordering')),
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : provider.errorMessage != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error: ${provider.errorMessage}',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView.builder(
              itemCount: provider.orders.length,
              itemBuilder: (context, index) {
                final o = provider.orders[index];

                return Card(
                  child: ListTile(
                    title: Text('Order #${o.orderId}'),
                    subtitle: Text(
                      'Fawry: ${o.fawryRef}\nPayment: ${o.paymentOption}',
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (o.isVoid)
                          const Text(
                            'VOID',
                            style: TextStyle(color: Colors.red),
                          ),
                        if (o.isRefunded)
                          const Text(
                            'REFUNDED',
                            style: TextStyle(color: Colors.orange),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddSelfOrderingScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

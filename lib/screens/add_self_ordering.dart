import 'package:flutter/material.dart';
import 'package:oddo_test/models/self_ordering.dart';
import 'package:oddo_test/providers/self_ordering_provider.dart';
import 'package:provider/provider.dart';

class AddSelfOrderingScreen extends StatefulWidget {
  const AddSelfOrderingScreen({super.key});

  @override
  State<AddSelfOrderingScreen> createState() => _AddSelfOrderingScreenState();
}

class _AddSelfOrderingScreenState extends State<AddSelfOrderingScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _orderIdController = TextEditingController();
  final TextEditingController _clientTerminalIdController =
      TextEditingController();
  final TextEditingController _fawryRefController = TextEditingController();
  final TextEditingController _paymentOptionController =
      TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();

  bool _isVoid = false;
  bool _isRefunded = false;

  @override
  void dispose() {
    _orderIdController.dispose();
    _clientTerminalIdController.dispose();
    _fawryRefController.dispose();
    _paymentOptionController.dispose();
    _cardNumberController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final selfOrdering = SelfOrdering(
      orderId: _orderIdController.text.trim(),
      paymentOption: _paymentOptionController.text.trim(),
      cardNumber: _cardNumberController.text.trim(),
      isVoid: _isVoid,
      isRefunded: _isRefunded,
      terminalSeq: _clientTerminalIdController.text.trim(),
      fawryRef: _fawryRefController.text.trim(),
    );

    context.read<SelfOrderingProvider>().addSelfOrdering(selfOrdering);

    // Optional: show snackbar or pop
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Self Ordering Added')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Self Ordering')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _orderIdController,
                decoration: const InputDecoration(labelText: 'Order ID'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter order ID' : null,
              ),
              TextFormField(
                controller: _clientTerminalIdController,
                decoration: const InputDecoration(
                  labelText: 'Client Terminal Sequence ID',
                ),
                validator: (v) => v == null || v.isEmpty
                    ? 'Enter terminal sequence ID'
                    : null,
              ),
              TextFormField(
                controller: _fawryRefController,
                decoration: const InputDecoration(labelText: 'Fawry Reference'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter fawry reference' : null,
              ),
              TextFormField(
                controller: _paymentOptionController,
                decoration: const InputDecoration(labelText: 'Payment Option'),
              ),
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(labelText: 'Card Number'),
                keyboardType: TextInputType.number,
              ),
              SwitchListTile(
                title: const Text('Is Void?'),
                value: _isVoid,
                onChanged: (v) => setState(() => _isVoid = v),
              ),
              SwitchListTile(
                title: const Text('Is Refunded?'),
                value: _isRefunded,
                onChanged: (v) => setState(() => _isRefunded = v),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add Self Ordering'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

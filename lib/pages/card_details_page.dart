import 'package:flutter/material.dart';

class CardDetailsPage extends StatefulWidget {
  const CardDetailsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CardDetailsPageState createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expDateController.dispose();
    _cvvController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Card Number', style: TextStyle(fontSize: 18)),
              TextFormField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(hintText: '1234 5678 9012 3456'),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 16) {
                    return 'Please enter a valid card number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text('Exp. Date', style: TextStyle(fontSize: 18)),
              TextFormField(
                controller: _expDateController,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(hintText: 'MM/YY'),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !RegExp(r"^(0[1-9]|1[0-2])\/?([0-9]{2})$")
                          .hasMatch(value)) {
                    return 'Please enter a valid expiration date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text('CVV', style: TextStyle(fontSize: 18)),
              TextFormField(
                controller: _cvvController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: '123'),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 3) {
                    return 'Please enter a valid CVV';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text('Phone Number', style: TextStyle(fontSize: 18)),
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(hintText: '+1 123 456 7890'),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // تنفيذ عملية الدفع بعد التحقق من صحة المدخلات
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                  ),
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

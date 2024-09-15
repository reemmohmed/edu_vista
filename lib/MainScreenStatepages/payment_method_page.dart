import 'package:edu_vista/MainScreenStatepages/card_details_page.dart';
import 'package:flutter/material.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String? selectedMethod = "Card"; // القيمة الافتراضية

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Method',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          RadioListTile(
            title: Text(
              'PayPal',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            value: 'PayPal',
            groupValue: selectedMethod,
            onChanged: (value) {
              setState(() {
                selectedMethod = value.toString();
                // الانتقال إلى صفحة تفاصيل البطاقة عند اختيار أي طريقة دفع
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CardDetailsPage(),
                  ),
                );
              });
            },
          ),
          RadioListTile(
            title: Text(
              'Apple Pay',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            value: 'Apple Pay',
            groupValue: selectedMethod,
            onChanged: (value) {
              setState(() {
                selectedMethod = value.toString();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CardDetailsPage(),
                  ),
                );
              });
            },
          ),
          RadioListTile(
            title: Text(
              'Google Pay',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            value: 'Google Pay',
            groupValue: selectedMethod,
            onChanged: (value) {
              setState(() {
                selectedMethod = value.toString();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CardDetailsPage(),
                  ),
                );
              });
            },
          ),
          RadioListTile(
            title: Text(
              'Card',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xffF5BB06)),
            ),
            value: 'Card',
            groupValue: selectedMethod,
            onChanged: (value) {
              setState(() {
                selectedMethod = value.toString();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CardDetailsPage(),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}

import 'package:edu_vista/MainScreenStatepages/payment_method_page.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  static const String id = 'cart_page';

  const CartPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // قائمة المنتجات في سلة التسوق
  List<Map<String, dynamic>> cartItems = [
    {
      'title': 'Machine Learning',
      'price': 24.50,
      'imageUrl': "https://arenajayanagar.com/images/uiux.jpg",
      'quantity': 1
    },
    {
      'title': 'Wireframing',
      'price': 18.00,
      'imageUrl': "https://arenajayanagar.com/images/uiux.jpg",
      'quantity': 1
    },
    {
      'title': 'Robotics',
      'price': 18.00,
      'imageUrl': "https://arenajayanagar.com/images/uiux.jpg",
      'quantity': 1
    },
    {
      'title': 'Robotics',
      'price': 18.00,
      'imageUrl': "https://arenajayanagar.com/images/uiux.jpg",
      'quantity': 1
    },
  ];

  // متغير للتحكم في حالة التحميل
  bool _isLoading = false;

  // دالة لحساب إجمالي السعر
  double getTotalPrice() {
    return cartItems.fold(0.0, (total, current) {
      return total + (current['price'] * current['quantity']);
    });
  }

  // دالة لإزالة عنصر من السلة
  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  // دالة لزيادة الكمية
  void incrementQuantity(int index) {
    setState(() {
      cartItems[index]['quantity']++;
    });
  }

  // دالة لتقليل الكمية
  void decrementQuantity(int index) {
    if (cartItems[index]['quantity'] > 1) {
      setState(() {
        cartItems[index]['quantity']--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    leading: Image.network(
                      item['imageUrl'],
                      width: 50,
                      height: 50,
                    ),
                    title: Text(item['title']),
                    subtitle: Text('Price: \$${item['price']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => decrementQuantity(index),
                        ),
                        Text('${item['quantity']}'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => incrementQuantity(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => removeItem(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total: \$${getTotalPrice().toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null // تعطيل الزر أثناء التحميل
                        : () {
                            setState(() {
                              _isLoading = true; // تعيين حالة التحميل إلى true
                            });

                            // محاكاة عملية الشراء أو الدفع
                            Future.delayed(const Duration(seconds: 2), () {
                              setState(() {
                                _isLoading =
                                    false; // إعادة تعيين حالة التحميل إلى false
                              });
                              // فتح صفحة طرق الدفع بعد انتهاء التحميل
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentMethodPage(),
                                ),
                              );
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Checkout',
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:seller/feature_text.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Map<String, dynamic>? product;
  Duration countdown = const Duration(
    hours: 2, 
    minutes: 34, 
    seconds: 27,
  );
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchProduct();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (countdown.inSeconds > 0) {
          countdown -= const Duration(seconds: 1);
        }
      });
    });
  }

  Future<void> fetchProduct() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products/1'),
    );

    if (response.statusCode == 200) {
      setState(() {
        product = jsonDecode(response.body) as Map<String, dynamic>;
      });
    } else {
      throw Exception('Failed to load product data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeLeft = DateFormat.Hms().format(DateTime(0).add(countdown));

    return Scaffold(
      body: SafeArea(
        child: product == null
            ? const Center(
              child: CircularProgressIndicator(),
            )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: 260,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[100],
                            image: DecorationImage(
                              image:
                                  NetworkImage(product!['image'] as String),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, 
                              horizontal: 12,
                            ),
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'EXPIRES IN $timeLeft',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      (product!['title'] as String).toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '₹${product!['price'] as num}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          '₹1299',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: [
                        FeatureIconText(
                          icon: Icons.battery_charging_full,
                          label: '14 Hrs Runtime',
                        ),
                        FeatureIconText(
                          icon: Icons.surround_sound,
                          label: 'Surround Sound',
                        ),
                        FeatureIconText(
                          icon: Icons.usb,
                          label: 'USB Cable',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'About the product:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product!['description'] as String,
                      style: const TextStyle(
                        color: Colors.black87,
                      ),
                      softWrap: true,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildIconText(
                          Icons.verified, 
                          'Genuine\nProducts',
                        ),
                        buildIconText(
                          Icons.local_offer, 
                          'Limited Time\nDeals',
                        ),
                        buildIconText(
                            Icons.local_shipping, 
                            'Free\nShipping',
                          ),
                        buildIconText(
                          Icons.security, 
                          'Secure\nPayments',
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Text(
                        'Get 10% off on this purchase',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: const Text(
                              'ADD TO CART',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                            ),
                            child: const Text(
                              'BUY NOW',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Widget buildIconText(IconData icon, String label) {
    return Column(
      children: [
        Icon(
          icon, 
          size: 28,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}



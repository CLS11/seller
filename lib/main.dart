import 'package:flutter/material.dart';
import 'package:seller/products_detail_page.dart';

void main(){
  runApp(const Seller());
}

class Seller extends StatelessWidget {
  const Seller({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductDetailPage(),
    );
  }
}
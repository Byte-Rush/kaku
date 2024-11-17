import 'package:flutter/material.dart';
import 'package:kaku/utils/extension/int_sized.dart';
import 'package:kaku/utils/extension/string.dart';

import '../storage/db_helper.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DBHelper _dbHelper = DBHelper();
  List<Map<String, dynamic>> products = [];
  List<int> cartItems = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final data = await _dbHelper.fetchProducts();
    setState(() {
      products = data;
    });
  }

  void _toggleCart(int id) {
    setState(() {
      cartItems.contains(id) ? cartItems.remove(id) : cartItems.add(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: 'Shopping App'.boldText(),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => _showCart(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search for products...",
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            20.height,
            "Available Products".boldText(fontSize: 18),
            16.height,
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _buildProductCard(
                    id: product['id'],
                    name: product['name'],
                    image: product['image'],
                    price: product['price'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard({
    required int id,
    required String name,
    required String image,
    required double price,
  }) {
    final inCart = cartItems.contains(id);
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.height,
          name.boldText(),
          8.height,
          '\$$price'.text(color: Colors.green),
          Spacer(),
          ElevatedButton(
            onPressed: () => _toggleCart(id),
            style: ElevatedButton.styleFrom(
              backgroundColor: inCart ? Colors.red : Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: (inCart ? 'Remove from Cart' : 'Add to Cart').text(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showCart() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final cartProducts = products.where((p) => cartItems.contains(p['id'])).toList();
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Your Cart".boldText(fontSize: 18),
              16.height,
              Expanded(
                child: ListView.builder(
                  itemCount: cartProducts.length,
                  itemBuilder: (context, index) {
                    final product = cartProducts[index];
                    return ListTile(
                      leading: Image.asset(product['image'], width: 50, height: 50),
                      title: product['name'].boldText(),
                      subtitle: '\$${product['price']}'.text(color: Colors.green),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () => _toggleCart(product['id']),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

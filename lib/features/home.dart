import 'package:flutter/material.dart';
import 'package:kaku/utils/extension/int_sized.dart';
import 'package:kaku/utils/extension/string.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<int> cartItems = [];

  final List<Map<String, dynamic>> products = [
    {
      'id': 1,
      'name': 'Nike Air Max',
      'image': 'assets/product1.png',
      'price': 129.99,
      'description': 'Classic Nike Air Max sneakers'
    },
    {
      'id': 2,
      'name': 'Adidas Ultraboost',
      'image': 'assets/product1.png',
      'price': 159.99,
      'description': 'Premium running shoes'
    },
    {
      'id': 3,
      'name': 'Puma RS-X',
      'image': 'assets/product1.png',
      'price': 99.99,
      'description': 'Stylish casual sneakers'
    },
    {
      'id': 4,
      'name': 'New Balance 574',
      'image': 'assets/product1.png',
      'price': 89.99,
      'description': 'Comfortable everyday shoes'
    },
  ];

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
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () => _showCart(),
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cartItems.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
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
                onChanged: (value) {
                },
              ),
            ),
            20.height,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Available Products".boldText(fontSize: 18),
                "${products.length} items".text(color: Colors.grey),
              ],
            ),
            16.height,

            // Products Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _buildProductCard(
                    id: product['id'],
                    name: product['name'],
                    image: product['image'],
                    price: product['price'],
                    description: product['description'],
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
    required String description,
  }) {
    final inCart = cartItems.contains(id);
    return GestureDetector(
      onTap: () => _showProductDetails(id),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.image_not_supported, color: Colors.grey);
                  },
                ),
              ),
            ),
            // Product Details
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        name.boldText(fontSize: 14),
                        4.height,
                        '\$${price.toStringAsFixed(2)}'.text(
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () => _toggleCart(id),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: inCart ? Colors.red : Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: Size(double.infinity, 32),
                      ),
                      child: (inCart ? 'Remove' : 'Add to Cart').text(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductDetails(int id) {
    final product = products.firstWhere((p) => p['id'] == id);
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  product['image'],
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                16.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      product['name'].boldText(fontSize: 18),
                      8.height,
                      '\$${product['price']}'.text(
                        color: Colors.green,
                        fontSize: 20,
                      ),
                      8.height,
                      product['description'].text(color: Colors.grey),
                    ],
                  ),
                ),
              ],
            ),
            16.height,
            ElevatedButton(
              onPressed: () {
                _toggleCart(product['id']);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: cartItems.contains(product['id'])
                    ? Colors.red
                    : Colors.purple,
                minimumSize: Size(double.infinity, 45),
              ),
              child: (cartItems.contains(product['id'])
                  ? 'Remove from Cart'
                  : 'Add to Cart')
                  .text(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _showCart() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final cartProducts =
        products.where((p) => cartItems.contains(p['id'])).toList();
        final total = cartProducts.fold<double>(
            0, (sum, product) => sum + product['price']);

        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Your Cart".boldText(fontSize: 18),
                  "${cartProducts.length} items".text(color: Colors.grey),
                ],
              ),
              16.height,
              Expanded(
                child: cartProducts.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_outlined,
                          size: 48, color: Colors.grey),
                      16.height,
                      "Your cart is empty".text(color: Colors.grey),
                    ],
                  ),
                )
                    : ListView.separated(
                  itemCount: cartProducts.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    final product = cartProducts[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Image.asset(
                        product['image'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                      title: product['name'].boldText(),
                      subtitle:
                      '\$${product['price']}'.text(color: Colors.green),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () {
                          _toggleCart(product['id']);
                          if (cartItems.isEmpty) {
                            Navigator.pop(context);
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              if (cartProducts.isNotEmpty) ...[
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Total:".boldText(),
                    '\$${total.toStringAsFixed(2)}'
                        .boldText(color: Colors.green, fontSize: 18),
                  ],
                ),
                16.height,
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    minimumSize: Size(double.infinity, 45),
                  ),
                  child: 'Proceed to Checkout'.text(color: Colors.white),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

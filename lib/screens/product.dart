import 'dart:convert'; // For JSON decoding
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'cart.dart';

class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final double rating;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['title'],
      price: json['price'].toDouble(),
      imageUrl: json['thumbnail'],
      rating: json['rating'].toDouble(),
    );
  }
}

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  // API get product
  Future<void> _fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> productsJson = jsonResponse['products'];

      setState(() {
        _products = productsJson.map((json) => Product.fromJson(json)).toList();
        _filteredProducts = _products;
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  // search input change
  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _filteredProducts = _products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // rating as stars
  Widget _starRating(double rating) {
    int fullStars = rating.floor();
    bool halfStar = rating - fullStars >= 0.5;

    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return Icon(Icons.star, color: Colors.orange, size: 20);
        } else if (index == fullStars && halfStar) {
          return Icon(Icons.star_half, color: Colors.orange, size: 20);
        } else {
          return Icon(Icons.star_border, color: Colors.orange, size: 20);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        // spinner loading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search products',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              // product card
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = _filteredProducts[index];
                    return ListTile(
                      leading: Image.network(product.imageUrl),
                      title: Text(product.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('\$${product.price.toStringAsFixed(2)}'),
                          _starRating(product.rating),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          Provider.of<CartModel>(context, listen: false)
                              .addToCart(product);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}

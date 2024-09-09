import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product.dart';

class CartModel extends ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  double get totalPrice => _cartItems.fold(0, (sum, item) => sum + item.price);
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.cartItems.length,
                itemBuilder: (context, index) {
                  final product = cart.cartItems[index];
                  return ListTile(
                    leading: Image.network(product.imageUrl),
                    title: Text(product.name),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_shopping_cart),
                      onPressed: () {
                        cart.removeFromCart(product);
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}

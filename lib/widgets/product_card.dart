import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Center(
              child: Image.network(
                product.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
            ),
            SizedBox(height: 8),
            // Product Title
            Text(
              product.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Product Category
            Text(
              'Category: ${product.category}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            // Product Price with Discount Strikethrough
            Row(
              children: [
                if (product.discountPercentage > 0)
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                SizedBox(width: 8),
                Text(
                  '\$${(product.price - (product.price * (product.discountPercentage / 100))).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: product.discountPercentage > 0
                        ? Colors.green
                        : Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            // Product Rating
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < product.rating.round()
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.orange,
                  size: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

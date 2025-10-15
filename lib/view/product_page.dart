import 'package:flutter/material.dart';
import 'package:intervw_niveosys/model/product_model.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = ProductService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: FutureBuilder<List<Product>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found.'));
          }
          return ListView(
            children: snapshot.data!
                .map(
                  (p) => Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(p.productName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Code: ${p.productCode}'),
                          Text('Description: ${p.productDescription}'),
                          Text('Units:'),
                          ...p.units.map(
                            (u) => Text('- ${u.unit.unitName} : ${u.price}'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}

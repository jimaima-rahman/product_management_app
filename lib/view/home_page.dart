import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intervw_niveosys/model/product_model.dart';
import 'package:intervw_niveosys/provider/api_services.dart';
import 'package:intervw_niveosys/view/product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _descController = TextEditingController();

  final List<ProductUnit> _units = [];
  final _unitNameController = TextEditingController();
  final _unitPriceController = TextEditingController();

  Future<void> _saveProduct() async {
    if (_formKey.currentState!.validate() && _units.isNotEmpty) {
      final product = Product(
        productId: 0,
        productName: _nameController.text,
        productCode: _codeController.text,
        productDescription: _descController.text,
        units: _units,
      );
      bool success = false;
      try {
        success = await ProductService().addProduct(product);
        log("product saved: $success");
      } catch (e) {
        log("error saving product: $e");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? 'Product saved!' : 'Failed to save product'),
        ),
      );
      _nameController.clear();
      _codeController.clear();
      _descController.clear();
      setState(() => _units.clear());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Product Name'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Enter product name' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _codeController,
                  decoration: const InputDecoration(labelText: 'Product Code'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Enter product code' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descController,
                  decoration: const InputDecoration(
                    labelText: 'Product Description',
                  ),
                  validator: (v) => v == null || v.isEmpty
                      ? 'Enter product description'
                      : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _unitNameController,
                        decoration: const InputDecoration(
                          labelText: 'Unit amount',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    Expanded(
                      child: TextFormField(
                        controller: _unitPriceController,
                        decoration: const InputDecoration(labelText: 'Price'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                Wrap(
                  children: _units
                      .map(
                        (u) => Chip(
                          label: Text('${u.unit.unitName} : ${u.price}'),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _saveProduct,
                  child: const Text('Save Product'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProductListPage(),
                      ),
                    );
                  },
                  child: const Text('View Products'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

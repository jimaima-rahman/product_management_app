// class ProductService {
//   final Dio _dio = Dio(
//     BaseOptions(baseUrl: 'https://salesapi.niveosys.org/api/'),
//   );

//   Future<bool> addProduct(Product product) async {
//     try {
//       final response = await _dio.post('Products', data: product.toJson());
//       log('Response: ${response.data}');
//       return response.statusCode == 201 || response.statusCode == 200;
//     } catch (e) {
//       log('Error saving product: $e');
//       return false;
//     }
//   }

//   Future<List<Product>> fetchProducts() async {
//     try {
//       final response = await _dio.get('Products');
//       if (response.statusCode == 200) {
//         return (response.data as List)
//             .map((json) => Product.fromJson(json))
//             .toList();
//       }
//     } catch (e) {
//       log('Error fetching products: $e');
//     }
//     return [];
//   }
// }

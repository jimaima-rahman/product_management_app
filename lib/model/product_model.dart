class Unit {
  final int unitId;
  final String unitName;
  String? unitAbbreviation;

  Unit({required this.unitId, required this.unitName, this.unitAbbreviation});

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    unitId: json['unitId'] ?? 0,
    unitName: json['unitName'] ?? '',
    unitAbbreviation: json['unitAbbreviation'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'unitId': unitId,
    'unitName': unitName,
    'unitAbbreviation': unitAbbreviation,
  };
}

class ProductUnit {
  final int productUnitId;
  final double price;
  final Unit unit;
  final double? conversionFactor;

  ProductUnit({
    required this.productUnitId,
    required this.price,
    required this.unit,
    this.conversionFactor,
  });

  factory ProductUnit.fromJson(Map<String, dynamic> json) => ProductUnit(
    productUnitId: json['productUnitId'] ?? 0,
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    conversionFactor: (json['conversionFactor'] as num?)?.toDouble() ?? 1.0,
    unit: Unit.fromJson(json['unit'] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    'productUnitId': productUnitId,
    'price': price,
    'conversionFactor': conversionFactor,
    'unit': unit.toJson(),
  };
}

class Product {
  final int productId;
  final String productName;
  final String productCode;
  final String productDescription;
  final List<ProductUnit> units;

  Product({
    required this.productId,
    required this.productName,
    required this.productCode,
    required this.productDescription,
    required this.units,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json['productId'] ?? 1,
    productName: json['productName'] ?? '',
    productCode: json['productCode'] ?? '',
    productDescription: json['productDescription'] ?? '',
    units: (json['units'] as List? ?? [])
        .map((u) => ProductUnit.fromJson(u))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'productName': productName,
    'productCode': productCode,
    'productDescription': productDescription,
    'units': units.map((u) => u.toJson()).toList(),
  };
}

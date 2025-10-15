// class Unit {
//   final int unitId;
//   final String unitName;
//   String? unitAbbreviation;

//   Unit({required this.unitId, required this.unitName, this.unitAbbreviation});

//   factory Unit.fromJson(Map<String, dynamic> json) => Unit(
//     unitId: json['unitId'] ?? 0,
//     unitName: json['unitName'] ?? '',
//     unitAbbreviation: json['unitAbbreviation'] ?? '',
//   );

//   Map<String, dynamic> toJson() => {
//     'unitId': unitId,
//     'unitName': unitName,
//     'unitAbbreviation': unitAbbreviation,
//   };
// }

// class ProductUnit {
//   final int productUnitId;
//   final double price;
//   final Unit unit;
//   final double? conversionFactor;

//   ProductUnit({
//     required this.productUnitId,
//     required this.price,
//     required this.unit,
//     this.conversionFactor,
//   });

//   factory ProductUnit.fromJson(Map<String, dynamic> json) => ProductUnit(
//     productUnitId: json['productUnitId'] ?? 0,
//     price: (json['price'] as num?)?.toDouble() ?? 0.0,
//     conversionFactor: (json['conversionFactor'] as num?)?.toDouble() ?? 1.0,
//     unit: Unit.fromJson(json['unit'] ?? {}),
//   );

//   Map<String, dynamic> toJson() => {
//     'productUnitId': productUnitId,
//     'price': price,
//     'conversionFactor': conversionFactor,
//     'unit': unit.toJson(),
//   };
// }

// class Product {
//   final int productId;
//   final String productName;
//   final String productCode;
//   final String productDescription;
//   final List<ProductUnit> units;

//   Product({
//     required this.productId,
//     required this.productName,
//     required this.productCode,
//     required this.productDescription,
//     required this.units,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     productId: json['productId'] ?? 1,
//     productName: json['productName'] ?? '',
//     productCode: json['productCode'] ?? '',
//     productDescription: json['productDescription'] ?? '',
//     units: (json['units'] as List? ?? [])
//         .map((u) => ProductUnit.fromJson(u))
//         .toList(),
//   );

//   Map<String, dynamic> toJson() => {
//     'productId': productId,
//     'productName': productName,
//     'productCode': productCode,
//     'productDescription': productDescription,
//     'units': units.map((u) => u.toJson()).toList(),
//   };
// }

class Product {
  final int? productId;
  final String? productName;
  final String? productCode;
  final String? productDescription;
  final List<UnitItem>? units;

  Product({
    this.productId,
    this.productName,
    this.productCode,
    this.productDescription,
    this.units,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'] as int?,
      productName: json['productName'] as String?,
      productCode: json['productCode'] as String?,
      productDescription: json['productDescription'] as String?,
      units: (json['units'] as List<dynamic>?)
          ?.map((e) => UnitItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productCode': productCode,
      'productDescription': productDescription,
      'units': units?.map((e) => e.toJson()).toList(),
    };
  }
}

class UnitItem {
  final int? productUnitId;
  final double? price;
  final double? conversionFactor;
  final Unit? unit;

  UnitItem({this.productUnitId, this.price, this.conversionFactor, this.unit});

  factory UnitItem.fromJson(Map<String, dynamic> json) {
    return UnitItem(
      productUnitId: json['productUnitId'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      conversionFactor: (json['conversionFactor'] as num?)?.toDouble(),
      unit: json['unit'] != null
          ? Unit.fromJson(json['unit'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productUnitId': productUnitId,
      'price': price,
      'conversionFactor': conversionFactor,
      'unit': unit?.toJson(),
    };
  }
}

class Unit {
  final int? unitId;
  final String? unitName;
  final String? unitAbbreviation;

  Unit({this.unitId, this.unitName, this.unitAbbreviation});

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      unitId: json['unitId'] as int?,
      unitName: json['unitName'] as String?,
      unitAbbreviation: json['unitAbbreviation'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unitId': unitId,
      'unitName': unitName,
      'unitAbbreviation': unitAbbreviation,
    };
  }
}

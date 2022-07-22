import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddProductModel {
  String productName;
  String productId;
  String qty;
  String batch;
  String freeQty;
  AddProductModel({
    required this.batch,
    required this.productName,
    required this.productId,
    required this.qty,
    required this.freeQty,
  });

  Map<String, String> toMap() {
    return <String, String>{
      // 'productName': productName.toString(),
      'product': productId.toString(),
      'qty': qty.toString(),
      'freeQty': freeQty.toString(),
    };
  }

  Map<String, String> toRetailerMap() {
    return <String, String>{
      // 'productName': productName.toString(),
      'product': productId.toString(),
      'qty': qty.toString(),
      // 'freeQty': freeQty.toString(),
    };
  }

  Map<String, String> toStockMap() {
    return <String, String>{
      // 'productName': productName.toString(),
      'product': productId.toString(),
      'qty': qty.toString(),
      "batchid": batch.toString(),
      // 'freeQty': freeQty.toString(),
    };
  }

  factory AddProductModel.fromMap(Map<String, dynamic> map) {
    return AddProductModel(
        productName: map['productName'] as String,
        productId: map['productId'] as String,
        qty: map['qty'] as String,
        freeQty: map['freeQty'] as String,
        batch: map["batch"]);
  }

  String toJson() => json.encode(toMap());

  factory AddProductModel.fromJson(String source) =>
      AddProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  AddProductModel copyWith({
    String? productName,
    String? productId,
    String? qty,
    String? freeQty,
  }) {
    return AddProductModel(
      productName: productName ?? this.productName,
      productId: productId ?? this.productId,
      // qty: qty??1,
      freeQty: freeQty ?? this.freeQty, qty: qty!, batch: '',
    );
  }

  @override
  String toString() {
    return 'AddProductModel(productName: $productName, productId: $productId, qty: $qty, freeQty: $freeQty)';
  }

  @override
  bool operator ==(covariant AddProductModel other) {
    if (identical(this, other)) return true;

    return other.productName == productName &&
        other.productId == productId &&
        other.qty == qty &&
        other.freeQty == freeQty;
  }

  @override
  int get hashCode {
    return productName.hashCode ^
        productId.hashCode ^
        qty.hashCode ^
        freeQty.hashCode;
  }
}

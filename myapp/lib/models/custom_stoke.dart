// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';



class CustomStokeData {
  String? stokeId;
  String? distributor;
  String? statedate;
  List<CustomStokeDownData>? meta;
  CustomStokeData({
    this.stokeId,
    this.distributor,
    this.statedate,
    this.meta,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stokeId': stokeId,
      'distributor': distributor,
      'statedate': statedate,
      'meta': meta!.map((x) => x.toMap()).toList(),
    };
  }

  factory CustomStokeData.fromMap(Map<String, dynamic> map) {
    return CustomStokeData(
      stokeId: map['stokeId'] != null ? map['stokeId'] as String : null,
      distributor: map['distributor'] != null ? map['distributor'] as String : null,
      statedate: map['statedate'] != null ? map['statedate'] as String : null,
      meta: map['meta'] != null ? List<CustomStokeDownData>.from((map['meta'] as List<int>).map<CustomStokeDownData?>((x) => CustomStokeDownData.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomStokeData.fromJson(String source) => CustomStokeData.fromMap(json.decode(source) as Map<String, dynamic>);

  CustomStokeData copyWith({
    String? stokeId,
    String? distributor,
    String? statedate,
    List<CustomStokeDownData>? meta,
  }) {
    return CustomStokeData(
      stokeId: stokeId ?? this.stokeId,
      distributor: distributor ?? this.distributor,
      statedate: statedate ?? this.statedate,
      meta: meta ?? this.meta,
    );
  }
}

class CustomStokeDownData {
  String? product;
  String? qty;
  String? batch;
  String? price;
  String? ndp;
  CustomStokeDownData({
    this.product,
    this.qty,
    this.batch,
    this.price,
    this.ndp,
  });

  CustomStokeDownData copyWith({
    String? product,
    String? qty,
    String? batch,
    String? price,
    String? ndp,
  }) {
    return CustomStokeDownData(
      product: product ?? this.product,
      qty: qty ?? this.qty,
      batch: batch ?? this.batch,
      price: price ?? this.price,
      ndp: ndp ?? this.ndp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product,
      'qty': qty,
      'batch': batch,
      'price': price,
      'ndp': ndp,
    };
  }

  factory CustomStokeDownData.fromMap(Map<String, dynamic> map) {
    return CustomStokeDownData(
      product: map['product'] != null ? map['product'] as String : null,
      qty: map['qty'] != null ? map['qty'] as String : null,
      batch: map['batch'] != null ? map['batch'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      ndp: map['ndp'] != null ? map['ndp'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomStokeDownData.fromJson(String source) => CustomStokeDownData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomStokeDownData(product: $product, qty: $qty, batch: $batch, price: $price, ndp: $ndp)';
  }
}

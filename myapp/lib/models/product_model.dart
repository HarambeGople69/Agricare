class ProductDataResponseModel {
  Productdataa? productdataa;

  ProductDataResponseModel({this.productdataa});

  ProductDataResponseModel.fromJson(Map<String, dynamic> json) {
    productdataa = json['productdataa'] != null
        ? new Productdataa.fromJson(json['productdataa'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productdataa != null) {
      data['productdataa'] = this.productdataa!.toJson();
    }
    return data;
  }
}

class Productdataa {
  dynamic itemId;
  dynamic itemName;
  dynamic msr;
  dynamic description;
  Price? price;

  Productdataa(
      {this.itemId, this.itemName, this.msr, this.description, this.price});

  Productdataa.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    itemName = json['item_name'];
    msr = json['msr'];
    description = json['description'];
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['item_name'] = this.itemName;
    data['msr'] = this.msr;
    data['description'] = this.description;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    return data;
  }
}

class Price {
  dynamic npp;
  dynamic wp;
  dynamic mrp;

  Price({this.npp, this.wp, this.mrp});

  Price.fromJson(Map<String, dynamic> json) {
    npp = json['npp'];
    wp = json['wp'];
    mrp = json['mrp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['npp'] = this.npp;
    data['wp'] = this.wp;
    data['mrp'] = this.mrp;
    return data;
  }
}

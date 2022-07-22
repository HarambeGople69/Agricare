class DistributerOrderLoadResponse {
  DistributerorderloadData? distributerorderloadData;

  DistributerOrderLoadResponse({this.distributerorderloadData});

  DistributerOrderLoadResponse.fromJson(Map<String, dynamic> json) {
    distributerorderloadData = json['distributerorderloadData'] != null
        ? new DistributerorderloadData.fromJson(
            json['distributerorderloadData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.distributerorderloadData != null) {
      data['distributerorderloadData'] =
          this.distributerorderloadData!.toJson();
    }
    return data;
  }
}

class DistributerorderloadData {
  String? orderid;
  String? orderNo;
  String? distributorID;
  String? orderDate;
  String? totalAmount;
  String? discountAmount;
  String? vat;
  String? netamount;
  String? deliveryDate;
  String? distName;
  List<Items>? items;

  DistributerorderloadData(
      {this.orderid,
      this.orderNo,
      this.distributorID,
      this.orderDate,
      this.totalAmount,
      this.discountAmount,
      this.vat,
      this.netamount,
      this.deliveryDate,
      this.distName,
      this.items});

  DistributerorderloadData.fromJson(Map<String, dynamic> json) {
    orderid = json['orderid'];
    orderNo = json['orderNo'];
    distributorID = json['distributorID'];
    orderDate = json['orderDate'];
    totalAmount = json['totalAmount'];
    discountAmount = json['discountAmount'];
    vat = json['vat'];
    netamount = json['netamount'];
    deliveryDate = json['deliveryDate'];
    distName = json['dist_name'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderid'] = this.orderid;
    data['orderNo'] = this.orderNo;
    data['distributorID'] = this.distributorID;
    data['orderDate'] = this.orderDate;
    data['totalAmount'] = this.totalAmount;
    data['discountAmount'] = this.discountAmount;
    data['vat'] = this.vat;
    data['netamount'] = this.netamount;
    data['deliveryDate'] = this.deliveryDate;
    data['dist_name'] = this.distName;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? itemid;
  String? qty;
  String? freeqty;
  String? rate;
  String? amount;
  String? productGroup;
  String? productName;
  String? productPrice;

  Items(
      {this.itemid,
      this.qty,
      this.freeqty,
      this.rate,
      this.amount,
      this.productGroup,
      this.productName,
      this.productPrice});

  Items.fromJson(Map<String, dynamic> json) {
    itemid = json['itemid'];
    qty = json['qty'];
    freeqty = json['freeqty'];
    rate = json['rate'];
    amount = json['amount'];
    productGroup = json['product_group'];
    productName = json['product_name'];
    productPrice = json['product_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemid'] = this.itemid;
    data['qty'] = this.qty;
    data['freeqty'] = this.freeqty;
    data['rate'] = this.rate;
    data['amount'] = this.amount;
    data['product_group'] = this.productGroup;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    return data;
  }
}

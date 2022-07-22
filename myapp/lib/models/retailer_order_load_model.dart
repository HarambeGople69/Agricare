class RetailerOrderListResponse {
  Retailerlistdata? retailerlistdata;

  RetailerOrderListResponse({this.retailerlistdata});

  RetailerOrderListResponse.fromJson(Map<String, dynamic> json) {
    retailerlistdata = json['retailerlistdata'] != null
        ? new Retailerlistdata.fromJson(json['retailerlistdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.retailerlistdata != null) {
      data['retailerlistdata'] = this.retailerlistdata!.toJson();
    }
    return data;
  }
}

class Retailerlistdata {
  String? orderid;
        String? orderNo;
  String? distributorID;
        String? orderDate;
        String? deliveryDate;
        String? totalAmount;
        String? discountAmount;
        String? vat;
        String? netamount;
        String? distName;
        String? retailName;
  List<Items>? items;

  Retailerlistdata(
      {this.orderid,
      this.orderNo,
      this.distributorID,
      this.orderDate,
      this.deliveryDate,
      this.totalAmount,
      this.discountAmount,
      this.vat,
      this.netamount,
      this.distName,
      this.retailName,
      this.items});

  Retailerlistdata.fromJson(Map<String, dynamic> json) {
    orderid = json['orderid'];
    orderNo = json['orderNo'];
    distributorID = json['distributorID'];
    orderDate = json['orderDate'];
    deliveryDate = json['deliveryDate'];
    totalAmount = json['totalAmount'];
    discountAmount = json['discountAmount'];
    vat = json['vat'];
    netamount = json['netamount'];
    distName = json['dist_name'];
    retailName = json['retail_name'];
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
    data['deliveryDate'] = this.deliveryDate;
    data['totalAmount'] = this.totalAmount;
    data['discountAmount'] = this.discountAmount;
    data['vat'] = this.vat;
    data['netamount'] = this.netamount;
    data['dist_name'] = this.distName;
    data['retail_name'] = this.retailName;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? itemid;
  String? qty;
  String? rate;
  String? amount;
  String? productGroup;
  String? productName;

  Items(
      {this.itemid,
      this.qty,
      this.rate,
      this.amount,
      this.productGroup,
      this.productName});

  Items.fromJson(Map<String, dynamic> json) {
    itemid = json['itemid'];
    qty = json['qty'];
    rate = json['rate'];
    amount = json['amount'];
    productGroup = json['product_group'];
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemid'] = this.itemid;
    data['qty'] = this.qty;
    data['rate'] = this.rate;
    data['amount'] = this.amount;
    data['product_group'] = this.productGroup;
    data['product_name'] = this.productName;
    return data;
  }
}

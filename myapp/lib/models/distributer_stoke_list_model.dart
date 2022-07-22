class DistributerStockModel {
  StokeUpData? stokeUpData;

  DistributerStockModel({this.stokeUpData});

  DistributerStockModel.fromJson(Map<String, dynamic> json) {
    stokeUpData = json['StokeUpData'] != null
        ? new StokeUpData.fromJson(json['StokeUpData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stokeUpData != null) {
      data['StokeUpData'] = this.stokeUpData!.toJson();
    }
    return data;
  }
}

class StokeUpData {
  String? stockId;
  String? distributor;
  String? statedate;
  Meta? meta;

  StokeUpData({this.stockId, this.distributor, this.statedate, this.meta});

  StokeUpData.fromJson(Map<String, dynamic> json) {
    stockId = json['stock_id'];
    distributor = json['distributor'];
    statedate = json['statedate'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stock_id'] = this.stockId;
    data['distributor'] = this.distributor;
    data['statedate'] = this.statedate;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Meta {
  StokeDownData? stokeDownData;

  Meta({this.stokeDownData});

  Meta.fromJson(Map<String, dynamic> json) {
    stokeDownData = json['StokeDownData'] != null
        ? new StokeDownData.fromJson(json['StokeDownData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stokeDownData != null) {
      data['StokeDownData'] = this.stokeDownData!.toJson();
    }
    return data;
  }
}

class StokeDownData {
  String? product;
  String? qty;
  String? batch;
  String? price;
  String? ndp;

  StokeDownData({this.product, this.qty, this.batch, this.price, this.ndp});

  StokeDownData.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    qty = json['qty'];
    batch = json['batch'];
    price = json['price'];
    ndp = json['ndp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    data['qty'] = this.qty;
    data['batch'] = this.batch;
    data['price'] = this.price;
    data['ndp'] = this.ndp;
    return data;
  }
}

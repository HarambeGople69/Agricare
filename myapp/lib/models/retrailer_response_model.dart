class RetrailerResponseModel {
  String? id;
  String? retailName;
  String? retailCity;
  String? retailMobile;

  RetrailerResponseModel(
      {this.id, this.retailName, this.retailCity, this.retailMobile});

  RetrailerResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    retailName = json['retail_name'];
    retailCity = json['retail_city'];
    retailMobile = json['retail_mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['retail_name'] = this.retailName;
    data['retail_city'] = this.retailCity;
    data['retail_mobile'] = this.retailMobile;
    return data;
  }
}

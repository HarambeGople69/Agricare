class DistributerResponseModel {
  String? id;
  String? distName;
  String? distCity;
  String? distributor;
  Distributor0? distributor0;

  DistributerResponseModel(
      {this.id,
      this.distName,
      this.distCity,
      this.distributor,
      this.distributor0});

  DistributerResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    distName = json['dist_name'];
    distCity = json['dist_city'];
    distributor = json['distributor'];
    distributor0 = json['distributor0'] != null
        ? new Distributor0.fromJson(json['distributor0'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dist_name'] = this.distName;
    data['dist_city'] = this.distCity;
    data['distributor'] = this.distributor;
    if (this.distributor0 != null) {
      data['distributor0'] = this.distributor0!.toJson();
    }
    return data;
  }
}

class Distributor0 {
  String? id;
  String? distName;
  String? latitude;
  String? longitude;
  String? distPostalcode;
  String? distCity;
  String? distCountry;
  String? distPhone;
  String? distMobile;
  String? distEmail;
  String? distOwner;
  String? imageUrl;
  String? distFacebook;
  String? distViber;
  String? creditLimit;
  String? discountPer;
  String? status;
  String? ledgersync;
  String? distpan;
  String? ledgerid;
  String? category;

  Distributor0(
      {this.id,
      this.distName,
      this.latitude,
      this.longitude,
      this.distPostalcode,
      this.distCity,
      this.distCountry,
      this.distPhone,
      this.distMobile,
      this.distEmail,
      this.distOwner,
      this.imageUrl,
      this.distFacebook,
      this.distViber,
      this.creditLimit,
      this.discountPer,
      this.status,
      this.ledgersync,
      this.distpan,
      this.ledgerid,
      this.category});

  Distributor0.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    distName = json['dist_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distPostalcode = json['dist_postalcode'];
    distCity = json['dist_city'];
    distCountry = json['dist_country'];
    distPhone = json['dist_phone'];
    distMobile = json['dist_mobile'];
    distEmail = json['dist_email'];
    distOwner = json['dist_owner'];
    imageUrl = json['image_url'];
    distFacebook = json['dist_facebook'];
    distViber = json['dist_viber'];
    creditLimit = json['credit_limit'];
    discountPer = json['discount_per'];
    status = json['status'];
    ledgersync = json['ledgersync'];
    distpan = json['distpan'];
    ledgerid = json['ledgerid'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dist_name'] = this.distName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['dist_postalcode'] = this.distPostalcode;
    data['dist_city'] = this.distCity;
    data['dist_country'] = this.distCountry;
    data['dist_phone'] = this.distPhone;
    data['dist_mobile'] = this.distMobile;
    data['dist_email'] = this.distEmail;
    data['dist_owner'] = this.distOwner;
    data['image_url'] = this.imageUrl;
    data['dist_facebook'] = this.distFacebook;
    data['dist_viber'] = this.distViber;
    data['credit_limit'] = this.creditLimit;
    data['discount_per'] = this.discountPer;
    data['status'] = this.status;
    data['ledgersync'] = this.ledgersync;
    data['distpan'] = this.distpan;
    data['ledgerid'] = this.ledgerid;
    data['category'] = this.category;
    return data;
  }
}

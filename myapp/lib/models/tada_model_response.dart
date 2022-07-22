class Tada_Mode_Response {
  dataa? a;

  Tada_Mode_Response({this.a});

  Tada_Mode_Response.fromJson(Map<String, dynamic> json) {
    a = json['1'] != null ? new dataa.fromJson(json['1']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.a != null) {
      data['1'] = this.a!.toJson();
    }
    return data;
  }
}

class dataa {
  String? date;
  String? ta;
  String? da;
  Meta? meta;

  dataa({this.date, this.ta, this.da, this.meta});

  dataa.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    ta = json['ta'];
    da = json['da'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['ta'] = this.ta;
    data['da'] = this.da;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Meta {
  String? startLocation;
  String? stopLocation;
  String? kmcovered;
  String? party;
  List<String>? retailers;

  Meta(
      {this.startLocation,
      this.stopLocation,
      this.kmcovered,
      this.party,
      this.retailers});

  Meta.fromJson(Map<String, dynamic> json) {
    startLocation = json['start_location'];
    stopLocation = json['stop_location'];
    kmcovered = json['kmcovered'];
    party = json['party'];
    retailers = json['retailers'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_location'] = this.startLocation;
    data['stop_location'] = this.stopLocation;
    data['kmcovered'] = this.kmcovered;
    data['party'] = this.party;
    data['retailers'] = this.retailers;
    return data;
  }
}

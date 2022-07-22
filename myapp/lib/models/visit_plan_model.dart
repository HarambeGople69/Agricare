class VisitPlanModel {
  VisitPlanDataa? dataa;

  VisitPlanModel({this.dataa});

  VisitPlanModel.fromJson(Map<String, dynamic> json) {
    dataa = json['dataa'] != null
        ? new VisitPlanDataa.fromJson(json['dataa'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataa != null) {
      data['dataa'] = this.dataa!.toJson();
    }
    return data;
  }
}

class VisitPlanDataa {
  String? date;
  String? party;
  String? from;
  String? to;
  List<String>? retailers;

  VisitPlanDataa({this.date, this.party, this.from, this.to, this.retailers});

  VisitPlanDataa.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    party = json['party'];
    from = json['from'];
    to = json['to'];
    retailers = json['retailers'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['party'] = this.party;
    data['from'] = this.from;
    data['to'] = this.to;
    data['retailers'] = this.retailers;
    return data;
  }
}

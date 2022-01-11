class KtpModel {
  String? noKTP;

  KtpModel({this.noKTP});

  KtpModel.fromJson(Map<String, dynamic> json) {
    noKTP = json['noKTP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['noKTP'] = this.noKTP;
    return data;
  }
}
class AirlineModel {
  String? status;
  String? message;
  AirlineData? data;

  AirlineModel({this.status, this.message, this.data});

  AirlineModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? AirlineData.fromJson(json['data']) : null;
  }
}

class AirlineData {
  List<AirlineItem>? airlines;
  String? search;

  AirlineData({this.airlines, this.search});

  AirlineData.fromJson(Map<String, dynamic> json) {
    if (json['airlines'] != null) {
      airlines = <AirlineItem>[];
      json['airlines'].forEach((v) {
        airlines!.add(AirlineItem.fromJson(v));
      });
    }
    search = json['search'];
  }
}

class AirlineItem {
  String? airline;

  AirlineItem({this.airline});

  AirlineItem.fromJson(Map<String, dynamic> json) {
    airline = json['airline'];
  }
}

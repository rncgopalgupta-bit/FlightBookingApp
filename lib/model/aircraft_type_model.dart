class AircraftTypeModel {
  String? status;
  String? message;
  AircraftTypeData? data;

  AircraftTypeModel({this.status, this.message, this.data});

  AircraftTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? AircraftTypeData.fromJson(json['data']) : null;
  }
}

class AircraftTypeData {
  List<AircraftTypeItem>? aircraftTypes;
  String? search;

  AircraftTypeData({this.aircraftTypes, this.search});

  AircraftTypeData.fromJson(Map<String, dynamic> json) {
    if (json['aircraft_types'] != null) {
      aircraftTypes = <AircraftTypeItem>[];
      json['aircraft_types'].forEach((v) {
        aircraftTypes!.add(AircraftTypeItem.fromJson(v));
      });
    }
    search = json['search'];
  }
}

class AircraftTypeItem {
  String? aircraft;

  AircraftTypeItem({this.aircraft});

  AircraftTypeItem.fromJson(Map<String, dynamic> json) {
    aircraft = json['aircraft'];
  }
}

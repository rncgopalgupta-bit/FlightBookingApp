class FlightDetailModel {
  final String? status;
  final String? message;
  final DetailData? data;

  FlightDetailModel({this.status, this.message, this.data});

  factory FlightDetailModel.fromJson(Map<String, dynamic> json) => FlightDetailModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : DetailData.fromJson(json["data"]),
      );
}

class DetailData {
  final FlightDetails? flightDetails;
  final List<Passenger>? passengers;
  final BookingInfo? bookingInfo;

  DetailData({this.flightDetails, this.passengers, this.bookingInfo});

  factory DetailData.fromJson(Map<String, dynamic> json) => DetailData(
        flightDetails: json["flight_details"] == null
            ? null
            : FlightDetails.fromJson(json["flight_details"]),
        passengers: json["passengers"] == null
            ? []
            : List<Passenger>.from(json["passengers"]!.map((x) => Passenger.fromJson(x))),
        bookingInfo: json["booking_info"] == null
            ? null
            : BookingInfo.fromJson(json["booking_info"]),
      );
}

class FlightDetails {
  final int? id;
  final String? airlineName;
  final String? airlineLogo;
  final String? flightId;
  final String? flightNumber;
  final DetailInfo? departure;
  final DetailInfo? arrival;
  final String? duration;
  final String? aircraftType;
  final int? stops;
  final String? terminal;
  final String? gate;
  final String? flightClass;

  FlightDetails({
    this.id,
    this.airlineName,
    this.airlineLogo,
    this.flightId,
    this.flightNumber,
    this.departure,
    this.arrival,
    this.duration,
    this.aircraftType,
    this.stops,
    this.terminal,
    this.gate,
    this.flightClass,
  });

  factory FlightDetails.fromJson(Map<String, dynamic> json) => FlightDetails(
        id: json["id"],
        airlineName: json["airline_name"],
        airlineLogo: json["airline_logo"],
        flightId: json["flight_id"],
        flightNumber: json["flight_number"],
        departure: json["departure"] == null ? null : DetailInfo.fromJson(json["departure"]),
        arrival: json["arrival"] == null ? null : DetailInfo.fromJson(json["arrival"]),
        duration: json["duration"],
        aircraftType: json["aircraft_type"],
        stops: json["stops"],
        terminal: json["terminal"],
        gate: json["gate"],
        flightClass: json["class"],
      );
}

class DetailInfo {
  final String? time;
  final String? airportCode;
  final String? city;

  DetailInfo({this.time, this.airportCode, this.city});

  factory DetailInfo.fromJson(Map<String, dynamic> json) => DetailInfo(
        time: json["time"],
        airportCode: json["airport_code"],
        city: json["city"],
      );
}

class Passenger {
  final int? passengerNumber;
  final String? title;
  final String? name;
  final String? seat;
  final String? profilePicture;

  Passenger({this.passengerNumber, this.title, this.name, this.seat, this.profilePicture});

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
        passengerNumber: json["passenger_number"],
        title: json["title"],
        name: json["name"],
        seat: json["seat"],
        profilePicture: json["profile_picture"],
      );
}

class BookingInfo {
  final int? totalPassengers;
  final String? bookingReference;
  final String? bookingDate;
  final String? barcode;

  BookingInfo({this.totalPassengers, this.bookingReference, this.bookingDate, this.barcode});

  factory BookingInfo.fromJson(Map<String, dynamic> json) => BookingInfo(
        totalPassengers: json["total_passengers"],
        bookingReference: json["booking_reference"],
        bookingDate: json["booking_date"],
        barcode: json["barcode"],
      );
}

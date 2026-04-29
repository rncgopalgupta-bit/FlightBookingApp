class FlightResultModel {
  final String? status;
  final String? message;
  final Data? data;

  FlightResultModel({this.status, this.message, this.data});

  factory FlightResultModel.fromJson(Map<String, dynamic> json) => FlightResultModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  final SearchParams? searchParams;
  final List<FlightData>? flights;
  final Pagination? pagination;

  Data({this.searchParams, this.flights, this.pagination});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        searchParams: json["search_params"] == null
            ? null
            : SearchParams.fromJson(json["search_params"]),
        flights: json["flights"] == null
            ? []
            : List<FlightData>.from(json["flights"]!.map((x) => FlightData.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );
}

class FlightData {
  final int? id;
  final String? airlineName;
  final String? airlineLogo;
  final String? flightNumber;
  final FlightInfo? departure;
  final FlightInfo? arrival;
  final String? duration;
  final Price? price;
  final String? aircraftType;
  final int? stops;

  FlightData({
    this.id,
    this.airlineName,
    this.airlineLogo,
    this.flightNumber,
    this.departure,
    this.arrival,
    this.duration,
    this.price,
    this.aircraftType,
    this.stops,
  });

  factory FlightData.fromJson(Map<String, dynamic> json) => FlightData(
        id: json["id"],
        airlineName: json["airline_name"],
        airlineLogo: json["airline_logo"],
        flightNumber: json["flight_number"],
        departure: json["departure"] == null ? null : FlightInfo.fromJson(json["departure"]),
        arrival: json["arrival"] == null ? null : FlightInfo.fromJson(json["arrival"]),
        duration: json["duration"],
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        aircraftType: json["aircraft_type"],
        stops: json["stops"],
      );
}

class FlightInfo {
  final String? time;
  final String? airportCode;
  final String? city;

  FlightInfo({this.time, this.airportCode, this.city});

  factory FlightInfo.fromJson(Map<String, dynamic> json) => FlightInfo(
        time: json["time"],
        airportCode: json["airport_code"],
        city: json["city"],
      );
}

class Price {
  final int? amount;
  final String? currency;

  Price({this.amount, this.currency});

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        amount: json["amount"],
        currency: json["currency"],
      );
}

class SearchParams {
  final String? from;
  final String? to;
  final String? date;
  final int? passengers;
  final String? sortBy;
  final Filters? filters;

  SearchParams({this.from, this.to, this.date, this.passengers, this.sortBy, this.filters});

  factory SearchParams.fromJson(Map<String, dynamic> json) => SearchParams(
        from: json["from"],
        to: json["to"],
        date: json["date"],
        passengers: json["passengers"],
        sortBy: json["sort_by"],
        filters: json["filters"] == null ? null : Filters.fromJson(json["filters"]),
      );
}

class Filters {
  final String? airline;
  final int? priceMin;
  final int? priceMax;
  final int? stops;
  final String? aircraftType;

  Filters({this.airline, this.priceMin, this.priceMax, this.stops, this.aircraftType});

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
        airline: json["airline"],
        priceMin: json["price_min"],
        priceMax: json["price_max"],
        stops: json["stops"],
        aircraftType: json["aircraft_type"],
      );
}

class Pagination {
  final int? total;
  final int? totalPages;
  final int? currentPage;
  final int? limit;
  final bool? hasNextPage;
  final bool? hasPrevPage;

  Pagination({this.total, this.totalPages, this.currentPage, this.limit, this.hasNextPage, this.hasPrevPage});

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        limit: json["limit"],
        hasNextPage: json["hasNextPage"],
        hasPrevPage: json["hasPrevPage"],
      );
}

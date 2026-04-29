class From {
  final String? status;
  final String? message;
  final Data? data;

  From({this.status, this.message, this.data});

  factory From.fromJson(Map<String, dynamic> json) => From(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final List<Airport>? airports;
  final String? search;
  final Pagination? pagination;

  Data({this.airports, this.search, this.pagination});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    airports: json["airports"] == null
        ? []
        : List<Airport>.from(json["airports"]!.map((x) => Airport.fromJson(x))),
    search: json["search"],
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "airports": airports == null
        ? []
        : List<dynamic>.from(airports!.map((x) => x.toJson())),
    "search": search,
    "pagination": pagination?.toJson(),
  };
}

class Airport {
  final String? airportCode;
  final String? city;
  final int? flightCount;

  Airport({this.airportCode, this.city, this.flightCount});

  factory Airport.fromJson(Map<String, dynamic> json) => Airport(
        airportCode: json["airport_code"],
        city: json["city"],
        flightCount: json["flight_count"],
      );

  Map<String, dynamic> toJson() => {
        "airport_code": airportCode,
        "city": city,
        "flight_count": flightCount,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Airport &&
          runtimeType == other.runtimeType &&
          airportCode == other.airportCode;

  @override
  int get hashCode => airportCode.hashCode;
}

class Pagination {
  final int? total;
  final int? totalPages;
  final int? currentPage;
  final int? limit;
  final bool? hasNextPage;
  final bool? hasPrevPage;

  Pagination({
    this.total,
    this.totalPages,
    this.currentPage,
    this.limit,
    this.hasNextPage,
    this.hasPrevPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    totalPages: json["totalPages"],
    currentPage: json["currentPage"],
    limit: json["limit"],
    hasNextPage: json["hasNextPage"],
    hasPrevPage: json["hasPrevPage"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "totalPages": totalPages,
    "currentPage": currentPage,
    "limit": limit,
    "hasNextPage": hasNextPage,
    "hasPrevPage": hasPrevPage,
  };
}

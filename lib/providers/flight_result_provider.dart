import 'package:flutter/material.dart';
import '../apirepoclass/apiRepo.dart';
import '../model/flight_result_model.dart';

class FlightResultProvider with ChangeNotifier {
  FlightResultModel? _flightResult;
  List<FlightData> _allFlights = [];
  List<FlightData> _filteredFlights = [];
  bool _isLoading = false;
  String _selectedFilter = 'price_asc';

  FlightResultModel? get flightResult => _flightResult;
  List<FlightData> get flights => _filteredFlights;
  bool get isLoading => _isLoading;
  String get selectedFilter => _selectedFilter;

  Map<String, dynamic> currentSearchPayload = {};
  List<String> availableAirlines = [];
  List<String> availableAircrafts = [];
  bool isLoadingFilters = false;

  Future<void> fetchFiltersData(BuildContext context) async {
    if (availableAirlines.isNotEmpty && availableAircrafts.isNotEmpty) return;
    
    isLoadingFilters = true;
    notifyListeners();

    final payload = {"page": 1, "limit": 10};

    final airlineResult = await AirlineRepo.getAirlines(payload, context);
    if (airlineResult != null && airlineResult.data != null && airlineResult.data!.airlines != null) {
      availableAirlines = airlineResult.data!.airlines!.map((e) => e.airline ?? '').where((e) => e.isNotEmpty).toList();
    }

    final aircraftResult = await AircraftTypeRepo.getAircraftTypes(payload, context);
    if (aircraftResult != null && aircraftResult.data != null && aircraftResult.data!.aircraftTypes != null) {
      availableAircrafts = aircraftResult.data!.aircraftTypes!.map((e) => e.aircraft ?? '').where((e) => e.isNotEmpty).toList();
    }

    isLoadingFilters = false;
    notifyListeners();
  }

  void applyAdvancedFilters(String sortBy, String airline, String aircraftType, int stops, BuildContext context) {
    if (currentSearchPayload.isEmpty) return;
    
    currentSearchPayload['sort_by'] = sortBy;
    currentSearchPayload['filters'] = {
      "airline": airline,
      "price_min": 0,
      "price_max": 10000,
      "stops": stops,
      "aircraft_type": aircraftType,
    };
    
    searchFlights(currentSearchPayload, context);
  }

  Future<void> searchFlights(Map<String, dynamic> payload, BuildContext context, {bool isRefresh = false}) async {
    currentSearchPayload = Map<String, dynamic>.from(payload);
    if (!isRefresh) {
      _isLoading = true;
      notifyListeners();
    }

    final result = await SearchRepo.register(payload, context, loader: false);
    if (result != null && result.data != null) {
      _flightResult = result;
      _allFlights = result.data!.flights ?? [];
      _applyFilter(_selectedFilter);
    }

    if (!isRefresh) {
      _isLoading = false;
    }
    notifyListeners();
  }

  void setFilter(String filter) {
    _selectedFilter = filter;
    _applyFilter(filter);
    notifyListeners();
  }

  void _applyFilter(String filter) {
    List<FlightData> sortedList = List.from(_allFlights);
    switch (filter) {
      case 'price_asc':
        sortedList.sort((a, b) => (a.price?.amount ?? 0).compareTo(b.price?.amount ?? 0));
        break;
      case 'price_desc':
        sortedList.sort((a, b) => (b.price?.amount ?? 0).compareTo(a.price?.amount ?? 0));
        break;
      case 'duration_asc':
        // Simplified duration sorting (assuming format like "8h 15m")
        sortedList.sort((a, b) => (a.duration ?? '').compareTo(b.duration ?? ''));
        break;
      case 'departure_asc':
        sortedList.sort((a, b) => (a.departure?.time ?? '').compareTo(b.departure?.time ?? ''));
        break;
    }
    _filteredFlights = sortedList;
  }
}

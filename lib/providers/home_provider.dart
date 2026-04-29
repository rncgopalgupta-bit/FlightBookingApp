import 'package:flightbookingapp/apirepoclass/apiRepo.dart';
import 'package:flutter/material.dart';
import '../model/flight_model.dart';
import '../model/from.dart';

class HomeProvider with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Airport? _selectedFrom;
  Airport? _selectedTo;
  DateTime _selectedDate = DateTime.now();
  List<Airport> _fromAirports = [];
  List<Airport> _toAirports = [];

  Airport? get selectedFrom => _selectedFrom;
  Airport? get selectedTo => _selectedTo;
  DateTime get selectedDate => _selectedDate;
  List<Airport> get fromAirports => _fromAirports;
  List<Airport> get toAirports => _toAirports;

  void setSelectedFrom(Airport? airport) {
    _selectedFrom = airport;
    notifyListeners();
  }

  void setSelectedTo(Airport? airport) {
    _selectedTo = airport;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  int _passengerCount = 1;
  int get passengerCount => _passengerCount;

  void setPassengerCount(int count) {
    _passengerCount = count;
    notifyListeners();
  }

  void swapAirports() {
    final tempFrom = _selectedFrom;
    final tempTo = _selectedTo;

    _selectedFrom = tempTo;
    _selectedTo = tempFrom;

    notifyListeners();
  }

  Future<void> fetchFromAirports(BuildContext context) async {
    final payload = {"search": "", "limit": 10, "page": 1};
    final response = await FromRepo.register(payload, context);
    if (response != null && response.data != null) {
      _fromAirports = response.data!.airports ?? [];
      notifyListeners();
    }
  }

  Future<void> fetchToAirports(BuildContext context) async {
    final payload = {"search": "", "limit": 10, "page": 1};
    final response = await ToRepo.register(payload, context);
    if (response != null && response.data != null) {
      _toAirports = response.data!.airports ?? [];
      notifyListeners();
    }
  }

  final List<Flight> _savedTrips = [
    Flight(
      logo: 'citilink_logo.png',
      airline: 'Citilink',
      departureTime: '07:47',
      arrivalTime: '14:30',
      departureCode: 'CGK',
      arrivalCode: 'NRT',
      departureCity: 'Jakarta',
      arrivalCity: 'Tokyo',
      duration: '7h 15m',
      date: 'Jan 20, 2025',
      passengers: 1,
    ),
  ];

  List<Flight> get savedTrips => _savedTrips;

  void addSavedTrip(Flight flight) {
    _savedTrips.insert(0, flight);
    notifyListeners();
  }
}

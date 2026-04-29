import 'package:flutter/material.dart';
import '../apirepoclass/apiRepo.dart';
import '../model/flight_detail_model.dart';

class FlightDetailProvider with ChangeNotifier {
  FlightDetailModel? _flightDetail;
  bool _isLoading = false;

  FlightDetailModel? get flightDetail => _flightDetail;
  bool get isLoading => _isLoading;

  Future<void> fetchFlightDetail(int id, BuildContext context) async {
    _isLoading = true;
    _flightDetail = null;
    notifyListeners();

    final payload = {"id": id};
    final result = await DetailRepo.register(payload, context, loader: false);
    if (result != null) {
      _flightDetail = result;
    }

    _isLoading = false;
    notifyListeners();
  }
}

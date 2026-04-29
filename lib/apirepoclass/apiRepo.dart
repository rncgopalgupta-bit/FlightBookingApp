import 'package:flightbookingapp/model/airline_model.dart';
import 'package:flightbookingapp/model/aircraft_type_model.dart';
import 'package:flightbookingapp/model/flight_detail_model.dart';
import 'package:flightbookingapp/model/flight_result_model.dart';
import 'package:flightbookingapp/model/from.dart';
import 'package:flightbookingapp/network_services/network_const.dart';
import 'package:flightbookingapp/network_services/network_repo.dart';
import 'package:flutter/material.dart';

class FromRepo {
  static Future<From?> register(Map payloads, BuildContext context) async {
    var response = await NetworkRepo().postRequest(
      endpoint: NetworkConsts.from,
      payload: payloads,
      context: context,
    );

    if (response != null && response.statusCode == 200) {
      final responseBody = response.data;
      return From.fromJson(responseBody);
    } else {
      return null;
    }
  }
}

class ToRepo {
  static Future<From?> register(Map payloads, BuildContext context) async {
    var response = await NetworkRepo().postRequest(
      endpoint: NetworkConsts.to,
      payload: payloads,
      context: context,
    );

    if (response != null && response.statusCode == 200) {
      final responseBody = response.data;
      return From.fromJson(responseBody);
    } else {
      return null;
    }
  }
}

class SearchRepo {
  static Future<FlightResultModel?> register(Map payloads, BuildContext context, {bool loader = true}) async {
    var response = await NetworkRepo().postRequest(
      endpoint: NetworkConsts.search,
      payload: payloads,
      context: context,
      loader: loader,
    );

    if (response != null && response.statusCode == 200) {
      final responseBody = response.data;
      return FlightResultModel.fromJson(responseBody);
    } else {
      return null;
    }
  }
}

class DetailRepo {
  static Future<FlightDetailModel?> register(Map payloads, BuildContext context, {bool loader = true}) async {
    var response = await NetworkRepo().postRequest(
      endpoint: NetworkConsts.flight,
      payload: payloads,
      context: context,
      loader: loader,
    );

    if (response != null && response.statusCode == 200) {
      final responseBody = response.data;
      return FlightDetailModel.fromJson(responseBody);
    } else {
      return null;
    }
  }
}

class AirlineRepo {
  static Future<AirlineModel?> getAirlines(Map payloads, BuildContext context) async {
    var response = await NetworkRepo().postRequest(
      endpoint: NetworkConsts.airlines,
      payload: payloads,
      context: context,
      loader: false,
    );

    if (response != null && response.statusCode == 200) {
      final responseBody = response.data;
      return AirlineModel.fromJson(responseBody);
    } else {
      return null;
    }
  }
}

class AircraftTypeRepo {
  static Future<AircraftTypeModel?> getAircraftTypes(Map payloads, BuildContext context) async {
    var response = await NetworkRepo().postRequest(
      endpoint: NetworkConsts.aircraftTypes,
      payload: payloads,
      context: context,
      loader: false,
    );

    if (response != null && response.statusCode == 200) {
      final responseBody = response.data;
      return AircraftTypeModel.fromJson(responseBody);
    } else {
      return null;
    }
  }
}

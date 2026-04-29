import 'package:flutter/material.dart';

abstract class NetworkCalls{
  Future<void> postRequest({required String endpoint,required dynamic payload, required BuildContext context});
  Future<void> postRequestWithHeader({required String endpoint,required dynamic payload, required BuildContext context});
  Future<void> getRequestWithHeader(bool loader,{required String endpoint, required BuildContext context});
  Future<void> getRequest({required String endpoint, required BuildContext context});
  Future<void> postRequestWithEncode({required String endpoint,required dynamic payload, required BuildContext context});
}

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flightbookingapp/constants/core_const.dart';
import 'package:flightbookingapp/main.dart';
import 'package:flightbookingapp/network_services/network_const.dart';
import 'package:flightbookingapp/user_manual/auth_helper.dart';
import 'package:flutter/material.dart';

class NetworkRepo {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: NetworkConsts.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  /// ====================== POST REQUEST ======================
  Future<Response?> postRequest({
    required String endpoint,
    required dynamic payload,
    required BuildContext context,
    bool loader = true,
  }) async {
    if (loader) {
      Core.showLoader(context);
    }

    try {
      final response = await _dio.post(endpoint, data: payload);
      if (loader) {
        Core.hideLoader();
      }

      final responseJson = response.data;

      if (response.statusCode != 200) {
        Core.showSnackBarToast(
          context,
          responseJson['message'] ?? 'Something went wrong',
        );
        return null;
      } else if (responseJson['code'] == 400) {
        Core.showSnackBarToast(
          context,
          responseJson['message'] ?? 'Invalid Request',
        );
        return null;
      } else {
        return response;
      }
    } on DioException catch (e) {
      if (loader) {
        Core.hideLoader();
      }
      _handleDioError(e);
      return null;
    } catch (e) {
      if (loader) {
        Core.hideLoader();
      }
      Core.showSnackBarToast(context, 'Unexpected error: $e');
      return null;
    }
  }

  /// ================= POST REQUEST WITH HEADER =================
  Future<Response?> postRequestWithHeader({
    required String endpoint,
    required dynamic payload,
    required BuildContext context,
  }) async {
    Core.showLoader(context);

    try {
      final token = await secureStorage.read(key: 'TOKEN');
      print('Token: $token');
      final response = await _dio.post(
        endpoint,
        data: payload,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final responseJson = response.data;

      if (response.statusCode == 200) {
        Core.hideLoader();
        return response;
      } else if (response.statusCode == 401) {
        // Get.offAllNamed(AppRoutes.login);

        Core.hideLoader();
        return null;
      } else {
        Core.showSnackBarToast(
          context,
          responseJson['message'] ?? 'Error occurred',
        );
        Core.hideLoader();
        return null;
      }
    } on DioException catch (e) {
      Core.hideLoader();
      if (e.response?.statusCode == 401) {
        await secureStorage.delete(key: 'TOKEN');

        ///Get.offAllNamed(AppRoutes.login);
        return null;
      }
      _handleDioError(e);
      return null;
    } catch (e) {
      Core.hideLoader();
      Core.showSnackBarToast(context, 'Unexpected error: $e');
    }
  }

  Future<Response?> postRequestWithHeaderwithcontentType({
    required String endpoint,
    required dynamic payload,
    required BuildContext context,
    bool loader = true,
  }) async {
    if (loader) {
      Core.showLoader(context);
    }

    try {
      final token = await secureStorage.read(key: 'TOKEN');
      final response = await _dio.post(
        endpoint,
        data: payload,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (loader) {
        Core.hideLoader();
      }
      final responseJson = response.data;

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 400) {
        // Get.offAllNamed(AppRoutes.login);

        return null;
      } else {
        Core.showSnackBarToast(
          context,
          responseJson['message'] ?? 'Error occurred',
        );
        return null;
      }
    } on DioException catch (e) {
      if (loader) {
        Core.hideLoader();
      }
      _handleDioError(e);
      return null;
    } catch (e) {
      if (loader) {
        Core.hideLoader();
      }
      Core.showSnackBarToast(context, 'Unexpected error: $e');
      return null;
    }
  }

  Future<Response?> putRequestWithHeader({
    required String endpoint,
    required dynamic payload,
    required BuildContext context,
  }) async {
    Core.showLoader(context);

    try {
      final token = await secureStorage.read(key: 'TOKEN');
      print('Token: $token');
      final response = await _dio.put(
        endpoint,
        data: payload,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final responseJson = response.data;

      if (response.statusCode == 200) {
        Core.hideLoader();
        return response;
      } else if (response.statusCode == 401) {
        // Get.offAllNamed(AppRoutes.login);

        Core.hideLoader();
        return null;
      } else {
        Core.showSnackBarToast(
          context,
          responseJson['message'] ?? 'Error occurred',
        );
        Core.hideLoader();
        return null;
      }
    } on DioException catch (e) {
      Core.hideLoader();
      if (e.response?.statusCode == 401) {
        await secureStorage.delete(key: 'TOKEN');

        ///Get.offAllNamed(AppRoutes.login);
        return null;
      }
      _handleDioError(e);
      return null;
    } catch (e) {
      Core.hideLoader();
      Core.showSnackBarToast(context, 'Unexpected error: $e');
    }
  }

  /// ===================== GET REQUEST =====================
  Future<Response?> getRequest({required String endpoint}) async {
    Core.showLoader(NavigationService.navigatorKey.currentContext!);
    try {
      final response = await _dio.get(endpoint);
      Navigator.pop(NavigationService.navigatorKey.currentContext!);
      return response;
    } on DioException catch (e) {
      Navigator.pop(NavigationService.navigatorKey.currentContext!);
      _handleDioError(e);
      return null;
    }
  }

  /// ============== GET REQUEST WITH HEADER ==================
  Future<Response?> getRequestWithHeader({
    required String endpoint,
    required BuildContext context,
  }) async {
    Core.showLoader(context);

    try {
      final token = await secureStorage.read(key: 'TOKEN');
      final response = await _dio.get(
        endpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final responseJson = response.data;

      if (response.statusCode == 200) {
        Core.hideLoader();
        return response;
      } else if (response.statusCode == 400) {
        // Get.offAllNamed(AppRoutes.login);

        // await AuthHelper().logout();
        // Navigator.pushAndRemoveUntil(
        //   NavigationService.navigatorKey.currentContext!,
        //   MaterialPageRoute(builder: (context) => Login_Screen()),
        //   (Route<dynamic> route) => false,
        // );
        Core.hideLoader();
        return null;
      } else {
        Core.showSnackBarToast(
          context,
          responseJson['message'] ?? 'Error occurred',
        );
        Core.hideLoader();
        return null;
      }
    } on DioException catch (e) {
      Core.hideLoader();
      if (e.response?.statusCode == 401) {
        await secureStorage.delete(key: 'TOKEN');
        // Get.offAllNamed(AppRoutes.login);
        return null;
      }
      _handleDioError(e);
      return null;
    }
  }

  Future<Response?> deleteRequestWithHeader({
    required String endpoint,
    required BuildContext context,
  }) async {
    Core.showLoader(context);

    try {
      final token = await secureStorage.read(key: 'TOKEN');

      final response = await _dio.delete(
        endpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      Core.hideLoader();
      return response;
    } on DioException catch (e) {
      Core.hideLoader();

      // 🔥 Handle token expiry
      if (e.response?.statusCode == 401) {
        await secureStorage.delete(key: 'TOKEN');
        // Get.offAllNamed(AppRoutes.login);
        return null;
      }

      // Handle other API-related errors
      _handleDioError(e);
      return null;
    } catch (e) {
      Core.hideLoader();
      Core.showSnackBarToast(context, "Unexpected error: $e");
      return null;
    }
  }

  /// ============== MULTIPART REQUEST (File Upload) ==================
  Future<Response?> multipartRequest({
    required String endpoint,
    required Map<String, dynamic> fields,
    required List<File> files,
    String fileKey = 'files',
    bool loader = true,
  }) async {
    if (loader) {
      Core.showLoader(NavigationService.navigatorKey.currentContext!);
    }

    try {
      final token = await secureStorage.read(key: 'TOKEN');

      final formData = FormData.fromMap({
        ...fields,
        fileKey: files
            .map((file) => MultipartFile.fromFileSync(file.path))
            .toList(),
      });

      final response = await _dio.post(
        endpoint,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (loader) Navigator.pop(NavigationService.navigatorKey.currentContext!);
      return response;
    } on DioException catch (e) {
      if (loader) Navigator.pop(NavigationService.navigatorKey.currentContext!);
      _handleDioError(e);
      return null;
    } catch (e) {
      if (loader) Navigator.pop(NavigationService.navigatorKey.currentContext!);
      Core.showSnackBarToast(
        NavigationService.navigatorKey.currentContext!,
        'Unexpected error: $e',
      );
      return null;
    }
  }

  /// ============== COMMON DIO ERROR HANDLER ==================
  void _handleDioError(DioException e) {
    String message = '';
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      message = 'Connection timed out. Please try again later.';
    } else if (e.type == DioExceptionType.badResponse) {
      message = e.response?.data['message'] ?? 'Server error occurred.';
    } else if (e.type == DioExceptionType.connectionError) {
      message = 'No Internet or Server Connection. Please try again later.';
    } else {
      message = 'Unexpected error: ${e.message}';
    }

    Core.showSnackBarToast(
      NavigationService.navigatorKey.currentContext!,
      message,
    );
  }
}

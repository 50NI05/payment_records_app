// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:registro_pagos/app/ui/pages/payment_record/payment_record_model.dart';

import '../../../app_config.dart';

class GetAllPaymentApi {
  final Dio _dio;
  CancelToken? _cancelToken;

  GetAllPaymentApi(this._dio);

  final _controller = StreamController<List<GetAllPaymentModel>?>.broadcast();

  Stream<List<GetAllPaymentModel>?> get onResults => _controller.stream;

  Future<GetAllPaymentModel> getAllPayment({
    required String token,
  }) async {
    _cancelToken = CancelToken();
    final response = await _dio.get(
      '${AppConfig.instance.apiHost}getAllPayment',
      options: Options(headers: {
        'auth-token': token,
      }),
      cancelToken: _cancelToken,
    );

    final data = GetAllPaymentModel.fromJson(response.data);

    return data;
  }

  void cancel() {
    if (_cancelToken != null) {
      _cancelToken!.cancel();
      _cancelToken = null;
    }
  }

  void dispose() {
    cancel();
    _controller.close();
  }
}

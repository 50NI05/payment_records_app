// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:registro_pagos/app/ui/pages/add_payment/add_payment_model.dart';

import '../../../app_config.dart';

class AddPaymentApi {
  final Dio _dio;
  CancelToken? _cancelToken;

  AddPaymentApi(this._dio);

  final _controller = StreamController<List<AddPaymentModel>?>.broadcast();

  Stream<List<AddPaymentModel>?> get onResults => _controller.stream;

  Future<AddPaymentModel> addPayment({
    required String name,
    required String identity_card,
    required String phone_number,
    required String apartment,
    required String reference_number,
    required String amount,
    required String token,
  }) async {
    _cancelToken = CancelToken();
    final response = await _dio.post(
      '${AppConfig.instance.apiHost}addPayment',
      data: {
        'name': name,
        'identity_card': identity_card,
        'phone_number': phone_number,
        'apartment': apartment,
        'reference_number': reference_number,
        'amount': amount,
      },
      options: Options(headers: {
        'auth-token': token,
      }),
      cancelToken: _cancelToken,
    );

    final data = AddPaymentModel.fromJson(response.data);

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

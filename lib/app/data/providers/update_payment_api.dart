// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:registro_pagos/app/ui/pages/payment_record/update_payment_model.dart';
import '../../../app_config.dart';

class UpdatePaymentApi {
  final Dio _dio;
  CancelToken? _cancelToken;

  UpdatePaymentApi(this._dio);

  final _controller = StreamController<List<UpdatePaymentModel>?>.broadcast();

  Stream<List<UpdatePaymentModel>?> get onResults => _controller.stream;

  Future<UpdatePaymentModel> updatePayment({
    required String? name,
    required String? identity_card,
    required String? phone_number,
    required String? apartment,
    required String? reference_number,
    required String? amount,
    required String token,
    required int id
  }) async {
    _cancelToken = CancelToken();
    final response = await _dio.patch(
      '${AppConfig.instance.apiHost}updatePayment/$id',
      data: {
        'name': name,
        'identity_card': int.parse(identity_card!),
        'phone_number': int.parse(phone_number!),
        'apartment': apartment,
        'reference_number': int.parse(reference_number!),
        'amount': double.parse(amount!),
      },
      options: Options(headers: {
        'auth-token': token,
      }),
      cancelToken: _cancelToken,
    );

    final data = UpdatePaymentModel.fromJson(response.data);

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

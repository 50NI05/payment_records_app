// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:dio/dio.dart';

import '../../../app_config.dart';
import '../../ui/pages/payment_record/delete_payment_model.dart';

class DeletePaymentApi {
  final Dio _dio;
  CancelToken? _cancelToken;

  DeletePaymentApi(this._dio);

  final _controller = StreamController<List<DeletePaymentModel>?>.broadcast();

  Stream<List<DeletePaymentModel>?> get onResults => _controller.stream;

  Future<DeletePaymentModel> deletePayment({
    required String token,
    required int id
  }) async {
    _cancelToken = CancelToken();
    final response = await _dio.delete(
      '${AppConfig.instance.apiHost}deletePayment/$id',
      options: Options(headers: {
        'auth-token': token,
      }),
      cancelToken: _cancelToken,
    );

    final data = DeletePaymentModel.fromJson(response.data);

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

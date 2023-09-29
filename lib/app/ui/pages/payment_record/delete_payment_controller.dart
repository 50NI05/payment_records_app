import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:registro_pagos/app/data/providers/delete_payment_api.dart';
import 'package:registro_pagos/app/ui/pages/payment_record/delete_payment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeletePaymentController extends ChangeNotifier {
  final DeletePaymentApi _deletePaymentApi;

  DeletePaymentController(this._deletePaymentApi);

  Future<DeletePaymentModel?> deletePayment(int idPayment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await _deletePaymentApi.deletePayment(id: idPayment, token: token!);

    notifyListeners();

    return response;
  }
}

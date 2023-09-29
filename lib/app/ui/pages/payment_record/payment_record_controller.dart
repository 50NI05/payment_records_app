import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:registro_pagos/app/data/providers/get_all_payment_api.dart';
import 'package:registro_pagos/app/ui/pages/payment_record/payment_record_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentRecordController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final filterController = TextEditingController();
  final filterFocusNode = FocusNode();

  List<Datum?>? allPayment;
  List<Datum?>? filterPayment;
  final GetAllPaymentApi _allPaymentApi;
  bool isLoading = false;

  PaymentRecordController(this._allPaymentApi);

  Future<GetAllPaymentModel?> getAllPayment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    isLoading = true;
    notifyListeners();

    try {
      final response = await _allPaymentApi.getAllPayment(token: token!);

      allPayment = response.data;
      filterPayment = response.data;

      isLoading = false;
      notifyListeners();

      return response;
    } catch (e) {
      isLoading = false;
      notifyListeners();

      // Puedes arrojar el error nuevamente si es necesario
      throw e;
    }
  }

  filter() {
    filterPayment = allPayment!.where((element) => element!.name.toLowerCase().startsWith(filterController.value.text)).toList();
    notifyListeners();
  }


}
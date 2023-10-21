// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:registro_pagos/app/data/providers/update_payment_api.dart';
import 'package:registro_pagos/app/helpers/extentions.dart';
import 'package:registro_pagos/app/ui/pages/payment_record/update_payment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helpers/validators.dart';

class UpdatePaymentController extends ChangeNotifier {
  final UpdatePaymentApi _updatePaymentApi;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final identityCardController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final apartmentController = TextEditingController();
  final referenceCodeController = TextEditingController();
  final amountController = TextEditingController();
  final nameFocusNode = FocusNode();
  final identityCardFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();
  final aparmentFocusNode = FocusNode();
  final referenceCodeFocusNode = FocusNode();
  final amountFocusNode = FocusNode();
  ValidationItem? nameTextV = ValidationItem(null, null);
  ValidationItem? identityCardTextV = ValidationItem(null, null);
  ValidationItem? phoneNumberTextV = ValidationItem(null, null);
  ValidationItem? apartmentTextV = ValidationItem(null, null);
  ValidationItem? referenceNumberTextV = ValidationItem(null, null);
  ValidationItem? amountTextV = ValidationItem(null, null);

  ValidationItem get name => nameTextV!;
  ValidationItem get identity_card => identityCardTextV!;
  ValidationItem get phone_number => phoneNumberTextV!;
  ValidationItem get apartment => apartmentTextV!;
  ValidationItem get reference_number => referenceNumberTextV!;
  ValidationItem get amount => amountTextV!;

  bool get validate {
    if (nameTextV!.value != null &&
        identityCardTextV!.value != null &&
        phoneNumberTextV!.value != null &&
        apartmentTextV!.value != null &&
        referenceNumberTextV!.value != null &&
        amountTextV!.value != null &&
        nameTextV!.value!.isNotEmpty &&
        identityCardTextV!.value!.isNotEmpty &&
        phoneNumberTextV!.value!.isNotEmpty &&
        apartmentTextV!.value!.isNotEmpty &&
        referenceNumberTextV!.value!.isNotEmpty &&
        amountTextV!.value!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String? nameChanged(String text) {
    if (text.isEmpty) {
      nameTextV = ValidationItem(null, 'Campo requerido.');
    } else if (text.length < 5) {
      nameTextV = ValidationItem(
          null, 'Longitud del dato menor a la mínima requerida.');
    } else if (text.length > 20) {
      nameTextV =
          ValidationItem(null, 'La longitud del dato es mayor a la requerida.');
    } else if (!text.isValidName) {
      nameTextV = ValidationItem(null, 'Dato Inválido');
    } else {
      nameTextV = ValidationItem(text, null);
    }
    notifyListeners();
    return null;
  }

  String? identityCardChanged(String text) {
    if (text.isEmpty) {
      identityCardTextV = ValidationItem(null, 'Campo requerido.');
    } else if (text.length < 5) {
      identityCardTextV = ValidationItem(
          null, 'Longitud del dato menor a la mínima requerida.');
    } else if (text.length > 20) {
      identityCardTextV =
          ValidationItem(null, 'La longitud del dato es mayor a la requerida.');
    } else if (!text.isValidNumber) {
      identityCardTextV = ValidationItem(null, 'Dato Inválido');
    } else {
      identityCardTextV = ValidationItem(text, null);
    }
    notifyListeners();
    return null;
  }

  String? phoneNumberChanged(String text) {
    if (text.isEmpty) {
      phoneNumberTextV = ValidationItem(null, 'Campo requerido.');
    } else if (text.length < 5) {
      phoneNumberTextV = ValidationItem(
          null, 'Longitud del dato menor a la mínima requerida.');
    } else if (text.length > 20) {
      phoneNumberTextV =
          ValidationItem(null, 'La longitud del dato es mayor a la requerida.');
    } else if (!text.isValidNumber) {
      phoneNumberTextV = ValidationItem(null, 'Dato Inválido');
    } else {
      phoneNumberTextV = ValidationItem(text, null);
    }
    notifyListeners();
    return null;
  }

  String? aparmentChanged(String text) {
    if (text.isEmpty) {
      apartmentTextV = ValidationItem(null, 'Campo requerido.');
    } else if (text.length < 2) {
      apartmentTextV = ValidationItem(
          null, 'Longitud del dato menor a la mínima requerida.');
    } else if (text.length > 5) {
      apartmentTextV =
          ValidationItem(null, 'La longitud del dato es mayor a la requerida.');
    } else if (!text.isValidate) {
      apartmentTextV = ValidationItem(null, 'Dato Inválido');
    } else {
      apartmentTextV = ValidationItem(text, null);
    }
    notifyListeners();
    return null;
  }

  String? referenceNumberChanged(String text) {
    if (text.isEmpty) {
      referenceNumberTextV = ValidationItem(null, 'Campo requerido.');
    } else if (text.length < 4) {
      referenceNumberTextV = ValidationItem(
          null, 'Longitud del dato menor a la mínima requerida.');
    } else if (text.length > 20) {
      referenceNumberTextV =
          ValidationItem(null, 'La longitud del dato es mayor a la requerida.');
    } else if (!text.isValidNumber) {
      referenceNumberTextV = ValidationItem(null, 'Dato Inválido');
    } else {
      referenceNumberTextV = ValidationItem(text, null);
    }
    notifyListeners();
    return null;
  }

  String? amountChanged(String text) {
    if (text.isEmpty) {
      amountTextV = ValidationItem(null, 'Campo requerido.');
    } else if (text.length < 2) {
      amountTextV = ValidationItem(
          null, 'Longitud del dato menor a la mínima requerida.');
    } else if (text.length > 12) {
      amountTextV =
          ValidationItem(null, 'La longitud del dato es mayor a la requerida.');
    } else if (!text.isValidDecimal) {
      amountTextV = ValidationItem(null, 'Dato Inválido');
    } else {
      amountTextV = ValidationItem(text, null);
    }
    notifyListeners();
    return null;
  }

  UpdatePaymentController(this._updatePaymentApi);

  Future<UpdatePaymentModel?> updatePayment(
    int idPayment, {
    String? name,
    String? identity_card,
    String? phone_number,
    String? apartment,
    String? reference_number,
    String? amount,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await _updatePaymentApi.updatePayment(
        id: idPayment,
        token: token!,
        name: name,
        identity_card: identity_card,
        phone_number: phone_number,
        apartment: apartment,
        reference_number: reference_number,
        amount: amount);

    notifyListeners();

    return response;
  }
}

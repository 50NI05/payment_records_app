// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:registro_pagos/app/data/providers/add_payment_api.dart';
import 'package:registro_pagos/app/helpers/extentions.dart';
import 'package:registro_pagos/app/ui/pages/add_payment/add_payment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helpers/validators.dart';

class AddPaymentController extends ChangeNotifier {
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

  final AddPaymentApi _addPaymentApi;
  late StreamSubscription _subscription;

  final String _query = '';
  String get query => _query;

  bool passwordVisible = true;
  IconData iconPassword = Icons.visibility_off_rounded;

  ValidationItem? nameTextV = ValidationItem(null, null);
  ValidationItem? identityCardTextV = ValidationItem(null, null);
  ValidationItem? phoneNumberTextV = ValidationItem(null, null);
  ValidationItem? apartmentTextV = ValidationItem(null, null);
  ValidationItem? referenceNumberTextV = ValidationItem(null, null);
  ValidationItem? amountTextV = ValidationItem(null, null);

  AddPaymentController(
    this._addPaymentApi, {
    required String name,
    required String identity_card,
    required String phone_number,
    required String apartment,
    required String reference_number,
    required String amount,
  }) {
    name = nameController.text;
    identity_card = identityCardController.text;
    phone_number = phoneNumberController.text;
    apartment = apartmentController.text;
    reference_number = referenceCodeController.text;
    amount = amountController.text;

    _subscription = _addPaymentApi.onResults.listen(
      (results) {
        debugPrint("🚩 results $results, $query");
        notifyListeners();
      },
    );
  }

  //Getters
  ValidationItem get name => nameTextV!;
  ValidationItem get identity_card => identityCardTextV!;
  ValidationItem get phone_number => phoneNumberTextV!;
  ValidationItem get apartment => apartmentTextV!;
  ValidationItem get reference_number => referenceNumberTextV!;
  ValidationItem get amount => amountTextV!;

  bool get validate {
    if (nameTextV!.value!= null &&
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
    } else if (!text.isValidNumber) {
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
    } else if (text.length < 5) {
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
    } else if (text.length < 3) {
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

  Future<AddPaymentModel?> addPayment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final AddPaymentModel result = (await _addPaymentApi.addPayment(
      name: nameController.text,
      identity_card: identityCardController.text,
      phone_number: phoneNumberController.text,
      apartment: apartmentController.text,
      reference_number: referenceCodeController.text,
      amount: amountController.text,
      token: token!
    ));

    notifyListeners();
    return result;
  }
}

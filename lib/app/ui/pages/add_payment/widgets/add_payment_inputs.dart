import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_pagos/app/ui/pages/add_payment/add_payment_controller.dart';

import '../../../../widgets/global_input.dart';

class AddPaymentInput extends StatelessWidget {
  const AddPaymentInput({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AddPaymentController>(context);
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          GlobalInput(
            controller: controller.nameController,
            keyboardType: TextInputType.text,
            validatorErrorText: controller.nameTextV!.error,
            focusNode: controller.nameFocusNode,
            placeholder: 'Nombre',
            validator: controller.validate,
            changed: controller.nameChanged,
            isPassword: false,
            passwordVisible: false,
            maxLength: 30,
            labelStyle: Colors.black,
            colorStyle: Colors.black,
            borderSide: Colors.black,
          ),
          GlobalInput(
            controller: controller.identityCardController,
            keyboardType: TextInputType.number,
            validatorErrorText: controller.identityCardTextV!.error,
            focusNode: controller.identityCardFocusNode,
            placeholder: 'Cédula de Identidad',
            validator: controller.validate,
            changed: controller.identityCardChanged,
            isPassword: false,
            passwordVisible: false,
            maxLength: 8,
            labelStyle: Colors.black,
            colorStyle: Colors.black,
            borderSide: Colors.black,
          ),
          GlobalInput(
            controller: controller.phoneNumberController,
            keyboardType: TextInputType.number,
            validatorErrorText: controller.phoneNumberTextV!.error,
            focusNode: controller.phoneNumberFocusNode,
            placeholder: 'Número de Teléfono',
            validator: controller.validate,
            changed: controller.phoneNumberChanged,
            isPassword: false,
            passwordVisible: false,
            maxLength: 11,
            labelStyle: Colors.black,
            colorStyle: Colors.black,
            borderSide: Colors.black,
          ),
          GlobalInput(
            controller: controller.apartmentController,
            keyboardType: TextInputType.text,
            validatorErrorText: controller.apartmentTextV!.error,
            focusNode: controller.aparmentFocusNode,
            placeholder: 'Nº de Apartamento',
            validator: controller.validate,
            changed: controller.aparmentChanged,
            isPassword: false,
            passwordVisible: false,
            maxLength: 5,
            labelStyle: Colors.black,
            colorStyle: Colors.black,
            borderSide: Colors.black,
          ),
          GlobalInput(
            controller: controller.referenceCodeController,
            keyboardType: TextInputType.number,
            validatorErrorText: controller.referenceNumberTextV!.error,
            focusNode: controller.referenceCodeFocusNode,
            placeholder: 'N° de Referencia',
            validator: controller.validate,
            changed: controller.referenceNumberChanged,
            isPassword: false,
            passwordVisible: false,
            maxLength: 5,
            labelStyle: Colors.black,
            colorStyle: Colors.black,
            borderSide: Colors.black,
          ),
          GlobalInput(
            controller: controller.amountController,
            keyboardType: TextInputType.number,
            validatorErrorText: controller.amountTextV!.error,
            focusNode: controller.amountFocusNode,
            placeholder: 'Monto',
            validator: controller.validate,
            changed: controller.amountChanged,
            isPassword: false,
            passwordVisible: false,
            maxLength: 5,
            labelStyle: Colors.black,
            colorStyle: Colors.black,
            borderSide: Colors.black,
          ),
        ],
      ),
    );
  }
}

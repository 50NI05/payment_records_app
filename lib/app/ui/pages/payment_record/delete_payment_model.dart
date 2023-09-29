// To parse this JSON data, do
//
//     final deletePaymentModel = deletePaymentModelFromJson(jsonString);

import 'dart:convert';

DeletePaymentModel deletePaymentModelFromJson(String str) =>
    DeletePaymentModel.fromJson(json.decode(str));

String deletePaymentModelToJson(DeletePaymentModel data) =>
    json.encode(data.toJson());

class DeletePaymentModel {
  final String status;

  DeletePaymentModel({
    required this.status,
  });

  factory DeletePaymentModel.fromJson(Map<String, dynamic> json) =>
      DeletePaymentModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

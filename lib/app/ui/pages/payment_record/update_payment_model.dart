// To parse this JSON data, do
//
//     final updatePaymentModel = updatePaymentModelFromJson(jsonString);

import 'dart:convert';

UpdatePaymentModel updatePaymentModelFromJson(String str) =>
    UpdatePaymentModel.fromJson(json.decode(str));

String updatePaymentModelToJson(UpdatePaymentModel data) =>
    json.encode(data.toJson());

class UpdatePaymentModel {
  final String status;
  final String data;

  UpdatePaymentModel({
    required this.status,
    required this.data,
  });

  factory UpdatePaymentModel.fromJson(Map<String, dynamic> json) =>
      UpdatePaymentModel(
        status: json["status"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
      };
}

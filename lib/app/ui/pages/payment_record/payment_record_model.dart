// To parse this JSON data, do
//
//     final getAllPaymentModel = getAllPaymentModelFromJson(jsonString);

import 'dart:convert';

GetAllPaymentModel getAllPaymentModelFromJson(String str) =>
    GetAllPaymentModel.fromJson(json.decode(str));

String getAllPaymentModelToJson(GetAllPaymentModel data) =>
    json.encode(data.toJson());

class GetAllPaymentModel {
  final String status;
  final List<Datum> data;

  GetAllPaymentModel({
    required this.status,
    required this.data,
  });

  factory GetAllPaymentModel.fromJson(Map<String, dynamic> json) =>
      GetAllPaymentModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final int id;
  final String name;
  final String? identityCard;
  final String? phoneNumber;
  final String? apartment;
  final String? referenceNumber;
  final String? amount;
  final DateTime? paymentDate;

  Datum({
    required this.id,
    required this.name,
    this.identityCard,
    this.phoneNumber,
    this.apartment,
    this.referenceNumber,
    this.amount,
    this.paymentDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        identityCard: json["identity_card"],
        phoneNumber: json["phone_number"],
        apartment: json["apartment"],
        referenceNumber: json["reference_number"],
        amount: json["amount"],
        paymentDate: json["payment_date"] == null
            ? null
            : DateTime.parse(json["payment_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "identity_card": identityCard,
        "phone_number": phoneNumber,
        "apartment": apartment,
        "reference_number": referenceNumber,
        "amount": amount,
        "payment_date": paymentDate?.toIso8601String(),
      };
}

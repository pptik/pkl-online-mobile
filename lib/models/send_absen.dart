// To parse this JSON data, do
//
//     final sendAbsen = sendAbsenFromJson(jsonString);

import 'dart:convert';

SendAbsen sendAbsenFromJson(String str) => SendAbsen.fromJson(json.decode(str));

String sendAbsenToJson(SendAbsen data) => json.encode(data.toJson());

class SendAbsen {
  String description;
  String name;
  String long;
  String lat;
  String address;
  String company;
  String unit;
  String status;
  String localImage;
  int msgType;
  int cmdType;
  String timestamp;
  String image;
  String guid;

  SendAbsen({
    this.description,
    this.name,
    this.long,
    this.lat,
    this.address,
    this.company,
    this.unit,
    this.status,
    this.localImage,
    this.msgType,
    this.cmdType,
    this.timestamp,
    this.image,
    this.guid,
  });

  factory SendAbsen.fromJson(Map<String, dynamic> json) => SendAbsen(
        description: json["DESCRIPTION"],
        name: json["NAME"],
        long: json["LONG"],
        lat: json["LAT"],
        address: json["ADDRESS"],
        company: json["COMPANY"],
        unit: json["UNIT"],
        status: json["STATUS"],
        localImage: json["LOCAL_IMAGE"],
        msgType: json["MSG_TYPE"],
        cmdType: json["CMD_TYPE"],
        timestamp: json["TIMESTAMP"],
        image: json["IMAGE"],
        guid: json["GUID"],
      );

  Map<String, dynamic> toJson() => {
        "DESCRIPTION": description,
        "NAME": name,
        "LONG": long,
        "LAT": lat,
        "ADDRESS": address,
        "COMPANY": company,
        "UNIT": unit,
        "STATUS": status,
        "LOCAL_IMAGE": localImage,
        "MSG_TYPE": msgType,
        "CMD_TYPE": cmdType,
        "TIMESTAMP": timestamp,
        "IMAGE": image,
        "GUID": guid,
      };
}

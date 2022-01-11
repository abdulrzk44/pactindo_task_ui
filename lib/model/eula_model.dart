// To parse this JSON data, do
//
//     final eulaResp = eulaRespFromJson(jsonString);

import 'dart:convert';

EulaModel eulaRespFromJson(Map<String, dynamic> str) => EulaModel.fromJson(str);

String eulaRespToJson(EulaModel data) => json.encode(data.toJson());

class EulaModel {
    EulaModel({
        this.eulaHtml,
    });

    String? eulaHtml;

    factory EulaModel.fromJson(Map<String, dynamic> json) => EulaModel(
        eulaHtml: json["eulaHtml"] == null ? null : json["eulaHtml"],
    );

    Map<String, dynamic> toJson() => {
        "eulaHtml": eulaHtml == null ? null : eulaHtml,
    };
}

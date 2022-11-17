// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppModel {
  String? title;
  String? description;
  String? bannerLink;
  Color? color;
  String? image;
  List<AppModel>? subKit;
  Widget? widget;
  bool? isDarkModeSupported;
  String? themeType;
  bool? isContainsScaffold;
  String? tag;

  AppModel({
    this.title,
    this.description,
    this.color,
    this.image,
    this.subKit,
    this.widget,
    this.bannerLink,
    this.isDarkModeSupported,
    this.themeType,
    this.isContainsScaffold,
    this.tag,
  });

  factory AppModel.fromJson(Map<String, dynamic> data) {
    return AppModel(
      title: data["title"],
      description: data["description"],
      image: data["image"],
      color: data["color"],
      subKit: data["subKit"],
      widget: data["widget"],
      isDarkModeSupported: data["isDarkModeSupported"],
      bannerLink: data["bannerLink"],
      themeType: data["themeType"],
      isContainsScaffold: data["isContainsScaffold"],
      tag: data["tag"],
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return {
      data["title"]: title,
      data["description"]: description,
      data["image"]: image,
      data["color"]: color,
      data["subKit"]: subKit,
      data["widget"]: widget,
      data["isDarkModeSupported"]: isDarkModeSupported,
      data["bannerLink"]: bannerLink,
      data["themeType"]: themeType,
      data["isContainsScaffold"]: isContainsScaffold,
      data["tag"]: tag,
    };
  }
}

// class SuggestionModel {
//   String? name;
//   String? email;
//   String? feedback;
//   String? id;
//   Timestamp? timestamp;

//   SuggestionModel(
//       {this.name, this.email, this.feedback, this.id, this.timestamp});

//   factory SuggestionModel.fromJson(Map<String, dynamic> json) {
//     return SuggestionModel(
//       name: json['name'],
//       email: json['email'],
//       feedback: json['feedback'],
//       id: json['id'],
//       timestamp: json['timestamp'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['email'] = email;
//     data['feedback'] = feedback;
//     data['timestamp'] = timestamp;

//     return data;
//   }
// }

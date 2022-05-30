import 'package:flutter/foundation.dart';

abstract class BaseModel extends ChangeNotifier {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int version = 0;

  BaseModel(this.id) : createdAt = DateTime.now().toUtc();

  BaseModel.fromJson(
    Map<String, dynamic> data,
  ) {
    var id = data["id"];

    if (id is int) {
      this.id = "${data['id']}";
    } else {
      this.id = data["id"];
    }

    version = data["version"] ?? 0;
    var dateC = data["createdAt"];
    createdAt = dateC?.toDate();

    var dateU = data["updatedAt"];
    updatedAt = dateU?.toDate() ?? DateTime.now();
  }

  bool isEqual(BaseModel model) {
    return id == model.id;
  }

  Map<String, dynamic> toJson({bool ignoreUpdatedAt = false}) {
    var result = <String, dynamic>{};

    if (id != null) result["id"] = id;

    if (createdAt != null) {
      result["createdAt"] = createdAt;
    }

    if (!ignoreUpdatedAt) {
      result["updatedAt"] = DateTime.now();
    }

    if (version > 0 && !ignoreUpdatedAt) {
      result["version"] = version;
    }
    return result;
  }
}

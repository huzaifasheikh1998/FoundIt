class GetBoxes {
  String? status;
  String? message;
  List<Box>? data;

  GetBoxes({this.status, this.message, this.data});

  GetBoxes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['Data'] != null) {
      data = <Box>[];
      json['Data'].forEach((v) {
        data!.add(new Box.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Box {
  int? id;
  String? boxName;
  String? thumbnail;

  Box({this.id, this.boxName, this.thumbnail});

  Box.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    boxName = json['box_name'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['box_name'] = this.boxName;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}

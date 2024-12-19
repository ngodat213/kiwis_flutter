import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';

class PlanLocationModel {
  String? planLocationId;
  String? name;
  double? latitude;
  double? longitude;
  String? address;
  String? googlePlaceId;
  int? estimatedCost;
  int? estimatedTime;
  bool? isCompleted;
  String? imageId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  PlanLocationModel(
      {this.planLocationId,
      this.name,
      this.latitude,
      this.longitude,
      this.address,
      this.googlePlaceId,
      this.estimatedCost,
      this.estimatedTime,
      this.isCompleted,
      this.imageId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  LatLng get latLng => LatLng(latitude ?? 0, longitude ?? 0);

  PlanLocationModel.fromJson(Map<String, dynamic> json) {
    planLocationId = json['planLocationId'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    googlePlaceId = json['googlePlaceId'];
    estimatedCost = json['estimatedCost'];
    estimatedTime = json['estimatedTime'];
    isCompleted = json['isCompleted'];
    imageId = json['imageId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['planLocationId'] = this.planLocationId;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['googlePlaceId'] = this.googlePlaceId;
    data['estimatedCost'] = this.estimatedCost;
    data['estimatedTime'] = this.estimatedTime;
    data['isCompleted'] = this.isCompleted;
    data['imageId'] = this.imageId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    return data;
  }
}

class CloudinaryImageModel {
  String? cloudinaryImageId;
  String? planId;
  String? publicId;
  String? imageUrl;
  String? type;
  String? format;
  int? width;
  int? height;
  String? createdAt;

  CloudinaryImageModel(
      {this.cloudinaryImageId,
      this.planId,
      this.publicId,
      this.imageUrl,
      this.type,
      this.format,
      this.width,
      this.height,
      this.createdAt});

  CloudinaryImageModel.fromJson(Map<String, dynamic> json) {
    cloudinaryImageId = json['cloudinaryImageId'];
    planId = json['planId'] ?? "";
    publicId = json['publicId'];
    imageUrl = json['imageUrl'];
    type = json['type'];
    format = json['format'];
    width = json['width'];
    height = json['height'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cloudinaryImageId'] = this.cloudinaryImageId;
    data['planId'] = this.planId;
    data['publicId'] = this.publicId;
    data['imageUrl'] = this.imageUrl;
    data['type'] = this.type;
    data['format'] = this.format;
    data['width'] = this.width;
    data['height'] = this.height;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

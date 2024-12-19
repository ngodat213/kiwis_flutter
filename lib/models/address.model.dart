import 'package:vietmap_gl_platform_interface/vietmap_gl_platform_interface.dart'
    as vietmap;

class AddressModel {
  String? id;
  String? name;
  String? address;
  String? display;
  double? distance;
  List<Boundary>? boundaries;
  List<String>? categories;
  vietmap.LatLng? coordinates;

  AddressModel({
    this.id,
    this.name,
    this.address,
    this.display,
    this.distance,
    this.boundaries,
    this.categories,
    this.coordinates,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['ref_id'],
      name: map['name'],
      address: map['address'],
      display: map['display'],
      distance: map['distance']?.toDouble(),
      boundaries: map['boundaries'] != null
          ? List<Boundary>.from(
              map['boundaries'].map((x) => Boundary.fromMap(x)))
          : null,
      categories: map['categories'] != null
          ? List<String>.from(map['categories'])
          : null,
    );
  }
}

class Boundary {
  int? type;
  int? id;
  String? name;
  String? prefix;
  String? fullName;

  Boundary({
    this.type,
    this.id,
    this.name,
    this.prefix,
    this.fullName,
  });

  factory Boundary.fromMap(Map<String, dynamic> map) {
    return Boundary(
      type: map['type'],
      id: map['id'],
      name: map['name'],
      prefix: map['prefix'],
      fullName: map['full_name'],
    );
  }

  String get formattedName => prefix != null ? '$prefix $name' : name ?? '';
}

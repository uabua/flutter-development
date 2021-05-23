import 'package:assignment_05/data/models/geo.dart';

class Address {
  String? street;
  String? suite;
  String? city;
  String? zipcode;
  Geo? geo;

  Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
    geo = json['geo'] != null ? Geo.fromJson(json['geo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> addressInfo = {
      'street': street,
      'suite': suite,
      'city': city,
      'zipcode': zipcode,
    };

    if (geo != null) {
      addressInfo['geo'] = geo!.toJson();
    }

    return addressInfo;
  }
}

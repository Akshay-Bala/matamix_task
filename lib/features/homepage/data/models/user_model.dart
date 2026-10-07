class GeoModel {
  final String lat;
  final String lng;

  const GeoModel({
    required this.lat,
    required this.lng,
  });

  factory GeoModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const GeoModel(lat: '', lng: '');
    }
    return GeoModel(
      lat: json['lat']?.toString() ?? '',
      lng: json['lng']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };
}

class AddressModel {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final GeoModel geo;

  const AddressModel({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory AddressModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const AddressModel(
        street: '',
        suite: '',
        city: '',
        zipcode: '',
        geo: GeoModel(lat: '', lng: ''),
      );
    }
    return AddressModel(
      street: json['street']?.toString() ?? '',
      suite: json['suite']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      zipcode: json['zipcode']?.toString() ?? '',
      geo: GeoModel.fromJson(json['geo'] as Map<String, dynamic>?),
    );
  }

  String get fullAddress {
    final parts = [suite, street, city, zipcode].where((s) => s.isNotEmpty);
    return parts.join(', ');
  }

  Map<String, dynamic> toJson() => {
        'street': street,
        'suite': suite,
        'city': city,
        'zipcode': zipcode,
        'geo': geo.toJson(),
      };
}

class CompanyModel {
  final String name;
  final String catchPhrase;
  final String bs;

  const CompanyModel({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory CompanyModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const CompanyModel(name: '', catchPhrase: '', bs: '');
    }
    return CompanyModel(
      name: json['name']?.toString() ?? '',
      catchPhrase: json['catchPhrase']?.toString() ?? '',
      bs: json['bs']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'catchPhrase': catchPhrase,
        'bs': bs,
      };
}

class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final AddressModel address;
  final String phone;
  final String website;
  final CompanyModel company;

  const UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is int ? json['id'] as int : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>?),
      phone: json['phone']?.toString() ?? '',
      website: json['website']?.toString() ?? '',
      company: CompanyModel.fromJson(json['company'] as Map<String, dynamic>?),
    );
  }

  String get initials {
    if (name.isEmpty) return 'U';
    final parts = name.trim().split(' ').where((s) => s.isNotEmpty).toList();
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'email': email,
        'address': address.toJson(),
        'phone': phone,
        'website': website,
        'company': company.toJson(),
      };
}

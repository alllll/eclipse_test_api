import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
@immutable
class User {
  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final Address address;
  @HiveField(5)
  final String phone;
  @HiveField(6)
  final String website;
  @HiveField(7)
  final Company company;

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      phone: json['phone'] as String,
      website: json['website'] as String,
      company: Company.fromJson(json['company'] as Map<String, dynamic>));

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'email': email,
        'address': address.toJson(),
        'phone': phone,
        'website': website,
        'company': company.toJson()
      };

  User clone() => User(
      id: id,
      name: name,
      username: username,
      email: email,
      address: address.clone(),
      phone: phone,
      website: website,
      company: company.clone());

  User copyWith(
          {int? id,
          String? name,
          String? username,
          String? email,
          Address? address,
          String? phone,
          String? website,
          Company? company}) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        website: website ?? this.website,
        company: company ?? this.company,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          id == other.id &&
          name == other.name &&
          username == other.username &&
          email == other.email &&
          address == other.address &&
          phone == other.phone &&
          website == other.website &&
          company == other.company;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      username.hashCode ^
      email.hashCode ^
      address.hashCode ^
      phone.hashCode ^
      website.hashCode ^
      company.hashCode;
}

List<User> parseUsers(String response) {
  final parsed = jsonDecode(response).cast<Map<String, dynamic>>();

  return parsed.map<User>((json) => User.fromJson(json)).toList();
}

@HiveType(typeId: 1)
@immutable
class Address {
  const Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  @HiveField(0)
  final String street;
  @HiveField(1)
  final String suite;
  @HiveField(2)
  final String city;
  @HiveField(3)
  final String zipcode;
  @HiveField(4)
  final Geo geo;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
      street: json['street'] as String,
      suite: json['suite'] as String,
      city: json['city'] as String,
      zipcode: json['zipcode'] as String,
      geo: Geo.fromJson(json['geo'] as Map<String, dynamic>));

  Map<String, dynamic> toJson() => {
        'street': street,
        'suite': suite,
        'city': city,
        'zipcode': zipcode,
        'geo': geo.toJson()
      };

  Address clone() => Address(
      street: street,
      suite: suite,
      city: city,
      zipcode: zipcode,
      geo: geo.clone());

  Address copyWith(
          {String? street,
          String? suite,
          String? city,
          String? zipcode,
          Geo? geo}) =>
      Address(
        street: street ?? this.street,
        suite: suite ?? this.suite,
        city: city ?? this.city,
        zipcode: zipcode ?? this.zipcode,
        geo: geo ?? this.geo,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Address &&
          street == other.street &&
          suite == other.suite &&
          city == other.city &&
          zipcode == other.zipcode &&
          geo == other.geo;

  @override
  int get hashCode =>
      street.hashCode ^
      suite.hashCode ^
      city.hashCode ^
      zipcode.hashCode ^
      geo.hashCode;
}

@HiveType(typeId: 3)
@immutable
class Geo {
  const Geo({
    required this.lat,
    required this.lng,
  });

  @HiveField(0)
  final String lat;
  @HiveField(1)
  final String lng;

  factory Geo.fromJson(Map<String, dynamic> json) =>
      Geo(lat: json['lat'] as String, lng: json['lng'] as String);

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};

  Geo clone() => Geo(lat: lat, lng: lng);

  Geo copyWith({String? lat, String? lng}) => Geo(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Geo && lat == other.lat && lng == other.lng;

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode;
}

@HiveType(typeId: 4)
@immutable
class Company {
  const Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  @HiveField(0)
  final String name;
  @HiveField(1)
  final String catchPhrase;
  @HiveField(2)
  final String bs;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
      name: json['name'] as String,
      catchPhrase: json['catchPhrase'] as String,
      bs: json['bs'] as String);

  Map<String, dynamic> toJson() =>
      {'name': name, 'catchPhrase': catchPhrase, 'bs': bs};

  Company clone() => Company(name: name, catchPhrase: catchPhrase, bs: bs);

  Company copyWith({String? name, String? catchPhrase, String? bs}) => Company(
        name: name ?? this.name,
        catchPhrase: catchPhrase ?? this.catchPhrase,
        bs: bs ?? this.bs,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Company &&
          name == other.name &&
          catchPhrase == other.catchPhrase &&
          bs == other.bs;

  @override
  int get hashCode => name.hashCode ^ catchPhrase.hashCode ^ bs.hashCode;
}

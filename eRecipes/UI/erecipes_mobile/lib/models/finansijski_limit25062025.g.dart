// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finansijski_limit25062025.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinanskijskiLimit25062025 _$FinanskijskiLimit25062025FromJson(
        Map<String, dynamic> json) =>
    FinanskijskiLimit25062025()
      ..finansijskiLimit25062026Id =
          (json['finansijskiLimit25062026Id'] as num?)?.toInt()
      ..korisnikId = (json['korisnikId'] as num?)?.toInt()
      ..korisnik = json['korisnik'] == null
          ? null
          : Korisnik.FromJson(json['korisnik'] as Map<String, dynamic>)
      ..kategorijaTransakcije25062025Id =
          (json['kategorijaTransakcije25062025Id'] as num?)?.toInt()
      ..kategorijaTransakcije25062025 =
          json['kategorijaTransakcije25062025'] == null
              ? null
              : KategorijaTransakcije25062025.FromJson(
                  json['kategorijaTransakcije25062025'] as Map<String, dynamic>)
      ..limit = (json['limit'] as num?)?.toDouble();

Map<String, dynamic> _$FinanskijskiLimit25062025ToJson(
        FinanskijskiLimit25062025 instance) =>
    <String, dynamic>{
      'finansijskiLimit25062026Id': instance.finansijskiLimit25062026Id,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'kategorijaTransakcije25062025Id':
          instance.kategorijaTransakcije25062025Id,
      'kategorijaTransakcije25062025': instance.kategorijaTransakcije25062025,
      'limit': instance.limit,
    };

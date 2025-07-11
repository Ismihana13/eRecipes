// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finansijski_limit14072025.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinansijskiLimit14072025 _$FinansijskiLimit14072025FromJson(
        Map<String, dynamic> json) =>
    FinansijskiLimit14072025()
      ..finansijskiLimit14072025Id =
          (json['finansijskiLimit14072025Id'] as num?)?.toInt()
      ..limit = (json['limit'] as num?)?.toDouble()
      ..korisnikId = (json['korisnikId'] as num?)?.toInt()
      ..korisnik = json['korisnik'] == null
          ? null
          : Korisnik.FromJson(json['korisnik'] as Map<String, dynamic>)
      ..kategorijaTransakcije14072025 =
          json['kategorijaTransakcije14072025'] == null
              ? null
              : KategorijaTransakcije14072025.FromJson(
                  json['kategorijaTransakcije14072025'] as Map<String, dynamic>)
      ..kategorijaTransakcije14072025Id =
          (json['kategorijaTransakcije14072025Id'] as num?)?.toInt();

Map<String, dynamic> _$FinansijskiLimit14072025ToJson(
        FinansijskiLimit14072025 instance) =>
    <String, dynamic>{
      'finansijskiLimit14072025Id': instance.finansijskiLimit14072025Id,
      'limit': instance.limit,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'kategorijaTransakcije14072025': instance.kategorijaTransakcije14072025,
      'kategorijaTransakcije14072025Id':
          instance.kategorijaTransakcije14072025Id,
    };

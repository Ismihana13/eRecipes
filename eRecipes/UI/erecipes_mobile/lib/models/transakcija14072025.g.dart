// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transakcija14072025.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transakcija14072025 _$Transakcija14072025FromJson(Map<String, dynamic> json) =>
    Transakcija14072025(
      (json['korisnikId'] as num?)?.toInt(),
      (json['iznos'] as num?)?.toDouble(),
      json['datumTransakcije'] == null
          ? null
          : DateTime.parse(json['datumTransakcije'] as String),
      json['opis'] as String?,
      (json['kategorijaTransakcije14072025Id'] as num?)?.toInt(),
      json['status'] as String?,
    )
      ..transakcija14072025Id = (json['transakcija14072025Id'] as num?)?.toInt()
      ..korisnik = json['korisnik'] == null
          ? null
          : Korisnik.FromJson(json['korisnik'] as Map<String, dynamic>)
      ..kategorijaTransakcije14072025 = json['kategorijaTransakcije14072025'] ==
              null
          ? null
          : KategorijaTransakcije14072025.FromJson(
              json['kategorijaTransakcije14072025'] as Map<String, dynamic>);

Map<String, dynamic> _$Transakcija14072025ToJson(
        Transakcija14072025 instance) =>
    <String, dynamic>{
      'transakcija14072025Id': instance.transakcija14072025Id,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'kategorijaTransakcije14072025Id':
          instance.kategorijaTransakcije14072025Id,
      'kategorijaTransakcije14072025': instance.kategorijaTransakcije14072025,
      'iznos': instance.iznos,
      'datumTransakcije': instance.datumTransakcije?.toIso8601String(),
      'opis': instance.opis,
      'status': instance.status,
    };

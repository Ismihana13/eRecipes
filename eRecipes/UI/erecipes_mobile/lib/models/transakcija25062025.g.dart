// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transakcija25062025.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transakcija25062025 _$Transakcija25062025FromJson(Map<String, dynamic> json) =>
    Transakcija25062025(
      (json['korisnikId'] as num?)?.toInt(),
      (json['iznos'] as num?)?.toDouble(),
      json['datumTransakcije'] == null
          ? null
          : DateTime.parse(json['datumTransakcije'] as String),
      json['opis'] as String?,
      (json['kategorijaTransakcije25062025Id'] as num?)?.toInt(),
      json['status'] as String?,
    )
      ..transakcija25062025Id = (json['transakcija25062025Id'] as num?)?.toInt()
      ..korisnik = json['korisnik'] == null
          ? null
          : Korisnik.FromJson(json['korisnik'] as Map<String, dynamic>)
      ..kategorijaTransakcije25062025 = json['kategorijaTransakcije25062025'] ==
              null
          ? null
          : KategorijaTransakcije25062025.FromJson(
              json['kategorijaTransakcije25062025'] as Map<String, dynamic>);

Map<String, dynamic> _$Transakcija25062025ToJson(
        Transakcija25062025 instance) =>
    <String, dynamic>{
      'transakcija25062025Id': instance.transakcija25062025Id,
      'korisnikId': instance.korisnikId,
      'iznos': instance.iznos,
      'datumTransakcije': instance.datumTransakcije?.toIso8601String(),
      'opis': instance.opis,
      'kategorijaTransakcije25062025Id':
          instance.kategorijaTransakcije25062025Id,
      'status': instance.status,
      'korisnik': instance.korisnik,
      'kategorijaTransakcije25062025': instance.kategorijaTransakcije25062025,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fit_pasos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FitPasos _$FitPasosFromJson(Map<String, dynamic> json) => FitPasos(
      (json['korisnikId'] as num?)?.toInt(),
      json['datumIzdavanja'] == null
          ? null
          : DateTime.parse(json['datumIzdavanja'] as String),
      json['validan'] as bool?,
    )
      ..fitPasosId = (json['fitPasosId'] as num?)?.toInt()
      ..korisnik = json['korisnik'] == null
          ? null
          : Korisnik.FromJson(json['korisnik'] as Map<String, dynamic>);

Map<String, dynamic> _$FitPasosToJson(FitPasos instance) => <String, dynamic>{
      'fitPasosId': instance.fitPasosId,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'datumIzdavanja': instance.datumIzdavanja?.toIso8601String(),
      'validan': instance.validan,
    };

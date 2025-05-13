// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sastojak.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sastojak _$SastojakFromJson(Map<String, dynamic> json) => Sastojak(
      sastojakId: (json['sastojakId'] as num?)?.toInt(),
      naziv: json['naziv'] as String?,
      kolicina: json['kolicina'] as double?,
      mjernaJedinicaId: (json['mjernaJedinicaId'] as num?)?.toInt(),
      nazivMjerneJedinice: json['nazivMjerneJedinice'] as String?,
    );

Map<String, dynamic> _$SastojakToJson(Sastojak instance) => <String, dynamic>{
      'sastojakId': instance.sastojakId,
      'naziv': instance.naziv,
      'kolicina': instance.kolicina,
      'mjernaJedinicaId': instance.mjernaJedinicaId,
      'nazivMjerneJedinice': instance.nazivMjerneJedinice,
    };

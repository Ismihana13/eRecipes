// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mjerna_jedinica.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MjernaJedinica _$MjernaJedinicaFromJson(Map<String, dynamic> json) =>
    MjernaJedinica()
      ..mjernaJedinicaId = (json['mjernaJedinicaId'] as num?)?.toInt()
      ..naziv = json['naziv'] as String?
      ..oznaka = json['oznaka'] as String?;

Map<String, dynamic> _$MjernaJedinicaToJson(MjernaJedinica instance) =>
    <String, dynamic>{
      'mjernaJedinicaId': instance.mjernaJedinicaId,
      'naziv': instance.naziv,
      'oznaka': instance.oznaka,
    };

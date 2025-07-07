// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat_kategorija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatKategorija _$StatKategorijaFromJson(Map<String, dynamic> json) =>
    StatKategorija()
      ..naziv = json['naziv'] as String?
      ..iznos = (json['iznos'] as num?)?.toDouble();

Map<String, dynamic> _$StatKategorijaToJson(StatKategorija instance) =>
    <String, dynamic>{
      'naziv': instance.naziv,
      'iznos': instance.iznos,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iznos_kategorija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IznosKategorija _$IznosKategorijaFromJson(Map<String, dynamic> json) =>
    IznosKategorija()
      ..nazivKategorije = json['nazivKategorije'] as String?
      ..iznos = (json['iznos'] as num?)?.toDouble();

Map<String, dynamic> _$IznosKategorijaToJson(IznosKategorija instance) =>
    <String, dynamic>{
      'nazivKategorije': instance.nazivKategorije,
      'iznos': instance.iznos,
    };

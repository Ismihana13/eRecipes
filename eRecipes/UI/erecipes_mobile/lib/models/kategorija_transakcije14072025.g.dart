// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kategorija_transakcije14072025.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KategorijaTransakcije14072025 _$KategorijaTransakcije14072025FromJson(
        Map<String, dynamic> json) =>
    KategorijaTransakcije14072025()
      ..kategorijaTransakcije14072025Id =
          (json['kategorijaTransakcije14072025Id'] as num?)?.toInt()
      ..naziv = json['naziv'] as String?
      ..tip = json['tip'] as String?;

Map<String, dynamic> _$KategorijaTransakcije14072025ToJson(
        KategorijaTransakcije14072025 instance) =>
    <String, dynamic>{
      'kategorijaTransakcije14072025Id':
          instance.kategorijaTransakcije14072025Id,
      'naziv': instance.naziv,
      'tip': instance.tip,
    };

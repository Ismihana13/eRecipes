// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kategorija_transakcije25062025.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KategorijaTransakcije25062025 _$KategorijaTransakcije25062025FromJson(
        Map<String, dynamic> json) =>
    KategorijaTransakcije25062025()
      ..kategorijaTransakcije25062025Id =
          (json['kategorijaTransakcije25062025Id'] as num?)?.toInt()
      ..naziv = json['naziv'] as String?
      ..tip = json['tip'] as String?;

Map<String, dynamic> _$KategorijaTransakcije25062025ToJson(
        KategorijaTransakcije25062025 instance) =>
    <String, dynamic>{
      'kategorijaTransakcije25062025Id':
          instance.kategorijaTransakcije25062025Id,
      'naziv': instance.naziv,
      'tip': instance.tip,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vrsta_jela.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VrstaJela _$VrstaJelaFromJson(Map<String, dynamic> json) => VrstaJela()
  ..vrstaJelaId = (json['vrstaJelaId'] as num?)?.toInt()
  ..naziv = json['naziv'] as String?;

Map<String, dynamic> _$VrstaJelaToJson(VrstaJela instance) => <String, dynamic>{
      'vrstaJelaId': instance.vrstaJelaId,
      'naziv': instance.naziv,
    };

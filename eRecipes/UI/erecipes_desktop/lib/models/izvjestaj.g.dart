// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'izvjestaj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Izvjestaj _$IzvjestajFromJson(Map<String, dynamic> json) => Izvjestaj()
  ..izvjestajId = (json['izvjestajId'] as num?)?.toInt()
  ..receptId = (json['receptId'] as num?)?.toInt()
  ..brojLajkova = (json['brojLajkova'] as num?)?.toInt()
  ..brojOmiljenih = (json['brojOmiljenih'] as num?)?.toInt()
  ..datumIzvjestaja = json['datumIzvjestaja'] == null
      ? null
      : DateTime.parse(json['datumIzvjestaja'] as String)
  ..recept = json['recept'] == null
      ? null
      : Recept.FromJson(json['recept'] as Map<String, dynamic>);

Map<String, dynamic> _$IzvjestajToJson(Izvjestaj instance) => <String, dynamic>{
      'izvjestajId': instance.izvjestajId,
      'receptId': instance.receptId,
      'brojLajkova': instance.brojLajkova,
      'brojOmiljenih': instance.brojOmiljenih,
      'datumIzvjestaja': instance.datumIzvjestaja?.toIso8601String(),
      'recept': instance.recept,
    };

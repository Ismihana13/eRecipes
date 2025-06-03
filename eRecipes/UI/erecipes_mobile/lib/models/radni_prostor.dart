import 'package:json_annotation/json_annotation.dart';

part 'radni_prostor.g.dart';

@JsonSerializable()
class RadniProstor {
  int? radniProstorId;
  String? oznaka;
  int? kapacitet;
  bool? aktivan;

  RadniProstor();

  factory RadniProstor.FromJson(Map<String, dynamic> json) =>
      _$RadniProstorFromJson(json);

 Map<String, dynamic> toJson() => _$RadniProstorToJson(this);
}

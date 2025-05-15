import 'package:erecipes_desktop/models/recept.dart';
import 'package:json_annotation/json_annotation.dart';

part 'izvjestaj.g.dart';

@JsonSerializable()
class Izvjestaj {
  int? izvjestajId;
  int? receptId;
  int? brojLajkova;
  int? brojOmiljenih;
  DateTime? datumIzvjestaja;
  Recept? recept;

  Izvjestaj({required this.receptId});

  factory Izvjestaj.FromJson(Map<String, dynamic> json) =>
      _$IzvjestajFromJson(json);

  Map<String, dynamic> toJson() => _$IzvjestajToJson(this);
}

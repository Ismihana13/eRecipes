import 'package:json_annotation/json_annotation.dart';

part 'stat_kategorija.g.dart';

@JsonSerializable()
class StatKategorija {
String? naziv;
double? iznos;

  StatKategorija();

  factory StatKategorija.FromJson(Map<String, dynamic> json) =>
      _$StatKategorijaFromJson(json);

  Map<String, dynamic> toJson() => _$StatKategorijaToJson(this);
}

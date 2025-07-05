import 'package:json_annotation/json_annotation.dart';

part 'iznos_kategorija.g.dart';

@JsonSerializable()
class IznosKategorija {
  String? nazivKategorije;
  double? iznos;

  IznosKategorija();

  factory IznosKategorija.FromJson(Map<String, dynamic> json) =>
      _$IznosKategorijaFromJson(json);

  Map<String, dynamic> toJson() => _$IznosKategorijaToJson(this);
}

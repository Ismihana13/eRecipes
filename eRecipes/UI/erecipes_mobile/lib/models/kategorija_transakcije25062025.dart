import 'package:json_annotation/json_annotation.dart';

part 'kategorija_transakcije25062025.g.dart';

@JsonSerializable()
class KategorijaTransakcije25062025 {
  int? kategorijaTransakcije25062025Id;
  String? naziv;
  String? tip;

  KategorijaTransakcije25062025();

  factory KategorijaTransakcije25062025.FromJson(Map<String, dynamic> json) =>
      _$KategorijaTransakcije25062025FromJson(json);

  Map<String, dynamic> toJson() => _$KategorijaTransakcije25062025ToJson(this);
}

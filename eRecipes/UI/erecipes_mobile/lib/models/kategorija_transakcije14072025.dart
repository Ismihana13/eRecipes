
import 'package:json_annotation/json_annotation.dart';

part 'kategorija_transakcije14072025.g.dart';

@JsonSerializable()
class KategorijaTransakcije14072025 {
  int? kategorijaTransakcije14072025Id;
  String? naziv;
  String? tip;

  KategorijaTransakcije14072025();

  factory KategorijaTransakcije14072025.FromJson(Map<String, dynamic> json) =>
     _$KategorijaTransakcije14072025FromJson(json);

  Map<String, dynamic> toJson() => _$KategorijaTransakcije14072025ToJson(this);
}

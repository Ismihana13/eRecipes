
import 'package:erecipes_mobile/models/kategorija_transakcije14072025.dart';
import 'package:erecipes_mobile/models/korisnik.dart';
import 'package:json_annotation/json_annotation.dart';

part 'finansijski_limit14072025.g.dart';

@JsonSerializable()
class FinansijskiLimit14072025 {
  int? finansijskiLimit14072025Id;
  double? limit;
  int? korisnikId;
  Korisnik? korisnik;
  KategorijaTransakcije14072025? kategorijaTransakcije14072025;
  int? kategorijaTransakcije14072025Id;
 

  FinansijskiLimit14072025();

  factory FinansijskiLimit14072025.FromJson(Map<String, dynamic> json) =>
     _$FinansijskiLimit14072025FromJson(json);

  Map<String, dynamic> toJson() => _$FinansijskiLimit14072025ToJson(this);
}

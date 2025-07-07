import 'package:erecipes_mobile/models/kategorija_transakcije25062025.dart';
import 'package:erecipes_mobile/models/korisnik.dart';
import 'package:json_annotation/json_annotation.dart';

part 'finansijski_limit25062025.g.dart';

@JsonSerializable()
class FinansijskiLimit25062025 {
  int? finansijskiLimit25062025Id;
  double? limit;
  int? korisnikId;
  Korisnik? korisnik;
  KategorijaTransakcije25062025? kategorijaTransakcije25062025;
  int? kategorijaTransakcije25062025Id;

  FinansijskiLimit25062025();

  factory FinansijskiLimit25062025.FromJson(Map<String, dynamic> json) =>
      _$FinansijskiLimit25062025FromJson(json);

  Map<String, dynamic> toJson() => _$FinansijskiLimit25062025ToJson(this);
}

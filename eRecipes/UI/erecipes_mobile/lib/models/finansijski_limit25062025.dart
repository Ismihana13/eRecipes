import 'package:erecipes_mobile/models/kategorija_transakcije25062025.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:erecipes_mobile/models/korisnik.dart';

part 'finansijski_limit25062025.g.dart';

@JsonSerializable()
class FinanskijskiLimit25062025 {
     int? finansijskiLimit25062026Id;
   int? korisnikId;
   Korisnik?  korisnik ;
   int? kategorijaTransakcije25062025Id ;

 KategorijaTransakcije25062025? kategorijaTransakcije25062025 ;
   double? limit;

  FinanskijskiLimit25062025();

  factory FinanskijskiLimit25062025.FromJson(Map<String, dynamic> json) =>
     _$FinanskijskiLimit25062025FromJson(json);
//
   Map<String, dynamic> toJson() => _$FinanskijskiLimit25062025ToJson(this);
}

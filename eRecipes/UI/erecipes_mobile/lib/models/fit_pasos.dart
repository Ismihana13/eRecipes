import 'package:json_annotation/json_annotation.dart';
import 'package:erecipes_mobile/models/korisnik.dart';


part 'fit_pasos.g.dart';

@JsonSerializable()
class FitPasos {
  int? fitPasosId;
 int? korisnikId;
 Korisnik? korisnik;
 DateTime? datumIzdavanja;
 bool? validan;

  FitPasos(
    this.korisnikId,
    this.datumIzdavanja,
    this.validan
  );

  factory FitPasos.FromJson(Map<String, dynamic> json) =>
      _$FitPasosFromJson(json);

  Map<String, dynamic> toJson() => _$FitPasosToJson(this);
}

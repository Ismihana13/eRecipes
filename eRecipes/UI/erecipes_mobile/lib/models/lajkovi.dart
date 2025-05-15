import 'package:erecipes_mobile/models/korisnik.dart';
import 'package:erecipes_mobile/models/recept.dart';
import 'package:json_annotation/json_annotation.dart';
part 'lajkovi.g.dart';

@JsonSerializable()
class Lajkovi {
  int? lajkoviId;
  int? korisnikId;
  int? receptId;
  DateTime? datumLajkanja;
  Korisnik? korisnik;
  Recept? recept;

  Lajkovi(
      {this.lajkoviId,
      this.korisnikId,
      required this.receptId,
      this.datumLajkanja,
      this.korisnik,
      this.recept});

  factory Lajkovi.FromJson(Map<String, dynamic> json) =>
      _$LajkoviFromJson(json);

  Map<String, dynamic> toJson() => _$LajkoviToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:erecipes_mobile/models/korisnik.dart';

part 'to_do4924.g.dart';

@JsonSerializable()
class ToDo4924 {
  int? ToDo4924Id;
  String? naziv;
  String? opis;
  DateTime? datumIzvrsenja;
  String? status;
  int? korisnikId;
  Korisnik? korisnik;

  ToDo4924(
    this.korisnikId,
    this.naziv,
    this.opis,
    this.datumIzvrsenja,
    this.status
  );

  factory ToDo4924.FromJson(Map<String, dynamic> json) =>
      _$ToDo4924FromJson(json);

  Map<String, dynamic> toJson() => _$ToDo4924ToJson(this);
}

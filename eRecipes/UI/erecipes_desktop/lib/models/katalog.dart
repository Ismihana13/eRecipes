import 'package:erecipes_desktop/models/katalog_recept.dart';
import 'package:json_annotation/json_annotation.dart';

part 'katalog.g.dart';

@JsonSerializable()
class Katalog {
  int? katalogId;
  String? naziv;
  String? opis;
  DateTime? datumKreiranja;
  List<KatalogRecept>? katalogRecepts;

  Katalog();

  factory Katalog.FromJson(Map<String, dynamic> json) =>
      _$KatalogFromJson(json);

  Map<String, dynamic> toJson() => _$KatalogToJson(this);
}

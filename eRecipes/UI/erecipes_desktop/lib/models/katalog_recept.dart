import 'package:erecipes_desktop/models/katalog.dart';
import 'package:erecipes_desktop/models/recept.dart';
import 'package:json_annotation/json_annotation.dart';

part 'katalog_recept.g.dart';

@JsonSerializable()
class KatalogRecept {
  int? katalogReceptId;
  int? receptId;
  int? katalogId;
  Recept? recept;
  Katalog? katalog;

  KatalogRecept();

  factory KatalogRecept.FromJson(Map<String, dynamic> json) =>
      _$KatalogReceptFromJson(json);

  Map<String, dynamic> toJson() => _$KatalogReceptToJson(this);
}

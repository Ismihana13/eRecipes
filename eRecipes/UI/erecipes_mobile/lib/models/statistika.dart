import 'package:json_annotation/json_annotation.dart';
part 'statistika.g.dart';

@JsonSerializable()
class Statistika {

  String? naziv;
 double? iznos;

  Statistika();

 factory Statistika.fromJson(Map<String, dynamic> json) => _$StatistikaFromJson(json);

  Map<String, dynamic> toJson() => _$StatistikaToJson(this);
}

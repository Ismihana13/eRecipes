import 'package:json_annotation/json_annotation.dart';

part 'rezervacija_prostora_statistika.g.dart';

@JsonSerializable()
class RezervacijaProstoraStatistika {
   String? statusRezervacije;
  int brojPojavljivanja;

  RezervacijaProstoraStatistika(
    this.statusRezervacije,
    this.brojPojavljivanja,
  );

  
  factory RezervacijaProstoraStatistika.fromJson(Map<String, dynamic> json) =>
     _$RezervacijaProstoraStatistikaFromJson(json);


 Map<String, dynamic> toJson() => _$RezervacijaProstoraStatistikaToJson(this);
}

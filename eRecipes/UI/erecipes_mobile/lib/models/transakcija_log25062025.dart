import 'package:json_annotation/json_annotation.dart';
import 'package:erecipes_mobile/models/korisnik.dart';

part 'transakcija_log25062025.g.dart';

@JsonSerializable()
class TransakcijaLog25062025 {
    int? transakcijaLog25062025Id;
  String? staraVrijednost ;
  String? novaVrijednost;
  DateTime? vrijemePromjene ;
  Korisnik? korisnik ;
  int? KorisnikId ;

  TransakcijaLog25062025();

   factory TransakcijaLog25062025.FromJson(Map<String, dynamic> json) =>
    _$TransakcijaLog25062025FromJson(json);
//
   Map<String, dynamic> toJson() => _$TransakcijaLog25062025ToJson(this);
}

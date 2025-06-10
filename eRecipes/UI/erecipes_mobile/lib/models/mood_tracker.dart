import 'package:json_annotation/json_annotation.dart';
import 'package:erecipes_mobile/models/korisnik.dart';

part 'mood_tracker.g.dart';

@JsonSerializable()
class MoodTracker {
  int? moodTrackerId;
  String? vrijednostRaspolozenja;
  String? opis;
  DateTime? datumEvidencije;
  final int? korisnikId;
  Korisnik? korisnik;


  MoodTracker( this.korisnikId,
    this.vrijednostRaspolozenja,
    this.opis,
    this.datumEvidencije,
   
  );

  factory MoodTracker.FromJson(Map<String, dynamic> json) =>
      _$MoodTrackerFromJson(json);

  Map<String, dynamic> toJson() => _$MoodTrackerToJson(this);
}

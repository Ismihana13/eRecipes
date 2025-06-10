import 'package:erecipes_mobile/models/mood_tracker.dart';
import 'package:erecipes_mobile/providers/base_provider.dart';

class MoodTrackerProvider extends BaseProvider<MoodTracker> {
  MoodTrackerProvider() : super("MoodTracker");

  @override
  fromJson(data) {
    return MoodTracker.FromJson(data);
  }
}

import '../models/sleep_model.dart';
import '../models/steps_model.dart';

class DataService {
  Future<SleepData> fetchSleepData() async {
    return SleepData(sleepHours: 7.5, deepSleepHours: 1.2, sleepRate: 82);
  }

  Future<StepsData> fetchStepsData() async {
    return StepsData(steps: 11857, goal: 18000, calories: 850, distance: 5.0, duration: 120);
  }
}

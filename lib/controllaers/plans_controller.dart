import 'package:flutter/material.dart';
import '../models/plan.dart';

class PlanController extends ChangeNotifier {
  List<Plan> _plans = [];

  List<Plan> get plans => _plans;

  void addPlan(String title) {
    _plans.add(Plan(title: title));
    notifyListeners();
  }

  void removePlan(int index) {
    _plans.removeAt(index);
    notifyListeners();
  }

  void togglePlanCompletion(int index) {
    _plans[index].toggleComplete();
    notifyListeners();
  }

  void updatePlan(int index, String newTitle) {
    _plans[index].updateTitle(newTitle);
    notifyListeners();
  }
}

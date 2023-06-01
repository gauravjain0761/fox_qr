import 'package:flutter/material.dart';
import 'package:fox/api/app_repository.dart';
import 'package:fox/features/price_plan_ui/plans.dart';

class PlansController extends ChangeNotifier {
  Plans? _plans;
  Plans? get plans => _plans;

  // Fetch QR Types from API
  void getuserplans({
    required BuildContext context,
  }) {
    AppRepository().getplans().then((value) async {
      _plans = Plans.fromJson(value);

      notifyListeners();
    });
  }
}

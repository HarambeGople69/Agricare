import 'package:myapp/models/tada_model_response.dart';

import '../api_services/api_service.dart';
import '../models/visit_plan_model.dart';

class VisitPlaController {
  static Stream<List<VisitPlanDataa>?> getVisitPlan() =>
      Stream.periodic(Duration(seconds: 2)).asyncMap(
        (_) => APIService.myVisitPlan(),
      );
}

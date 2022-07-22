import 'package:myapp/models/distributer_order_load_model.dart';
import 'package:myapp/models/tada_model_response.dart';

import '../api_services/api_service.dart';
import '../models/visit_plan_model.dart';

class DistributerOrcerController {
  static Stream<List<DistributerorderloadData>?> getVisitPlan() =>
      Stream.periodic(Duration(seconds: 2)).asyncMap(
        (_) => APIService.distributer_order_load(),
      );
}

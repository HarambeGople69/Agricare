import 'package:myapp/models/distributer_order_load_model.dart';
import 'package:myapp/models/retailer_order_load_model.dart';
import 'package:myapp/models/tada_model_response.dart';

import '../api_services/api_service.dart';
import '../models/visit_plan_model.dart';

class RetailerOrderController {
  static Stream<List<Retailerlistdata>?> getVisitPlan() =>
      Stream.periodic(Duration(seconds: 2)).asyncMap(
        (_) => APIService.retailerorderlist(),
      );
}

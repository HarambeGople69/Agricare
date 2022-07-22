import 'package:myapp/models/distributer_stoke_list_model.dart';
import 'package:myapp/models/tada_model_response.dart';

import '../api_services/api_service.dart';
import '../models/custom_stoke.dart';

class DistributerStokeController {
  static Stream<List<CustomStokeData>?> getStoke() =>
      Stream.periodic(Duration(seconds: 2)).asyncMap(
        (_) => APIService.getDistributerStokeList(),
      );
}

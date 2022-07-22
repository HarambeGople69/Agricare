

import 'package:myapp/models/tada_model_response.dart';

import '../api_services/api_service.dart';

class TadaController{
  static Stream<List<dataa>?> getTada() =>
      Stream.periodic(Duration(seconds: 2)).asyncMap(
        (_) => APIService.mytadalist(),
      );
}
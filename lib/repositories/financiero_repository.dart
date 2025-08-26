import 'dart:convert';

import 'package:http/http.dart';
import 'package:uniconecta/config/api/api_config.dart';
import 'package:uniconecta/models/financiero/financiero_data_model.dart';
import 'package:uniconecta/models/financiero/financiero_response_model.dart';

class FinancieroRepository {
  
  static Future<FinancieroResponseModel> getFinancial({required int role, required String email}) async {
    // uri parse for the post
    Uri url = Uri.https(ApiConfig.https, ApiConfig.getFinancial);

    Request getRequest = Request("POST", url)
      ..headers.addAll(ApiConfig.defaultHeaders)
      ..body = jsonEncode({
        'email': email,
        'rol': role
      });

    final StreamedResponse streamed = await getRequest.send().timeout(ApiConfig.defaultTimeout);

    //post to the url with the api config.
    Response response = await Response.fromStream(streamed);

    //response management here
    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      final FinancieroResponseModel financieroModel = FinancieroResponseModel.fromJson(decoded);

      return financieroModel;

    } else {
      return FinancieroResponseModel(financieroCargado: false, financieroData: FinancieroDataModel.fromJson({}));
    }
  }

}
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:uniconecta/config/api/api_config.dart';
import 'package:uniconecta/models/financiero/financiero_data_model.dart';
import 'package:uniconecta/models/financiero/financiero_response_model.dart';
import 'package:uniconecta/models/financiero/send_support_model.dart';

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

  static Future<SendSupportModel> sendSupport({required File file}) async {
    // uri parse for the post
    Uri url = Uri.https(ApiConfig.https, ApiConfig.sendPaymentSupport);

    // Adding the file as a MultipartFile
    MultipartRequest request = MultipartRequest("POST", url);
    final MultipartFile modifiedFile = await MultipartFile.fromPath('Soporte', file.path);
    request.files.add(modifiedFile);

    final StreamedResponse response = await request.send();
    Response data = await Response.fromStream(response);

    if (response.statusCode >= 200 && response.statusCode < 303) {
      final Map<String, dynamic> decodedBody = jsonDecode(data.body);
      final SendSupportModel model = SendSupportModel.fromJson(decodedBody);

      return model;

    } else {

      return SendSupportModel(message: "Ha ocurrido un error, intentalo mas tarde.", success: false);
    }
  }

}
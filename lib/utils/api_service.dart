import 'package:http/http.dart' as http;

class ApiService {

  Future<String> getJsonData(String baseUrl, String endPoint, Map<String, String> params) async {
    final Uri url = Uri.https(baseUrl, endPoint, params);
    
    try {
      final response = await http.get(url);

      if(response.statusCode != 200) {
        throw Exception("Error en la solicitud HTTP: ${response.reasonPhrase}");
      }
      
      return response.body;

    } catch(error) {
      return Future.error(error.toString());
    }
  }

}
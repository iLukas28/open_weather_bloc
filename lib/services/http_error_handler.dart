import 'package:http/http.dart' as http;

String httpErrorHandler(http.Response response) {
  final statusCode = response.statusCode;
  final reasonPhrase = response.reasonPhrase;
  final String errorMessage =
      'Request failse status:$statusCode phrase:$reasonPhrase';
  return errorMessage;
}

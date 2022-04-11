import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../responseTypes/accessToken.dart';
import '../responseTypes/error.dart';

final storage = new FlutterSecureStorage();

Future post(String endpoint,
    {dynamic returnType, Map<String, String>? headers, Object? body}) async {
  const String apiURL = 'http://10.0.2.2:3000';

  var accessToken = await storage.read(key: 'accessToken');
  var currHeaders = {'Authorization': 'Bearer ' + accessToken!};
  try {
    var res = await http.post(
      Uri.parse(apiURL + endpoint),
      headers: currHeaders,
      body: body,
    );
    // TODO: make function and add to get
    try {
      // try see if the api returned an error
      Error err = Error.parseBody(res.body);
      // if the error is about the access token expiring
      if (err.statusCode == 401 && err.message == "TokenExpiredError") {
        // hit the refresh token route
        res = await refreshToken(endpoint, apiURL, body, http.post);
        return returnType(res.body);
      } else {
        // handle api error appropriately
        print(err.statusCode.toString() + ' ' + err.message);
      }
    } catch (e) {
      // print(res.body);

      // if no error from api return correct obj
      return returnType(res.body);
    }
  } catch (e) {
    print(e);
    // TODO: handle something wrong with api entirely (e.g its down)
    // example
    // SocketException: Connection refused
    // (OS Error: Connection refused, errno = 111),
    // address = 10.0.2.2, port = 56778
  }
}

Future get(String endpoint, dynamic parse,
    {Map<String, String>? headers}) async {
  const String apiURL = 'http://10.0.2.2:3000';
  try {
    var res = await http.get(
      Uri.parse(apiURL + endpoint),
      headers: headers,
    );

    return parse(res.body);
  } catch (e) {
    throw Exception(e);
  }
}

Future refreshToken(
  String endpoint,
  String apiURL,
  Object? body,
  Function method,
) async {
  var refreshToken = await storage.read(key: 'refreshToken');

  print('refreshing token');
  var tokenRes = await method(
    Uri.parse(apiURL + '/user/refresh-token'),
    headers: {'Authorization': 'Bearer ' + refreshToken!},
    body: body,
  );
  try {
    // try see if the refresh returned an error
    Error refreshErr = Error.parseBody(tokenRes.body);
    return refreshErr;
  } catch (e) {
    // otherwise get the new access tokem
    AccessToken newAccessToken = AccessToken.parseBody(tokenRes.body);

    // save it to local storage
    await storage.write(
      key: 'accessToken',
      value: newAccessToken.accessToken,
    );

    // send new request with new access token
    var res = await method(
      Uri.parse(apiURL + endpoint),
      headers: {'Authorization': 'Bearer ' + newAccessToken.accessToken},
      body: body,
    );
    return res;
  }
}

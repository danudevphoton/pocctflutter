import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/model/project_model.dart';

class TesProvider with ChangeNotifier {
  Future<ProjectModel> getProject() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();

    // final Map<String, dynamic> postdata = {
    //   "": ,
    // };

    String reply = await apiHttpConfig(
        null, "https://api.us-central1.gcp.commercetools.com/photon-learning",
        method: "get");
    print(reply);

    return projectModelFromJson(reply);
  }

  apiHttpConfig(Map<String, dynamic> postdata, String url,
      {method = "post"}) async {
    String urlservice = url;

    HttpClient client = new HttpClient();
    // client.badCertificateCallback =
    //     ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request;
    if (method == "post") {
      request = await client.postUrl(Uri.parse(urlservice));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(postdata)));
    } else {
      request = await client.getUrl(Uri.parse(urlservice));
      request.headers.set('content-type', 'application/json');
      request.headers
          .set('Authorization', 'Bearer xQWKRSLVka7Amx1i6KLYjRiWOucIoyVr');
    }

    String reply;

    HttpClientResponse response = await request.close();
    reply = await response.transform(utf8.decoder).join();
    print(reply.toString());

    return reply;
  }
}

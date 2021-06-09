import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:github_repo/models/repository.model.dart';
import 'package:http/http.dart' as http;

class GithubService {
  String _uri = "https://api.github.com";

  Future<Repositories> getRepo() async {
    var qParams = {
      "order": "desc",
      "page": "1",
      "q=created:>": "2017-10-22",
      "sort": "stars",
    };
    var url = Uri.http(_uri, "/search/repositories", qParams);
    try {
      final res = await http.post(url).timeout(Duration(seconds: 10),
          onTimeout: (() => throw TimeoutException(
              "Connection has timed out, Please try again!")));
      if (!(res.statusCode >= 200 && res.statusCode < 300))
        throw HttpException("Http Exeption ${res.statusCode}");
      final data = json.decode(res.body);
      return Repositories.fromJson(data);
    } catch (e) {
      throw (e);
    }
  }
}

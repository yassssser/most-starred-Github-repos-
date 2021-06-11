import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:github_repo/models/repository.model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class GithubService {
  final String _uri = "api.github.com";
  final DateTime date = DateTime.now();

  Future<Repositories> getRepositories(int? page) async {
    DateTime dateMunis1Month = DateTime(date.year, date.month - 1, date.day);
    String dateFormatted = DateFormat("yyyy-MM-dd").format(dateMunis1Month);

    var qParams = {
      "order": "desc",
      "page": "$page",
      "q": "created:>$dateFormatted",
      "sort": "stars",
    };

    var url = Uri.https(_uri, "/search/repositories", qParams);

    try {
      final res = await http.get(url).timeout(Duration(seconds: 10),
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

import 'package:flutter/material.dart';
import 'package:spotlas_test/controller/spotlas_api.dart';

class FeedListProvider with ChangeNotifier {
  var api = Spotlas();
  List _feed = [];
  bool loading = false;

  List get feed => _feed;

  updateFeed(context) async {
    try {
      loading = true;
      _feed = await api.getFeed(context);
      loading = false;
      notifyListeners();
    } catch (exception) {
      return exception;
    }
  }
}

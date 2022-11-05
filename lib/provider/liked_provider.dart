import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotlas_test/controller/spotlas_api.dart';
import 'package:spotlas_test/provider/list_provider.dart';

class LikedProvider with ChangeNotifier {
  var api = Spotlas();

  getLiked(context, model, index) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      bool? liked = prefs.getBool(model.id);

      if (liked == null) {
        Provider.of<FeedListProvider>(context, listen: false)
            .feed[index]
            .liked = true;
        prefs.setBool(model.id, true);
      } else if (liked == false) {
 
        Provider.of<FeedListProvider>(context, listen: false)
            .feed[index]
            .liked = true;
        prefs.setBool(model.id, true);
      } else {
        Provider.of<FeedListProvider>(context, listen: false)
            .feed[index]
            .liked = false;
        prefs.remove(model.id);
      }

      notifyListeners();
    } catch (exception) {
      return exception;
    }
  }
}

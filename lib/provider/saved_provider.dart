import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotlas_test/controller/spotlas_api.dart';
import 'package:spotlas_test/provider/list_provider.dart';

class SavedProvider with ChangeNotifier {
  var api = Spotlas();

  getSaved(context, model, index) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      bool? saved = prefs.getBool(model.id);

      if (saved == null) {
        Provider.of<FeedListProvider>(context, listen: false)
            .feed[index]
            .saved = true;
        prefs.setBool(model.id, true);
      } else if (saved == false) {
        // model.saved = true;
        Provider.of<FeedListProvider>(context, listen: false)
            .feed[index]
            .saved = true;
        prefs.setBool(model.id, true);
      } else {
        Provider.of<FeedListProvider>(context, listen: false)
            .feed[index]
            .saved = false;
        prefs.remove(model.id);
      }

      notifyListeners();
    } catch (exception) {
      return exception;
    }
  }
}

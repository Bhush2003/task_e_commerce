import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceObject{
  late final SharedPreferences _sharedPreference;

  void makeInstance() async{
    _sharedPreference = await SharedPreferences.getInstance();
  }

  get sharedPreference => _sharedPreference;
}
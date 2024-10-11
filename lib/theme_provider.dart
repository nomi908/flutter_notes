import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{
  bool _darktheme = false;

  ThemeProvider(){
    _loadthemedata();
  }

  void updatetheme({required bool value}) async{
    _darktheme = value;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('darkTheme', _darktheme);
  }

  bool getThemevalue() => _darktheme;


  Future<void> _loadthemedata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    _darktheme = pref.getBool('darkTheme') ?? false;
    notifyListeners();

  }


}
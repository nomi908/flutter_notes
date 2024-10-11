import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notes_app/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
   bool isDarkmode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("setting"),
      
      ),
      body: Consumer<ThemeProvider>(builder: (ctx, provider, _){
        return SwitchListTile.adaptive(
            title: Text("Dark Mode"),
            subtitle: Text("Change your theme into a darkmode."),
            value: provider.getThemevalue(), onChanged: (value){
            // isDarkmode = value;
            provider.updatetheme(value: value);
          },
          );
        
      }),
      
    );
  }
}
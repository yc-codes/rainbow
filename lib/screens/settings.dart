import 'package:flutter/material.dart';
import 'package:rainbow/widgets/setting_item.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Container(
        constraints: BoxConstraints(),
        child: ListView(
          children: [
            SettingItem(
              icon: Icons.settings_input_composite_sharp,
              color: Colors.blue,
              title: "General",
              subtitle: "Color Configration",
            ),
            SettingItem(
              icon: Icons.handyman_outlined,
              color: Colors.orange,
              title: "Home Screen",
              subtitle: "Home Screen Settings",
            ),
            SettingItem(
              icon: Icons.info_outline,
              color: Colors.green,
              title: "About",
              subtitle: "About Rainbow",
            ),
          ],
        ),
      ),
    );
  }
}

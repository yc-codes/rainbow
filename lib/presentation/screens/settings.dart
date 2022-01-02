import 'package:flutter/material.dart';
import 'package:rainbow/presentation/widgets/setting_item.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool darkTheme = false;

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
        constraints: const BoxConstraints(),
        child: ListView(
          children: const [
            SettingListItem(
              icon: Icons.settings_input_composite_sharp,
              color: Colors.blue,
              title: 'General',
              subtitle: 'Color Configration',
            ),
            SettingListItem(
              icon: Icons.handyman_outlined,
              color: Colors.orange,
              title: 'Home Screen',
              subtitle: 'Home Screen Settings',
            ),
            SettingListItem(
              icon: Icons.info_outline,
              color: Colors.green,
              title: 'About',
              subtitle: 'About Rainbow',
            ),
          ],
        ),
      ),
    );
  }
}

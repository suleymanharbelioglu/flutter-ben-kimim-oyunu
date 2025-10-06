import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _soundOn = true;
  bool _notificationsOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ayarlar",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildSettingTile(
              icon: Icons.volume_up,
              title: "Ses",
              value: _soundOn,
              onChanged: (val) => setState(() => _soundOn = val),
            ),
            const SizedBox(height: 20),
            _buildSettingTile(
              icon: Icons.notifications,
              title: "Bildirimler",
              value: _notificationsOn,
              onChanged: (val) => setState(() => _notificationsOn = val),
            ),
            const SizedBox(height: 20),
            _buildSettingTile(
              icon: Icons.color_lens,
              title: "Tema",
              value: false,
              onChanged: (val) {},
              hasSwitch: false,
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required bool value,
    required Function(bool) onChanged,
    bool hasSwitch = true,
    Widget? trailing,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        trailing: hasSwitch
            ? Switch(
                value: value,
                onChanged: onChanged,
                activeColor: Colors.deepPurple,
              )
            : trailing,
      ),
    );
  }
}

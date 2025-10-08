import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ben_kimim/presentation/game/bloc/max_round_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/timer_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _roundCount = 5;
  int _gameDuration = 90; // default 90 saniye

  @override
  void initState() {
    super.initState();
    _roundCount = context.read<MaxRoundCubit>().state;
    _gameDuration = context.read<TimerCubit>().state;
  }

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
            // Round sayısı slider
            _buildSliderTile(
              icon: Icons.format_list_numbered,
              title: "Tur Sayısı",
              value: _roundCount.toDouble(),
              min: 2,
              max: 10,
              divisions: 8,
              onChanged: (val) => setState(() => _roundCount = val.toInt()),
              onChangeEnd: (val) {
                context.read<MaxRoundCubit>().setMaxRound(val.toInt());
              },
            ),
            const SizedBox(height: 20),

            // Oyun süresi slider
            _buildSliderTile(
              icon: Icons.timer,
              title: "Oyun Süresi (sn)",
              value: _gameDuration.toDouble(),
              min: 15,
              max: 120,
              divisions: 7, // 15'er artış
              onChanged: (val) => setState(() => _gameDuration = val.round()),
              onChangeEnd: (val) {
                context.read<TimerCubit>().setDuration(val.round());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderTile({
    required IconData icon,
    required String title,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Function(double) onChanged,
    required Function(double) onChangeEnd,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.deepPurple),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  "${value.toInt()}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              label: value.toInt().toString(),
              onChanged: onChanged,
              onChangeEnd: onChangeEnd,
              activeColor: Colors.deepPurple,
            ),
          ],
        ),
      ),
    );
  }
}

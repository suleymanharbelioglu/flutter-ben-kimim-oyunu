import 'package:flutter/material.dart';

class HowToPlayPage extends StatelessWidget {
  const HowToPlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nasıl Oynanır?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _buildStep(
              step: 1,
              title: "Oyuncuları Ekleyin",
              description: "Oyun başlamadan önce tüm oyuncuları ekleyin.",
              icon: Icons.person_add,
            ),
            _buildStep(
              step: 2,
              title: "Oyun Başlasın",
              description:
                  "Zaman başlar ve ünlü isimleri tahmin etmeye çalışın.",
              icon: Icons.play_arrow,
            ),
            _buildStep(
              step: 3,
              title: "Doğru ve Pas",
              description:
                  "Doğru tahminler puan kazandırır, paslar sırayı atlatır.",
              icon: Icons.check_circle,
            ),
            _buildStep(
              step: 4,
              title: "Skorları Görüntüle",
              description: "Her turun sonunda oyuncu skorlarını kontrol edin.",
              icon: Icons.score,
            ),
            _buildStep(
              step: 5,
              title: "Kazananı Belirle",
              description: "Oyun bittiğinde en yüksek skorlu oyuncu kazanır!",
              icon: Icons.emoji_events,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep({
    required int step,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurple,
          child: Text(
            step.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(description),
        trailing: Icon(icon, color: Colors.deepPurple),
      ),
    );
  }
}

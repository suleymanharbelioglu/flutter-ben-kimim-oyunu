import 'package:cloud_firestore/cloud_firestore.dart';

class FamousHelper {
  // Static function to add 50 famous names to Firestore
  static Future<void> addFamousNames() async {
    final List<String> famousNames = [
      // 1. Şarkıcı
      "Tarkan",
      "Sezen Aksu",

      // 2. Oyuncu
      "Kıvanç Tatlıtuğ",
      "Beren Saat",

      // 3. Futbolcu
      "Arda Turan",
      "Hakan Şükür",

      // 4. Basketbolcu
      "Hidayet Türkoğlu",
      "Mehmet Okur",

      // 5. Sunucu
      "Acun Ilıcalı",
      "Okan Bayülgen",

      // 6. Komedyen
      "Cem Yılmaz",
      "Şahan Gökbakar",

      // 7. Yazar
      "Orhan Pamuk",
      "Elif Şafak",

      // 8. Şair
      "Nazım Hikmet",
      "Cemal Süreya",

      // 9. Ressam
      "Bedri Baykam",
      "Abidin Dino",

      // 10. Akademisyen
      "Aziz Sancar",
      "Oktay Sinanoğlu",

      // 11. Siyasetçi
      "Recep Tayyip Erdoğan",
      "Mustafa Kemal Atatürk",

      // 12. Modacı
      "Dice Kayek",
      "Atıl Kutoğlu",

      // 13. Yönetmen
      "Nuri Bilge Ceylan",
      "Zeki Demirkubuz",

      // 14. Film Yapımcısı
      "Şükrü Avşar",
      "Osman Sınav",

      // 15. Gazeteci
      "Ahmet Hakan",
      "Banu Güven",

      // 16. Sunucu/TV Programı
      "Beyazıt Öztürk",
      "Ali Kırca",

      // 17. Influencer
      "Danla Bilic",
      "Cemre Solmaz",

      // 18. YouTuber
      "Orkun Işıtmak",
      "Enes Batur",

      // 19. Atlet
      "Ramil Guliyev",
      "Aslı Çakır Alptekin",

      // 20. Yüzücü
      "Derya Büyükuncu",
      "İlker Tuncay",

      // 21. Opera Sanatçısı
      "Suna Korad",
      "Leyla Gencer",

      // 22. Oyuncu/Komedi
      "Tolga Çevik",
      "Ata Demirer",

      // 23. DJ / Müzik Prodüktörü
      "Mahmut Orhan",
      "Burak Yeter",

      // 24. Aşçı / Şef
      "Mehmet Gürs",
      "Cemre Baysel", // yemek influencer
      // 25. Bilim İnsanı
      "Feza Gürsey",
      "Cahit Arf",
    ];

    final collection = FirebaseFirestore.instance.collection('famous_names');

    for (var name in famousNames) {
      await collection.add({'name': name});
    }

    print("✅ 50 famous names successfully added to Firestore!");
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';

class FamousHelper {
  // Static function to add 50 famous names to Firestore
  static Future<void> addFamousNames() async {
    final List<String> famousNames = [
      "Albert Einstein",
      "Isaac Newton",
      "Leonardo da Vinci",
      "Nikola Tesla",
      "Marie Curie",
      "Galileo Galilei",
      "Charles Darwin",
      "William Shakespeare",
      "Thomas Edison",
      "Ludwig van Beethoven",
      "Pablo Picasso",
      "Vincent van Gogh",
      "Martin Luther King Jr.",
      "Nelson Mandela",
      "Abraham Lincoln",
      "Walt Disney",
      "Steve Jobs",
      "Elon Musk",
      "Mark Zuckerberg",
      "Oprah Winfrey",
      "Bill Gates",
      "Stephen Hawking",
      "Cristiano Ronaldo",
      "Lionel Messi",
      "Michael Jordan",
      "Muhammad Ali",
      "Usain Bolt",
      "Serena Williams",
      "Taylor Swift",
      "Beyoncé",
      "Adele",
      "Rihanna",
      "Lady Gaga",
      "Brad Pitt",
      "Angelina Jolie",
      "Tom Cruise",
      "Johnny Depp",
      "Emma Watson",
      "Robert Downey Jr.",
      "Keanu Reeves",
      "Morgan Freeman",
      "Dwayne Johnson",
      "Jennifer Lawrence",
      "Scarlett Johansson",
      "Chris Hemsworth",
      "LeBron James",
      "Kobe Bryant",
      "Prince",
      "Michael Jackson",
      "Freddie Mercury"
    ];

    final collection = FirebaseFirestore.instance.collection('famous_names');

    for (var name in famousNames) {
      await collection.add({'name': name});
    }

    print("✅ 50 famous names successfully added to Firestore!");
  }
}
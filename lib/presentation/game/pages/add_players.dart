import 'package:flutter/material.dart';

class AddPlayersPage extends StatefulWidget {
  const AddPlayersPage({super.key});

  @override
  State<AddPlayersPage> createState() => _AddPlayersPageState();
}

class _AddPlayersPageState extends State<AddPlayersPage> {
  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Oyuncu Girişi")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: controllers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TextFormField(
                    controller: controllers[index],
                    decoration: InputDecoration(
                      labelText: "Oyuncu ${index + 1}",
                      border: const OutlineInputBorder(),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    controllers.add(TextEditingController());
                  });
                },
                child: const Text("+"),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  if (controllers.length > 2) {
                    setState(() {
                      controllers.removeLast();
                    });
                  }
                },
                child: const Text("-"),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

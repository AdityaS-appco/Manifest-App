import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifest/test_voice/text_to_speech_cont.dart';
import 'package:manifest/test_voice/text_to_speech_service.dart';

class VoicePage extends StatelessWidget {
  final VoiceController voiceController = Get.put(VoiceController(VoiceService('sk_e89c26e6f48c797248cf452044203c30cfa4f63935a97f11')));

   VoicePage({super.key});


  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Player'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Enter text',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                voiceController.fetchAndPlayVoice(textController.text);
              },
              child: const Text('Play Voice'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // voiceController.fetchVoices();
              },
              child: const Text('Play Voice'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:elevenlabs_flutter/elevenlabs_config.dart';
import 'package:elevenlabs_flutter/elevenlabs_flutter.dart';
import 'package:elevenlabs_flutter/elevenlabs_types.dart';

class VoiceService {
  final ElevenLabsAPI _elevenLabs = ElevenLabsAPI();
  VoiceService(String apiKey) {
    _init(apiKey);
  }

  void _init(String apiKey) async {
    await _elevenLabs.init(
      config: ElevenLabsConfig(
        baseUrl: 'https://api.elevenlabs.io',
        apiKey: apiKey,
      ),
    );
  }

   Future<String> fetchVoice({required String text,required String voiceID}) async {
    try {
      // Synthesize text
      final result = await _elevenLabs.synthesize(
        optimizeStreamingLatency: 1,
        TextToSpeechRequest(
            text: text,
            voiceId: 'pNInz6obpgDQGcFmaJgB',
            modelId: 'eleven_turbo_v2',
            voiceSettings: const VoiceSettings(
              similarityBoost: 0.75,
              stability: 0.65,
            )
        ),
      );
      print('aaa $result');
      return result.path;

    } catch (e) {
      throw Exception('Failed to fetch voice: $e');
    }
  }
}


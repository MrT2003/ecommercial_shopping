import 'package:ecommercial_shopping/core/models/voice_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

final _speech = stt.SpeechToText();

class VoiceNotifier extends Notifier<VoiceState> {
  @override
  VoiceState build() {
    return VoiceState();
  }

  Future<void> initSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'notListening') {
          state = state.copyWith(isListening: false);
        } else if (status == 'listening') {
          state = state.copyWith(isListening: true);
        }
      },
      onError: (error) => print('Lỗi Voice: $error'),
    );

    state = state.copyWith(isAvailable: available);
  }

  void toggleListening() async {
    if (!state.isAvailable) {
      await initSpeech();
    }

    if (state.isListening) {
      _speech.stop();
      state = state.copyWith(isListening: false);
    } else {
      state = state.copyWith(isListening: true, text: '');

      _speech.listen(
        onResult: (val) {
          state = state.copyWith(
            text: val.recognizedWords,
            confidence: val.hasConfidenceRating ? val.confidence : 1.0,
          );
        },
        // localeId: 'vi_VN',
        localeId: 'en_US',
      );
    }
  }
}

final voiceProvider = NotifierProvider<VoiceNotifier, VoiceState>(() {
  return VoiceNotifier();
});

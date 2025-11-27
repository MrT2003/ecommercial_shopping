import 'package:ecommercial_shopping/core/models/voice_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

// 1. Khởi tạo SpeechToText instance
final _speech = stt.SpeechToText();

// 2. Tạo Notifier để quản lý Logic
class VoiceNotifier extends Notifier<VoiceState> {
  @override
  VoiceState build() {
    return VoiceState(); // Trạng thái ban đầu
  }

  // Hàm khởi tạo (Chạy 1 lần khi user vào màn hình này)
  Future<void> initSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        // Cập nhật trạng thái nghe khi plugin báo về (ví dụ: 'listening', 'notListening')
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

  // Hàm quan trọng nhất: Bật/Tắt Mic
  void toggleListening() async {
    if (!state.isAvailable) {
      await initSpeech(); // Thử khởi tạo lại nếu chưa có
    }

    if (state.isListening) {
      // Đang nghe -> Dừng lại
      _speech.stop();
      state = state.copyWith(isListening: false);
    } else {
      // Chưa nghe -> Bắt đầu nghe
      state = state.copyWith(isListening: true, text: ''); // Reset text cũ

      _speech.listen(
        onResult: (val) {
          // Khi có kết quả trả về, update ngay vào State
          state = state.copyWith(
            text: val.recognizedWords,
            confidence: val.hasConfidenceRating ? val.confidence : 1.0,
          );
        },
        // localeId: 'vi_VN', // Nhớ set tiếng Việt
        localeId: 'en_US', // Nhớ set tiếng Việt
      );
    }
  }
}

// 3. Khai báo Provider toàn cục
final voiceProvider = NotifierProvider<VoiceNotifier, VoiceState>(() {
  return VoiceNotifier();
});

// voice_state.dart
class VoiceState {
  final String text;
  final bool isListening;
  final double confidence;
  final bool isAvailable;

  VoiceState({
    this.text = '',
    this.isListening = false,
    this.confidence = 1.0,
    this.isAvailable = false,
  });

  VoiceState copyWith({
    String? text,
    bool? isListening,
    double? confidence,
    bool? isAvailable,
  }) {
    return VoiceState(
      text: text ?? this.text,
      isListening: isListening ?? this.isListening,
      confidence: confidence ?? this.confidence,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}

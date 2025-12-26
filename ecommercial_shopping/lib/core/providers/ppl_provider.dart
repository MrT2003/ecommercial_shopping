import 'package:ecommercial_shopping/core/models/ppl.dart';
import 'package:ecommercial_shopping/core/services/ppl_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PplState {
  final bool isLoading;
  final String? error;
  final PplParseResult? parseResult;
  final List<PplDrinkRecommendation> recommendations;

  PplState({
    required this.isLoading,
    required this.error,
    required this.parseResult,
    required this.recommendations,
  });

  factory PplState.initial() => PplState(
        isLoading: false,
        error: null,
        parseResult: null,
        recommendations: const [],
      );

  PplState copyWith({
    bool? isLoading,
    String? error,
    PplParseResult? parseResult,
    List<PplDrinkRecommendation>? recommendations,
  }) {
    return PplState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      parseResult: parseResult ?? this.parseResult,
      recommendations: recommendations ?? this.recommendations,
    );
  }
}

final pplServiceProvider = Provider<PplService>((ref) {
  return PplService();
});

class PplNotifier extends StateNotifier<PplState> {
  final PplService _service;

  PplNotifier(this._service) : super(PplState.initial());

  Future<void> parseAndRecommend(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    try {
      state = state.copyWith(
        isLoading: true,
        error: null,
        parseResult: null,
        recommendations: [],
      );

      final parseRes = await _service.parseText(text: trimmed);
      final recs = await _service.recommend(query: parseRes);

      state = state.copyWith(
        isLoading: false,
        error: null,
        parseResult: parseRes,
        recommendations: recs,
      );
    } catch (e) {
      var msg = e.toString();
      if (msg.startsWith('Exception: ')) {
        msg = msg.replaceFirst('Exception: ', '');
      }

      state = state.copyWith(
        isLoading: false,
        error: msg,
        parseResult: null,
        recommendations: [],
      );
    }
  }
}

final pplProvider = StateNotifierProvider<PplNotifier, PplState>((ref) {
  final service = PplService();
  return PplNotifier(service);
});

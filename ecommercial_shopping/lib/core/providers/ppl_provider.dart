import 'package:ecommercial_shopping/core/models/ppl.dart';
import 'package:ecommercial_shopping/core/services/ppl_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PplState {
  final bool isLoading;
  final PplParseResult? parseResult;
  final List<PplDrinkRecommendation> recommendations;
  final String? error;

  const PplState({
    required this.isLoading,
    required this.parseResult,
    required this.recommendations,
    required this.error,
  });

  factory PplState.initial() => const PplState(
        isLoading: false,
        parseResult: null,
        recommendations: [],
        error: null,
      );

  PplState copyWith({
    bool? isLoading,
    PplParseResult? parseResult,
    List<PplDrinkRecommendation>? recommendations,
    String? error,
  }) {
    return PplState(
      isLoading: isLoading ?? this.isLoading,
      parseResult: parseResult ?? this.parseResult,
      recommendations: recommendations ?? this.recommendations,
      // cho phép truyền null để clear error
      error: error,
    );
  }
}

final pplServiceProvider = Provider<PplService>((ref) {
  return PplService(); // dùng _baseUrl = AppConfig.pplEndpoint
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
        recommendations: [],
      );

      final parseRes = await _service.parseText(text: trimmed);
      final recs = await _service.recommend(query: parseRes);

      state = state.copyWith(
        isLoading: false,
        parseResult: parseRes,
        recommendations: recs,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void clear() {
    state = PplState.initial();
  }
}

final pplProvider = StateNotifierProvider<PplNotifier, PplState>((ref) {
  final service = ref.watch(pplServiceProvider);
  return PplNotifier(service);
});

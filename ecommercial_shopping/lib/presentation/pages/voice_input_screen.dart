import 'package:ecommercial_shopping/core/providers/ppl_provider.dart';
import 'package:ecommercial_shopping/core/providers/voice_provider.dart';
import 'package:ecommercial_shopping/presentation/pages/ppl_resule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoiceInputScreen extends ConsumerStatefulWidget {
  const VoiceInputScreen({super.key});

  @override
  ConsumerState<VoiceInputScreen> createState() => _VoiceInputScreenState();
}

class _VoiceInputScreenState extends ConsumerState<VoiceInputScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scaleAnim = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _glowAnim = Tween<double>(begin: 0.0, end: 12.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // điều khiển animation theo state listening
    ref.listen(voiceProvider, (previous, next) {
      if (next.isListening) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
        _controller.reset();
      }
    });

    final voiceState = ref.watch(voiceProvider);
    final pplState = ref.watch(pplProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Top bar: "Speak now" + nút X
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Speak now',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            /// PHẦN SPACE Ở GIỮA – hiện câu nói nếu có
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (voiceState.text.trim().isNotEmpty) ...[
                    const Text(
                      'You said',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        voiceState.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                  SizedBox(height: 50),

                  /// Gợi ý "Try saying..."
                  const Text(
                    'Try saying',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '"I want a ....."',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// Nút mic với animation
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: voiceState.isListening ? _scaleAnim.value : 1.0,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: voiceState.isListening
                                ? [
                                    BoxShadow(
                                      color: Colors.deepOrange.withOpacity(0.5),
                                      blurRadius: 20 + _glowAnim.value,
                                      spreadRadius: 5 + _glowAnim.value,
                                    ),
                                  ]
                                : [],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              ref
                                  .read(voiceProvider.notifier)
                                  .toggleListening();
                            },
                            child: const CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.deepOrange,
                              child: Icon(
                                Icons.mic,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  /// Trạng thái Listening / Tap to speak
                  Text(
                    voiceState.isListening ? 'Listening...' : 'Tap to speak',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            /// Nút "Tìm kiếm sản phẩm" ở dưới
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: ElevatedButton(
                  onPressed: voiceState.text.isEmpty || pplState.isLoading
                      ? null
                      : () async {
                          final text = voiceState.text.trim();
                          if (text.isEmpty) return;

                          final notifier = ref.read(pplProvider.notifier);

                          await notifier.parseAndRecommend(text);

                          final resultState = ref.read(pplProvider);
                          if (!mounted) return;

                          // 1) LỖI CÚ PHÁP / LỖI TỪ BACKEND
                          if (resultState.error != null) {
                            await showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Lỗi cú pháp'),
                                content: Text(resultState.error!),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(ctx).pop(),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                            return;
                          }

                          // 2) KHÔNG TÌM THẤY SẢN PHẨM PHÙ HỢP
                          if (resultState.recommendations.isEmpty) {
                            await showDialog(
                              context: context,
                              builder: (ctx) => const AlertDialog(
                                title: Text('Không tìm thấy sản phẩm'),
                                content: Text(
                                  'Không tìm thấy sản phẩm phù hợp với yêu cầu của bạn.\n'
                                  'Hãy thử nói một câu khác, ví dụ:\n'
                                  '- "I want a cold coffee"\n'
                                  '- "Give me a warm tea without caffeine"',
                                ),
                              ),
                            );
                            return;
                          }

                          // 3) Có kết quả → sang screen PPL
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PplResultScreen(
                                queryText: text,
                                results: resultState.recommendations,
                              ),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: pplState.isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Tìm kiếm sản phẩm",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                )),
          ],
        ),
      ),
    );
  }
}

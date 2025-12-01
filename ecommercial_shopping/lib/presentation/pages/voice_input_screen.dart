import 'package:ecommercial_shopping/core/providers/ppl_provider.dart';
import 'package:ecommercial_shopping/core/providers/voice_provider.dart';
import 'package:ecommercial_shopping/presentation/pages/category_detail_screen.dart';
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
    final textController = TextEditingController(text: voiceState.text);

    textController.selection = TextSelection.fromPosition(
      TextPosition(offset: textController.text.length),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Tìm kiếm bằng giọng nói')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textController,
              readOnly: true,
              decoration: const InputDecoration(
                hintText: 'Nhấn mic và nói...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            if (voiceState.text.isNotEmpty)
              Text(
                "Độ chính xác: ${(voiceState.confidence * 100).toStringAsFixed(1)}%",
                style: const TextStyle(color: Colors.grey),
              ),
            const SizedBox(height: 40),
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
                                color: Colors.red.withOpacity(0.5),
                                blurRadius: 20 + _glowAnim.value,
                                spreadRadius: 5 + _glowAnim.value,
                              ),
                            ]
                          : [],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        ref.read(voiceProvider.notifier).toggleListening();
                      },
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor:
                            voiceState.isListening ? Colors.red : Colors.blue,
                        child: Icon(
                          voiceState.isListening ? Icons.mic : Icons.mic_none,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Text(
              voiceState.isListening ? "Listening..." : "Search products...",
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: voiceState.text.isEmpty || pplState.isLoading
                  ? null
                  : () async {
                      // 1) Gọi parse + recommend
                      final notifier = ref.read(pplProvider.notifier);
                      await notifier.parseAndRecommend(voiceState.text);

                      // 2) Lấy state mới
                      final resultState = ref.read(pplProvider);

                      if (!mounted) return; // tránh lỗi nếu widget bị dispose

                      if (resultState.error != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(resultState.error!)),
                        );
                        return;
                      }

                      if (resultState.recommendations.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Không tìm thấy sản phẩm phù hợp 🤔'),
                          ),
                        );
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryDetailScreen(
                            categoryName: 'Kết quả cho "${voiceState.text}"',
                            pplResults: resultState.recommendations,
                          ),
                        ),
                      );
                    },
              child: pplState.isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text("Tìm kiếm sản phẩm"),
            ),
          ],
        ),
      ),
    );
  }
}

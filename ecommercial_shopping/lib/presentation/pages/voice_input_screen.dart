import 'package:ecommercial_shopping/core/providers/voice_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Chuyển thành ConsumerWidget để dùng Riverpod
class VoiceInputScreen extends ConsumerWidget {
  const VoiceInputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voiceState = ref.watch(voiceProvider);
    final textController = TextEditingController(text: voiceState.text);

    textController.selection = TextSelection.fromPosition(
        TextPosition(offset: textController.text.length));

    return Scaffold(
      appBar: AppBar(title: const Text('Tìm kiếm bằng giọng nói')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ô Input
            TextField(
              controller: textController,
              readOnly: true,
              decoration: const InputDecoration(
                hintText: 'Nhấn mic và nói...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Hiển thị độ chính xác
            if (voiceState.text.isNotEmpty)
              Text(
                "Độ chính xác: ${(voiceState.confidence * 100).toStringAsFixed(1)}%",
                style: const TextStyle(color: Colors.grey),
              ),

            const SizedBox(height: 40),

            // Nút Micro
            GestureDetector(
              onTap: () {
                // Gọi hàm logic từ Provider
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

            const SizedBox(height: 10),
            Text(
                voiceState.isListening ? "Listening..." : "Search products..."),

            const SizedBox(height: 30),

            // Nút Search (Gửi dữ liệu đi)
            ElevatedButton(
              onPressed: voiceState.text.isEmpty
                  ? null
                  : () {
                      // TODO: Gọi API search sản phẩm với keyword = voiceState.text
                      print("Đang tìm kiếm: ${voiceState.text}");

                      // Ví dụ: ref.read(productProvider.notifier).search(voiceState.text);
                    },
              child: const Text("Tìm kiếm sản phẩm"),
            )
          ],
        ),
      ),
    );
  }
}

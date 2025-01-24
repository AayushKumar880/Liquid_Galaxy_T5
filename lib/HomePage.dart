import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'AnimatedGradientBorder.dart';
import 'BottomAnimation.dart';
import 'VoiceCommands.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final SpeechController speechController = Get.put(SpeechController());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Voice Recognition Page',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Voice Recognition'),
          elevation: 0,
        ),
        body: Stack(
          children: [
            Semantics(
              label: 'Main Content Area',
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32.0),
                      _buildMicButton(),
                      const SizedBox(height: 64.0),
                      _buildTextDisplay(),
                    ],
                  ),
                ),
              ),
            ),
            _buildBottomAnimation(),
          ],
        ),
      ),
    );
  }

  Widget _buildMicButton() {
    return Obx(() => Semantics(
          button: true,
          enabled: speechController.isInitialized.value,
          label: speechController.isListening.value
              ? 'Microphone active, tap to stop listening'
              : 'Microphone inactive, tap to start voice input',
          hint: speechController.isInitialized.value
              ? speechController.isListening.value
                  ? 'Double tap to stop recording'
                  : 'Double tap to start recording'
              : 'Speech recognition not available',
          excludeSemantics: true,
          // Prevents child semantics from conflicting
          child: MergeSemantics(
            child: GestureDetector(
              onTap: () {
                if (speechController.isInitialized.value) {
                  if (speechController.isListening.value) {
                    speechController.stopListening();
                    _controller.stop();
                  } else {
                    speechController.startListening();
                    _controller.repeat();
                  }
                }
              },
              child: SizedBox(
                height: 64.0,
                width: 64.0,
                child: speechController.isListening.value
                    ? Semantics(
                        label: 'Active microphone with animation',
                        child: AnimatedBorderGradient(
                          controller: _controller,
                          child: const Center(
                            child: Icon(
                              Icons.mic,
                              color: Colors.white,
                              size: 32.0,
                            ),
                          ),
                        ),
                      )
                    : Semantics(
                        label: 'Inactive microphone',
                        child: const Icon(
                          Icons.mic_none,
                          color: Colors.white,
                          size: 32.0,
                        ),
                      ),
              ),
            ),
          ),
        ));
  }

  Widget _buildTextDisplay() {
    return Obx(() => Semantics(
          label: 'Speech Recognition Results',
          value: speechController.isListening.value
              ? speechController.spokenText.value.isEmpty
                  ? 'Currently listening for speech'
                  : 'Recognized text: ${speechController.spokenText.value}'
              : speechController.isInitialized.value
                  ? speechController.spokenText.value.isEmpty
                      ? 'Ready to listen'
                      : 'Last recognized text: ${speechController.spokenText.value}'
                  : 'Speech recognition not available',
          liveRegion: true, // Announces changes to screen readers
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.white24,
                width: 1,
              ),
            ),
            child: Text(
              speechController.isListening.value
                  ? speechController.spokenText.value.isEmpty
                      ? 'Listening...'
                      : speechController.spokenText.value
                  : speechController.isInitialized.value
                      ? speechController.spokenText.value.isEmpty
                          ? 'Tap the mic to speak...'
                          : speechController.spokenText.value
                      : 'Speech not available',
              style: const TextStyle(
                fontSize: 24.0,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }

  Widget _buildBottomAnimation() {
    return Obx(() {
      if (speechController.isAnimating.value) {
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Semantics(
            label: 'Voice activity animation',
            excludeSemantics: true,
            child: BottomAnimation(
              controller: _controller,
            ),
          ),
        );
      }
      return const SizedBox();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

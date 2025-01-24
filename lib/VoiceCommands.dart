import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechController extends GetxController {
  final _speechToText = stt.SpeechToText();
  RxBool isListening = false.obs;
  RxString spokenText = ''.obs;
  RxBool isInitialized = false.obs;
  RxBool isAnimating = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeSpeech();
  }

  Future<void> initializeSpeech() async {
    try {
      isInitialized.value = await _speechToText.initialize(
        onStatus: (status) => _onSpeechStatus(status),
        onError: (error) => print('Speech Error: $error'),
      );
    } catch (e) {
      print('Speech initialization error: $e');
      isInitialized.value = false;
    }
  }

  void startListening() async {
    if (!isListening.value) {
      if (isInitialized.value) {
        spokenText.value = '';
        isListening.value = true;
        isAnimating.value = true;

        await _speechToText.listen(
          onResult: (result) {
            spokenText.value = result.recognizedWords;
          },
          listenFor: const Duration(seconds: 30),
          partialResults: true,
          cancelOnError: true,
          listenMode: stt.ListenMode.dictation,
        );
      } else {
        print('Speech recognition not initialized');
        await initializeSpeech();
      }
    }
  }

  void stopListening() {
    if (isListening.value) {
      _speechToText.stop();
      isListening.value = false;
      isAnimating.value = false;
    }
  }

  void _onSpeechStatus(String status) {
    print('Speech Status: $status');
    if (status == 'done' || status == 'notListening') {
      isListening.value = false;
      isAnimating.value = false;
    }
  }

  @override
  void onClose() {
    stopListening();
    super.onClose();
  }
}

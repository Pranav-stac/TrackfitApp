import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart'; // Import the Lottie package

class VoiceBotPage extends StatefulWidget {
  @override
  _VoiceBotPageState createState() => _VoiceBotPageState();
}

class _VoiceBotPageState extends State<VoiceBotPage> with TickerProviderStateMixin {
  GenerativeModel? _model;
  ChatSession? _chat;
  String _context = "Initial context"; // Replace with actual context if needed
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  bool _isListening = false;
  String _text = "";
  bool _isSpeaking = false; // Track if TTS is speaking
  AnimationController? _animationController; // Animation controller for the Lottie animation

  @override
  void initState() {
    super.initState();
    _initializeGeminiAPI();
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();
    _flutterTts.setLanguage("en-IN"); // Set TTS to Indian English accent

    // Initialize the Lottie animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Can be any duration; it will loop
    );

    // Set the TTS handlers to start and stop the animation
    _flutterTts.setStartHandler(() {
      setState(() {
        _isSpeaking = true;
        _animationController?.repeat(); // Start animation when speaking begins
      });
    });

    _flutterTts.setCompletionHandler(() {
      setState(() {
        _isSpeaking = false;
        _animationController?.stop(); // Stop animation when speaking completes
        _animationController?.reset(); // Reset animation to the start frame
      });
    });
  }

  // Initialize Google Gemini API for chat
  void _initializeGeminiAPI() {
    try {
      final apiKey = 'AIzaSyC8gD_SDQORgVwDej1s3J58hpX_N1Me2ss'; // Replace with your actual API key
      _model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
      _chat = _model?.startChat(history: [Content.text(_context)]);
      print('Gemini API initialized successfully');
    } catch (e) {
      print('Error initializing Gemini API: $e');
    }
  }

  // Handle speech recognition and toggle listening state
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      if (_text.isNotEmpty) {
        sendMessage(_text);
      }
    }
  }

  // Send message to Google Gemini AI and handle bot response
  void sendMessage(String userInput) async {
    try {
      if (_chat != null) {
        final response = await _chat!.sendMessage(Content.text(userInput));
        print('Bot response: ${response.text}');
        if (response.text != null) {
          _speak(response.text!);
        } else {
          print('Received null response from bot');
        }
      } else {
        print('Chat not initialized.');
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  // Use Text-to-Speech to read out the bot's response
  void _speak(String text) async {
    await _flutterTts.speak(text);
  }

  @override
  void dispose() {
    _animationController?.dispose(); // Dispose the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A), // Matching dark theme
      body: SafeArea( // Using SafeArea as per your preference
        child: Center( // Center the entire layout
          child: Padding(
            padding: const EdgeInsets.all(20.0), // Padding for consistent layout
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center items vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Center items horizontally
              children: <Widget>[
                // Display the Lottie animation while speaking
                _isSpeaking
                    ? Lottie.asset(
                        'assets/animation/chatbot.json', // Replace with your Lottie file path
                        controller: _animationController,
                        onLoaded: (composition) {
                          _animationController?.duration = composition.duration;
                        },
                        width: 200,
                        height: 200,
                      )
                    : Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2), // Placeholder style when not speaking
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          Icons.mic_off,
                          color: Colors.grey,
                          size: 100,
                        ),
                      ),
                SizedBox(height: 40),

                // Instruction text
                Text(
                  'Press the button to start speaking:',
                  textAlign: TextAlign.center, // Center the text
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Satoshi', // Consistent font
                    color: Colors.white, // Text color matching the dark theme
                  ),
                ),

                SizedBox(height: 20),

                // Start/Stop listening button
                ElevatedButton(
                  onPressed: _listen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isListening ? Color(0xFF00E9CD) : Color(0xFF9466FF), // Colors from your scheme
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _isListening ? 'Stop Listening' : 'Start Listening',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Satoshi',
                      color: Colors.black, // Button text color
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Stop speaking button
                ElevatedButton(
                  onPressed: () {
                    _flutterTts.stop(); // Ensure TTS stops immediately
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD9D9D9), // Matching button style
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Stop Speaking',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Satoshi',
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Display recognized speech
                Text(
                  'Recognized Speech: $_text',
                  textAlign: TextAlign.center, // Center the text
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Satoshi', // Consistent font
                    color: Colors.grey, // Subtle text color
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
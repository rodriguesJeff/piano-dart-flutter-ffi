import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piano_dart_ffi/ffi/native_functions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Keyboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Piano Windows'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    final native = NativeFunctions();

    final keyAudioMap = {
      PhysicalKeyboardKey.keyQ: "assets\\audio\\key01.wav",
      PhysicalKeyboardKey.keyW: "assets\\audio\\key02.wav",
      PhysicalKeyboardKey.keyE: "assets\\audio\\key03.wav",
      PhysicalKeyboardKey.keyR: "assets\\audio\\key04.wav",
      PhysicalKeyboardKey.keyT: "assets\\audio\\key05.wav",
      PhysicalKeyboardKey.keyY: "assets\\audio\\key06.wav",
      PhysicalKeyboardKey.keyU: "assets\\audio\\key07.wav",
      PhysicalKeyboardKey.keyI: "assets\\audio\\key08.wav",
      PhysicalKeyboardKey.keyO: "assets\\audio\\key09.wav",
      PhysicalKeyboardKey.keyP: "assets\\audio\\key10.wav",
      PhysicalKeyboardKey.keyA: "assets\\audio\\key11.wav",
      PhysicalKeyboardKey.keyS: "assets\\audio\\key12.wav",
      PhysicalKeyboardKey.keyD: "assets\\audio\\key13.wav",
      PhysicalKeyboardKey.keyF: "assets\\audio\\key14.wav",
      PhysicalKeyboardKey.keyG: "assets\\audio\\key15.wav",
      PhysicalKeyboardKey.keyH: "assets\\audio\\key16.wav",
      PhysicalKeyboardKey.keyJ: "assets\\audio\\key17.wav",
      PhysicalKeyboardKey.keyK: "assets\\audio\\key18.wav",
      PhysicalKeyboardKey.keyL: "assets\\audio\\key19.wav",
      PhysicalKeyboardKey.keyZ: "assets\\audio\\key20.wav",
      PhysicalKeyboardKey.keyX: "assets\\audio\\key21.wav",
      PhysicalKeyboardKey.keyC: "assets\\audio\\key22.wav",
      PhysicalKeyboardKey.keyV: "assets\\audio\\key23.wav",
      PhysicalKeyboardKey.keyB: "assets\\audio\\key24.wav",
    };

    if (keyAudioMap.containsKey(event.physicalKey)) {
      native.playPianoKeys(keyAudioMap[event.physicalKey]!);
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height / 5,
              color: Colors.black,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "PIANO FLUTTER | Windows ffi",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "github.com/rodriguesjeff/piano-dart-ffi",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 1; i <= 24; i++)
                  Focus(
                    focusNode: _focusNode,
                    onKeyEvent: _handleKeyEvent,
                    child: i > 0
                        ? ListenableBuilder(
                            listenable: _focusNode,
                            builder: (c, child) {
                              FocusScope.of(context).requestFocus(_focusNode);
                              return Container(
                                width: MediaQuery.sizeOf(context).width / 28,
                                height: MediaQuery.sizeOf(context).height * .5,
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  width: 1,
                                  color: _focusNode.hasFocus ? Colors.black : Colors.grey,
                                )),
                              );
                            },
                          )
                        : const SizedBox.shrink(),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

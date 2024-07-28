import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

typedef CPlayAudio = ffi.Void Function(ffi.Pointer<Utf8> path);
typedef DartPlayAudio = void Function(ffi.Pointer<Utf8> path);

class NativeFunctions {
  final audioWindowsLibrary = ffi.DynamicLibrary.open('native\\build\\Debug\\piano.dll');

  void playPianoKeys(String path) {
    final pianoKey = audioWindowsLibrary.lookupFunction<CPlayAudio, DartPlayAudio>('playAudio');
    // <CPlayAudio, DartPlayAudio>
    // O primeiro tipo se refere a função nativa, o segundo a função que vou executar no dart
    pianoKey(path.toNativeUtf8());
  }
}

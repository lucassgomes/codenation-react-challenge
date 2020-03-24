import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'dio.dart';
import 'answer.dart';
import 'constants.dart';

main(List<String> args) async {
  //Get API informations
  await getInfo();
  //Data decrypt
  decrypt();
}

crypt(Answer answer) {
  final file = new File(FILENAME);
  Stream<List<int>> inputStream = file.openRead();
  inputStream
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(new LineSplitter()) // Convert stream to individual lines.
      .listen((String line) {
    // Process results.
    answer = Answer.fromJson(json.decode(line));
  }, onDone: () {
    final bytes = utf8.encode(answer.decifrado);
    answer.resumoCriptografico = sha1.convert(bytes).toString();
    writeInFile(answer);
  }, onError: (e) {
    print(e.toString());
  });
}

writeInFile(Answer answer) {
  final file = new File(FILENAME);
  final sink = file.openWrite();
  sink.write(json.encode(answer.toJson()));
  // Close the IOSink to free system resources.
  sink.close();
}

decrypt() {
  final int char_a = "a".codeUnitAt(0);
  Answer answerData = Answer();
  final List<int> alphabet = Iterable.generate(26, (x) => char_a + x).toList();
  final file = new File(FILENAME);
  Stream<List<int>> inputStream = file.openRead();
  inputStream
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(new LineSplitter()) // Convert stream to individual lines.
      .listen((String line) {
    // Process results.
    answerData = Answer.fromJson(json.decode(line));
  }, onDone: () {
    List<String> words = answerData.cifrado.toLowerCase().split(' ');
    List<int> codeWords;
    List<String> newWords = <String>[];
    List<int> codes = Iterable.generate(
        alphabet.length + answerData.numeroCasas,
        (index) => index < answerData.numeroCasas
            ? alphabet[alphabet.length - (answerData.numeroCasas - index)]
            : alphabet[index - answerData.numeroCasas]).toList();
    words.forEach((word) {
      codeWords = word.codeUnits.map((unit) {
        final index = codes.lastIndexWhere((code) => code == unit);
        return index != -1 ? index - answerData.numeroCasas : unit;
      }).toList();
      newWords.add(codeWords
          .map((unit) => unit > codes.length
              ? String.fromCharCode(unit)
              : String.fromCharCode(codes[unit]))
          .toList()
          .join(''));
    });
    answerData.decifrado = newWords.join(' ');
    writeInFile(answerData);
    crypt(answerData);
  }, onError: (e) {
    print(e.toString());
  });
}

getInfo() async {
  final Response response = await CustomDio().dio.get(GET_DATA);
  writeInFile(Answer.fromJson(response.data));
}
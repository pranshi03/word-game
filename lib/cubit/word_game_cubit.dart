import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'word_game_state.dart';

class WordGameCubit extends Cubit<WordGameState> {
  final List<String> wordList = ["apple", "mango", "guava", "grape", "melon"];
  late String secretWord;
  int attempts = 0;
  bool isVisible = false;
  bool showButton = true;

  WordGameCubit() : super(WordGameInitial());

  void startNewGame() {
    secretWord = _getRandomWord();
    attempts = 0;
    isVisible = true;
    showButton = false;
    emit(WordGameStarted());
  }

  void makeGuess(String guess) {
    attempts++;
    guess = guess.toLowerCase();
    List<String> feedback = _provideFeedback(guess);

    if (feedback.every((color) => color == "green")) {
      showButton = true;

      emit(WordGameSuccess(secretWord, attempts));
    } else if (attempts >= 6) {
      showButton = true;
      emit(WordGameFailure(secretWord));
    } else {
      emit(WordGameInProgress(feedback, attempts, guess));
      isVisible = true;
    }
  }

  List<String> _provideFeedback(String guess) {
    List<String> feedback = List.filled(5, "grey");

    for (int i = 0; i < secretWord.length; i++) {
      if (secretWord[i] == guess[i]) {
        feedback[i] = "green";
      } else if (secretWord.contains(guess[i])) {
        feedback[i] = "yellow";
      }
    }

    return feedback;
  }

  String _getRandomWord() {
    final Random random = Random();
    return wordList[random.nextInt(wordList.length)];
  }
}

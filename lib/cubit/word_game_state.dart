part of 'word_game_cubit.dart';

abstract class WordGameState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WordGameInitial extends WordGameState {}

class WordGameStarted extends WordGameState {}

class WordGameInProgress extends WordGameState {
  final List<String> feedback;
  final int attempts;
  final String guess;

  WordGameInProgress(this.feedback, this.attempts, this.guess);

  @override
  List<Object?> get props => [feedback, attempts];
}

class WordGameSuccess extends WordGameState {
  final String secretWord;
  final int attempts;

  WordGameSuccess(this.secretWord, this.attempts);

  @override
  List<Object?> get props => [secretWord, attempts];
}

class WordGameFailure extends WordGameState {
  final String secretWord;

  WordGameFailure(this.secretWord);

  @override
  List<Object?> get props => [secretWord];
}

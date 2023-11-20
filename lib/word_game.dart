import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/word_game_cubit.dart';

class WordGameScreen extends StatefulWidget {
  const WordGameScreen({Key? key}) : super(key: key);

  @override
  _WordGameScreenState createState() => _WordGameScreenState();
}

class _WordGameScreenState extends State<WordGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            "images/bg_img.png",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Text(
              "Guess the Fruit Name",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          BlocBuilder<WordGameCubit, WordGameState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state is WordGameStarted || state is WordGameInProgress)
                    Text(
                      'Attempts: ${state is WordGameInProgress ? state.attempts : 0}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  if (state is WordGameInProgress)
                    GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 1.5,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: state.feedback[index] == "green"
                                ? Colors.green
                                : state.feedback[index] == "yellow"
                                ? Colors.yellow
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            state.guess.length > index ? state.guess[index] : '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        );
                      },
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                    ),
                  if (state is WordGameSuccess)
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 30,
                        ),
                        child: Text(
                          'Congratulations! You guessed the word "${state.secretWord}" in ${state.attempts} attempts.',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  if (state is WordGameFailure)
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 30,
                        ),
                        child: Text(
                          'Sorry! You lost. The correct word was "${state.secretWord}".',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  if (!(state is WordGameSuccess || state is WordGameFailure))
                    Visibility(
                      visible: context.read<WordGameCubit>().isVisible,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          maxLength: 5,
                          onChanged: (value) {
                            if (value.length == 5) {
                              context.read<WordGameCubit>().makeGuess(value);
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: 'Enter 5 characters',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  Visibility(
                    visible: context.read<WordGameCubit>().showButton,
                    child: Padding(
                      padding: !context.read<WordGameCubit>().isVisible
                          ? const EdgeInsets.only(top: 600.0)
                          : const EdgeInsets.only(top: 30.0),
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<WordGameCubit>().startNewGame();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff1EA5AE),
                          fixedSize: const Size(328, 54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Start New Game',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:assignment_02/player.dart';
import 'package:assignment_02/dice.dart';

class Game {
  Player playerOne, playerTwo;
  Dice dice;
  int diceOne, diceTwo;
  int playerOneTotal, playerTwoTotal;

  Game(
    this.playerOne,
    this.playerTwo,
    this.dice,
  );

  void play() {
    diceOne = dice.rollTheDice();
    diceTwo = dice.rollTheDice();
    playerOneTotal = diceOne + diceTwo;

    stdout.writeln('${playerOne.name}: $diceOne $diceTwo');

    diceOne = dice.rollTheDice();
    diceTwo = dice.rollTheDice();
    playerTwoTotal = diceOne + diceTwo;

    stdout.writeln('${playerTwo.name}: $diceOne $diceTwo');

    if (playerOneTotal > playerTwoTotal) {
      playerOne.updateScore();
    } else if (playerOneTotal < playerTwoTotal) {
      playerTwo.updateScore();
    }
  }

  void printResult() {
    if (playerOne.score > playerTwo.score) {
      stdout.writeln('${playerOne.name} won!');
    } else if (playerOne.score < playerTwo.score) {
      stdout.writeln('${playerOne.name} lost!');
    } else {
      stdout.writeln('Draw!');
    }

    stdout.writeln(
      '${playerOne.name} ${playerOne.score}'
      ' - '
      '${playerTwo.score} ${playerTwo.name}',
    );
  }
}

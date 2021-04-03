import 'dart:io';
import 'dart:math';

import 'package:assignment_02/dice.dart';
import 'package:assignment_02/game.dart';
import 'package:assignment_02/player.dart';

void main(List<String> arguments) {
  // OOP version
  final game = Game(Player('You'), Player('Computer'), Dice(6));

  stdout.write('Let\'s play Dice Game!'
      '\nPlease, push enter button to play or enter exit to quit.\n>>>');

  while (stdin.readLineSync() != 'exit') {
    game.play();
    stdout.write('>>>');
  }

  game.printResult();

  // alternative version
  // int playerDices, computerDices;
  // int playerScore = 0, computerScore = 0;

  // stdout.write('Let\'s play Dice Game!'
  //     '\nPlease, push enter button to play or enter exit to quit.\n>>>');

  // while (stdin.readLineSync() != 'exit') {
  //   // roll two dices
  //   playerDices = Random().nextInt(11) + 2;
  //   computerDices = Random().nextInt(11) + 2;

  //   stdout.writeln('You: $playerDices\nComputer: $computerDices');

  //   if (computerDices > playerDices) {
  //     computerScore++;
  //   } else if (playerDices > computerDices) {
  //     playerScore++;
  //   }

  //   stdout.write('>>>');
  // }

  // if (playerScore > computerScore) {
  //   stdout.writeln('You won!');
  // } else if (computerScore > playerScore) {
  //   stdout.writeln('You lost!');
  // } else {
  //   stdout.writeln('Draw!');
  // }

  // stdout.writeln('You $playerScore - $computerScore Computer');
}

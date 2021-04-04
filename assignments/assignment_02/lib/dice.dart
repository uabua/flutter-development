import 'dart:math';

class Dice {
  final int _sides;

  Dice(
    this._sides,
  );

  int rollTheDice() => Random().nextInt(_sides) + 1;
}

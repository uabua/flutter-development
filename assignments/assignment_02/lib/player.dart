class Player {
  final String _name;
  int _score;

  Player(this._name, {int score = 0}) : _score = score; // Initializer List

  void updateScore() => _score++;

  String get name => _name;

  int get score => _score;
}

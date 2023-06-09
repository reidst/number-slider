import 'dart:math' show Random;

class Coord {
  const Coord(this.row, this.col);
  final int row, col;

  @override
  bool operator ==(Object other) {
    return other is Coord
      ? (row == other.row && col == other.col)
      : false;
  }
  
  @override
  int get hashCode => row.hashCode * 31 + col.hashCode;

  Coord operator +(Coord other) => Coord(row + other.row, col + other.col);
  Coord operator -(Coord other) => Coord(row - other.row, col - other.col);
  Coord operator -() => Coord(-row, -col);
}

const validMoves = <Coord>[
  Coord(-1, 0),
  Coord(1, 0),
  Coord(0, -1),
  Coord(0, 1),
];

class SliderGame {
  SliderGame({required this.size}) {
    _board = List.generate(size, (row) => 
      List.generate(size, (col) =>
        row * size + col
      )
    );
    _space = Coord(size - 1, size - 1);
    _undoStack = List.empty(growable: true);
  }

  final int size;
  late final List<List<int>> _board;
  late Coord _space;
  late final List<Coord> _undoStack;
  int _playerMoveCount = 0;
  DateTime? date;

  Coord get space => _space;
  int get playerMoveCount => _playerMoveCount;
  int get shuffleStrength => size * size * 100;
  int operator [](Coord loc) => _board[loc.row][loc.col];

  /// Checks if all pieces are in order.
  bool isSolved() {
    for (int row = 0; row < size; row++) {
      for (int col = 0; col < size; col++) {
        if (_board[row][col] != row * size + col) {
          return false;
        }
      }
    }
    return true;
  }

  /// Checks if the piece at `coord` could be moved into the space.
  bool isSpaceAdjacent(Coord coord) {
    return validMoves.contains(coord - _space);
  }

  /// Checks if `coord` is within `(0, 0)` and `(size, size)`.
  bool inbounds(Coord coord) =>
    coord.row >= 0 &&
    coord.col >= 0 &&
    coord.row < size &&
    coord.col < size;

  /// Checks if the move given by `delta` can be made at this time, which
  /// requires that `delta` be one of the four unit directions and that the move
  /// does not overlap the board's edge.
  bool canMove(Coord delta) =>
    validMoves.contains(delta) &&
    inbounds(_space + delta);
  
  /// Moves to the current space the piece with offset `delta` from the space.
  /// Does nothing if `canMove(delta)` is true.
  void move(Coord delta, {bool ignoreMoveCount = false}) {
    if (!canMove(delta)) { return; }
    final Coord newSpace = _space + delta;
    final tmp = _board[newSpace.row][newSpace.col];
    _board[newSpace.row][newSpace.col] = _board[_space.row][_space.col];
    _board[_space.row][_space.col] = tmp;
    _space = newSpace;
    if (!ignoreMoveCount) {
      _playerMoveCount++;
      _undoStack.add(delta);
    }
  }

  /// Makes one or more random moves on the board.
  void randomMove([int count = 1, int? seed]) {
    final Random rand = Random(seed);
    for (var i = 0; i < count; i++) {
      int choice = rand.nextInt(validMoves.length);
      while (!canMove(validMoves[choice])) {
        choice = rand.nextInt(validMoves.length);
      }
      move(validMoves[choice], ignoreMoveCount: true);
    }
  }

  /// Moves opposite the last recorded move and decrements the move counter.
  void undo() {
    if (_undoStack.isEmpty) { return; }
    final lastMove = _undoStack.removeLast();
    move(-lastMove, ignoreMoveCount: true);
    _playerMoveCount--;
  }

  /// Resets the board and move counter by "undoing" all recorded moves.
  void reset() {
    for (var m in _undoStack.reversed) {
      move(-m, ignoreMoveCount: true);
    }
    _undoStack.clear();
    _playerMoveCount = 0;
  }

  /// Shuffles the board using a given year/month/day as a seed. Does nothing if
  /// the board has already been date-shuffled.
  void shuffleByDate(DateTime seed) {
    if (date != null) { return; }
    date = seed;
    randomMove(
      shuffleStrength,
      _dateToInt(seed),
    );
  }

  /// Platform-independent conversion from [DateTime] to [int].
  /// ```dart
  /// final testDate = DateTime(1996, 4, 20); // 20 April, 1996
  /// final converted = _dateToInt(testDate);
  /// print(converted); // 19960420
  /// ```
  int _dateToInt(DateTime date) =>
    int.parse(
      date.toIso8601String()
      .split('T')
      .first
      .split('-')
      .join()
    );
}
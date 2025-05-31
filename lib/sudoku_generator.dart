// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:math' as math;

class SudokuGenerator {
  final _random = math.Random();
  var board = List.generate(9, (_) => List.filled(9, 0));

  bool _isSafe(int row, int col, int number) {
    for (int i = 0; i < 9; i++)
      if (board[row][i] == number || board[i][col] == number) return false;

    int boxStartRow = (row ~/ 3) * 3;
    int boxStartCol = (col ~/ 3) * 3;
    for (int r = 0; r < 3; r++)
      for (int c = 0; c < 3; c++)
        if (board[boxStartRow + r][boxStartCol + c] == number) return false;

    return true;
  }

  bool _solve() {
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (board[row][col] == 0) {
          List<int> digits = List.generate(9, (index) => index + 1);

          digits.shuffle(_random);
          for (int number in digits) {
            if (_isSafe(row, col, number)) {
              board[row][col] = number;
              if (_solve()) return true;
              board[row][col] = 0;
            }
          }
          return false;
        }
      }
    }
    return true;
  }

  void generateFullSolution() {
    board = List.generate(9, (_) => List.filled(9, 0));
    _solve();
  }

  void removeCells(int cluesCount) {
    int cellsToRemove = 81 - cluesCount;

    while (cellsToRemove > 0) {
      int row = _random.nextInt(9);
      int col = _random.nextInt(9);

      if (board[row][col] != 0) {
        board[row][col] = 0;
        cellsToRemove--;
      }
    }
  }
}

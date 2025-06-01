// ignore_for_file: curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudoku_solver/solved_sudoku_screen.dart';
import 'package:sudoku_solver/sudoku_generator.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<_MainScreenContentState> contentKey = GlobalKey();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 60.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          tooltip: 'Back',
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF9CFFC9)),
        ),
        title: RichText(
          text: TextSpan(
            text: 'sudoku',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              fontFamily: GoogleFonts.josefinSans().fontFamily,
              letterSpacing: 2.0,
              color: const Color(0xFF9CFFC9),
            ),
            children: const <InlineSpan>[
              TextSpan(
                text: '.',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFFB59C),
                ),
              ),
              TextSpan(
                text: 'solver',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2.0,
                  color: Color(0xFF9CFFC9),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              contentKey.currentState?.refreshBoard();
            },
            tooltip: 'Reset',
            icon: const Icon(
              Icons.restart_alt_outlined,
              color: Color(0xFFFFB59C),
            ),
          ),
        ],
      ),
      body: MediaQuery.orientationOf(context) == Orientation.portrait
          ? SingleChildScrollView(child: _MainScreenContent(key: contentKey))
          : Center(
              child: SingleChildScrollView(
                child: _MainScreenContent(key: contentKey),
              ),
            ),
    );
  }
}

class _MainScreenContent extends StatefulWidget {
  const _MainScreenContent({super.key});

  @override
  State createState() {
    return _MainScreenContentState();
  }
}

class _MainScreenContentState extends State<_MainScreenContent> {
  int? selectedRow;
  int? selectedCol;
  Set<int> cluePositions = {};
  List board = List.generate(9, (_) => List.filled(9, 0));
  final sudokuGenerator = SudokuGenerator();

  void setDigit(int digit) {
    if (selectedRow != null && selectedCol != null) {
      final key = selectedRow! * 9 + selectedCol!;

      if (cluePositions.contains(key)) return;
      setState(() {
        board[selectedRow!][selectedCol!] = digit;
      });
    }
  }

  void clearDigit() {
    if (selectedRow != null && selectedCol != null) {
      final key = selectedRow! * 9 + selectedCol!;

      if (cluePositions.contains(key)) return;
      setState(() {
        board[selectedRow!][selectedCol!] = 0;
      });
    }
  }

  void _generateClues() {
    sudokuGenerator.generateFullSolution();
    sudokuGenerator.removeCells(10);

    cluePositions.clear();
    board = List.generate(9, (_) => List.filled(9, 0));

    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        int val = sudokuGenerator.board[row][col];

        if (val != 0) {
          board[row][col] = val;
          cluePositions.add(row * 9 + col);
        }
      }
    }
  }

  void refreshBoard() {
    setState(() {
      selectedRow = null;
      selectedCol = null;
      _generateClues();
    });
  }

  bool isValidSudoku(List board) {
    final rows = List.generate(9, (_) => <int>{});
    final cols = List.generate(9, (_) => <int>{});
    final boxes = List.generate(9, (_) => <int>{});

    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        final val = board[row][col];
        if (val == 0) continue;

        final boxIndex = (row ~/ 3) * 3 + (col ~/ 3);

        if (rows[row].contains(val) ||
            cols[col].contains(val) ||
            boxes[boxIndex].contains(val)) {
          return false;
        }

        rows[row].add(val);
        cols[col].add(val);
        boxes[boxIndex].add(val);
      }
    }
    return true;
  }

  bool isBoardComplete(List board) {
    for (final row in board)
      for (final cell in row) if (cell == 0) return false;

    return true;
  }

  @override
  void initState() {
    super.initState();
    _generateClues();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        selectedRow = null;
        selectedCol = null;
      }),
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: RichText(
              text: TextSpan(
                text: 'Select numbers from 1-9 below as ',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: GoogleFonts.josefinSans().fontFamily,
                  letterSpacing: 1.0,
                  color: const Color(0xFFFFFFFF),
                ),
                children: const <InlineSpan>[
                  TextSpan(
                    text: 'inputs ',
                    style: TextStyle(
                      color: Color(0xFFFFB59C),
                      letterSpacing: 1.0,
                    ),
                  ),
                  TextSpan(
                    text: 'for the Sudoku board.',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Wrap(
            spacing: -2.0,
            runSpacing: 2.0,
            children: List.generate(
              9,
              (row) => SizedBox(
                width: 112.0,
                child: Wrap(
                  children: List.generate(
                    9,
                    (col) => _SudokuCell(
                      digit: board[row][col] == 0
                          ? ''
                          : board[row][col].toString(),
                      isSelected: selectedRow == row && selectedCol == col,
                      isClue: cluePositions.contains(row * 9 + col),
                      onTap: cluePositions.contains(row * 9 + col)
                          ? null
                          : () => setState(() {
                              selectedRow = row;
                              selectedCol = col;
                            }),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40.0),
          Wrap(
            children: List.generate(
              10,
              (index) => Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      index != 9 ? setDigit(index + 1) : clearDigit();
                    },
                    child: Container(
                      width: 50.0,
                      height: 52.0,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFB59C),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: index != 9
                            ? Text(
                                '${index + 1}',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily:
                                      GoogleFonts.josefinSans().fontFamily,
                                  color: const Color(0xFF000000),
                                ),
                              )
                            : const Icon(Icons.cancel),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40.0),
          TextButton(
            onPressed: () {
              if (isValidSudoku(board) && isBoardComplete(board)) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SolvedSudokuScreen(
                      board: board,
                      cluePositions: cluePositions,
                    ),
                  ),
                );
              } else {
                HapticFeedback.mediumImpact();
                showUnsolvableDialog(context);
              }
            },
            style: TextButton.styleFrom(
              fixedSize: const Size(128.0, 38.0),
              backgroundColor: const Color(0xFF9CFFC9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(85.0),
              ),
            ),
            child: Text(
              'Solve',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.josefinSans().fontFamily,
                letterSpacing: 0.5,
                color: const Color(0xFF000000),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SudokuCell extends StatelessWidget {
  final String digit;
  final bool isClue;
  final bool isSelected;
  final VoidCallback? onTap;

  const _SudokuCell({
    required this.digit,
    required this.isSelected,
    required this.onTap,
    required this.isClue,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 34.98,
        height: 34.98,
        margin: const EdgeInsets.all(0.5),
        decoration: BoxDecoration(
          color: const Color(0xFF9CFFC9),
          border: Border.all(
            color: isSelected ? const Color(0xFFFFFFFF) : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Center(
          child: Text(
            digit,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              fontFamily: GoogleFonts.josefinSans().fontFamily,
              color: !isClue
                  ? const Color(0xFFE18464)
                  : const Color(0xFF000000),
            ),
          ),
        ),
      ),
    );
  }
}

void showUnsolvableDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 5.0),
      backgroundColor: const Color(0xFF1D1D1D),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Center(
        child: Text(
          'Oops!',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.josefinSans().fontFamily,
            letterSpacing: 0.5,
            color: const Color(0xFFFFB59C),
          ),
        ),
      ),
      content: Text(
        'The given sudoku could not be solved.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          fontFamily: GoogleFonts.josefinSans().fontFamily,
          letterSpacing: 0.5,
          color: const Color(0xFFFFFFFF),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            backgroundColor: Color(0xFFFFB59C),
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 8.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
          ),
          child: Text(
            'OK',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              fontFamily: GoogleFonts.josefinSans().fontFamily,
              letterSpacing: 0.5,
              color: const Color(0xFF000000),
            ),
          ),
        ),
      ],
    ),
  );
}

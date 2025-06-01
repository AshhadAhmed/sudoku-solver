import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudoku_solver/main_screen.dart';

class SolvedSudokuScreen extends StatelessWidget {
  final List board;
  final Set<int> cluePositions;

  const SolvedSudokuScreen({
    super.key,
    required this.board,
    required this.cluePositions,
  });

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Here\'s your solved Sudoku board.',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: GoogleFonts.josefinSans().fontFamily,
                    letterSpacing: 1.0,
                    color: const Color(0xFFFFFFFF),
                  ),
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
                      (col) => Container(
                        width: 34.98,
                        height: 34.98,
                        margin: const EdgeInsets.all(0.5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFF9CFFC9),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        child: Center(
                          child: Text(
                            board[row][col] == 0
                                ? ''
                                : board[row][col].toString(),
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.josefinSans().fontFamily,
                              color: !cluePositions.contains(row * 9 + col)
                                  ? const Color(0xFFE18464)
                                  : const Color(0xFF000000),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 63.0),
            TextButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MainScreen()),
              ),
              style: TextButton.styleFrom(
                fixedSize: const Size(128.0, 38.0),
                backgroundColor: const Color(0xFFFFB59C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(85.0),
                ),
              ),
              child: Text(
                'Retry',
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
      ),
    );
  }
}

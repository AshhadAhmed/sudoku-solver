import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sudoku_solver/main_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RichText(
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
              const SizedBox(height: 112.0),
              const Logo(),
              const SizedBox(height: 64.0),
              SizedBox(
                child: Column(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: 'Solve complex',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: GoogleFonts.josefinSans().fontFamily,
                          letterSpacing: 1.0,
                          color: const Color(0xFFFFFFFF),
                        ),
                        children: const <InlineSpan>[
                          TextSpan(
                            text: ' Sudoku',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF9CFFC9),
                            ),
                          ),
                          TextSpan(
                            text: '.',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    RichText(
                      text: TextSpan(
                        text: 'Within',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: GoogleFonts.josefinSans().fontFamily,
                          letterSpacing: 1.0,
                          color: const Color(0xFFFFFFFF),
                        ),
                        children: const <InlineSpan>[
                          TextSpan(
                            text: ' seconds',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFB59C),
                            ),
                          ),
                          TextSpan(
                            text: '.',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 64.0),
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                ),
                style: TextButton.styleFrom(
                  fixedSize: const Size(128.0, 38.0),
                  backgroundColor: const Color(0xFF9CFFC9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(85.0),
                  ),
                ),
                child: Text(
                  'Try Now',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.josefinSans().fontFamily,
                    color: const Color(0xFF000000),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    var list = ["S", "U", "", "", "D", "O", "K", "U", ""];

    return SizedBox(
      width: 210.63,
      child: Center(
        child: Wrap(
          spacing: 5.0,
          runSpacing: 5.0,
          children: List.generate(
            list.length,
            (index) => Container(
              width: 58.22,
              height: 58.22,
              decoration: BoxDecoration(
                color: list[index] != ""
                    ? const Color(0xFF9CFFC9)
                    : const Color(0xFFFFB59C),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Center(
                child: Text(
                  list[index],
                  style: TextStyle(
                    fontSize: 24.0,
                    color: const Color(0xFF000000),
                    fontFamily: GoogleFonts.josefinSans().fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

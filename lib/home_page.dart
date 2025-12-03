import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/game_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activePlayer = 'X';
  bool gameOver = false;
  int turn = 0;
  String result = '';
  Game game = Game();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 14, 57),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color.fromARGB(255, 1, 14, 57),
                const Color.fromARGB(255, 2, 25, 85),
                const Color.fromARGB(255, 1, 14, 57),
              ],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SwitchListTile.adaptive(
                  title: Text(
                    'Turn on/off Two Players',
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  value: isSwitched,
                  onChanged: (bool newValue) {
                    setState(() {
                      isSwitched = newValue;
                    });
                  },
                  activeColor: const Color(0xFFFCA311),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'It\'s $activePlayer turn'.toUpperCase(),
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 20),

              Container(
                width: 340,
                height: 340,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  crossAxisCount: 3,
                  children: List.generate(9, (index) => buildCell(index)),
                ),
              ),

              const SizedBox(height: 15),

              if (result.isNotEmpty)
                Text(
                  result,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFCA311),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 10),

              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    Player.playerX = [];
                    Player.playerO = [];
                    activePlayer = 'X';
                    gameOver = false;
                    turn = 0;
                    result = '';
                  });
                },
                icon: const Icon(Icons.replay, color: Colors.white),
                label: Text(
                  'Restart Game',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFCA311),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                  shadowColor: const Color(0xFFFCA311).withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCell(int index) {
    return InkWell(
      onTap: gameOver ? null : () => _onTap(index),

      borderRadius: BorderRadius.circular(20),
      splashColor: const Color(0xFFFCA311).withOpacity(0.3),
      highlightColor: const Color(0xFFFCA311).withOpacity(0.1),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 13, 71, 161),
              const Color.fromARGB(255, 25, 118, 210),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            Player.playerX.contains(index)
                ? 'X'
                : Player.playerO.contains(index)
                ? 'O'
                : ' ',
            style: GoogleFonts.poppins(
              color: Player.playerX.contains(index)
                  ? Color(0xFFFCA311)
                  : Colors.pinkAccent,
              fontSize: 56,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onTap(int index) async {
    // Check if cell is already taken BEFORE playing
    if (Player.playerX.contains(index) || Player.playerO.contains(index)) {
      return; // Cell already taken, do nothing
    }

    // Play the game
    game.playGame(index, activePlayer);
    updateState();
  }

  void updateState() {
    setState(() {
      // Switch player
      activePlayer = (activePlayer == 'X') ? 'O' : 'X';
      turn++;

      // Check for winner
      String winnerCheck = game.checkWinner();
      if (winnerCheck != '') {
        gameOver = true;
        result = '$winnerCheck is the winner!';
      } else if (turn == 9) {
        // Check for draw
        gameOver = true;
        result = 'It\'s a Draw!';
      }
    });
  }
}

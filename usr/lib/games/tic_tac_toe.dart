import 'package:flutter/material.dart';

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String winner = '';
  bool isDraw = false;

  void _handleTap(int index) {
    if (board[index] != '' || winner != '') return;

    setState(() {
      board[index] = currentPlayer;
      if (_checkWinner(currentPlayer)) {
        winner = currentPlayer;
      } else if (!board.contains('')) {
        isDraw = true;
      } else {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      }
    });
  }

  bool _checkWinner(String player) {
    const lines = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6]             // Diagonals
    ];

    for (var line in lines) {
      if (board[line[0]] == player &&
          board[line[1]] == player &&
          board[line[2]] == player) {
        return true;
      }
    }
    return false;
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      winner = '';
      isDraw = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStatusText(),
          const SizedBox(height: 20),
          _buildBoard(),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _resetGame,
            icon: const Icon(Icons.refresh),
            label: const Text('Restart Game'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusText() {
    String text;
    Color color;
    
    if (winner != '') {
      text = 'Player $winner Wins!';
      color = Colors.green;
    } else if (isDraw) {
      text = 'It\'s a Draw!';
      color = Colors.orange;
    } else {
      text = 'Player $currentPlayer\'s Turn';
      color = Colors.black87;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24, 
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildBoard() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: AspectRatio(
        aspectRatio: 1,
        child: GridView.builder(
          padding: const EdgeInsets.all(20),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _handleTap(index),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    board[index],
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: board[index] == 'X' 
                          ? Colors.blue.shade700 
                          : Colors.red.shade700,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

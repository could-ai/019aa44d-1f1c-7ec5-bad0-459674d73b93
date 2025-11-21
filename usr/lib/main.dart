import 'package:flutter/material.dart';
import 'games/tic_tac_toe.dart';

void main() {
  runApp(const GameApp());
}

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Games',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/tictactoe': (context) => const TicTacToeGame(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Hub'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.games,
              size: 80,
              color: Colors.indigo,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to Game Hub',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Choose a game to start playing',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 50),
            _buildGameCard(
              context,
              title: 'Tic Tac Toe',
              icon: Icons.grid_3x3,
              color: Colors.blue,
              route: '/tictactoe',
            ),
            // Placeholder for future games
            // _buildGameCard(context, title: 'Snake', icon: Icons.gesture, color: Colors.green, route: '/snake'),
          ],
        ),
      ),
    );
  }

  Widget _buildGameCard(BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required String route,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

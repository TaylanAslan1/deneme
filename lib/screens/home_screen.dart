import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../services/api_service.dart';
import '../widgets/exercise_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Exercise>> _exerciseFuture;

  @override
  void initState() {
    super.initState();
    _exerciseFuture = ApiService().fetchExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Moves'),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<Exercise>>(
        future: _exerciseFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: \${snapshot.error}'));
          } else {
            final exercises = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                return ExerciseCard(exercise: exercises[index]);
              },
            );
          }
        },
      ),
    );
  }
}

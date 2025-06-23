import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../services/api_service.dart';

class ExerciseListScreen extends StatefulWidget {
  const ExerciseListScreen({super.key});

  @override
  State<ExerciseListScreen> createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {
  late Future<List<Exercise>> _exercisesFuture;

  @override
  void initState() {
    super.initState();
    _exerciseFuture = ApiService().fetchExercises();
  }

  void showExerciseDetails(Exercise exercise) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exercise.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(height: 20, thickness: 2),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    exercise.description.replaceAll(RegExp(r'<[^>]*>'), ''),
                    style: const TextStyle(fontSize: 16, height: 1.4),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Kapat'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildExerciseCard(Exercise exercise) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        leading: const Icon(Icons.fitness_center, size: 36, color: Colors.teal),
        title: Text(
          exercise.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          exercise.description.isNotEmpty
              ? exercise.description.replaceAll(RegExp(r'<[^>]*>'), '')
              : 'Açıklama yok',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
        onTap: () => showExerciseDetails(exercise),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Egzersizleri'),
        centerTitle: true,
        elevation: 4,
      ),
      body: FutureBuilder<List<Exercise>>(
        future: _exercisesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Hata: ${snapshot.error}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Egzersiz bulunamadı'));
          } else {
            final exercises = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.only(top: 12, bottom: 20),
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                return buildExerciseCard(exercises[index]);
              },
            );
          }
        },
      ),
    );
  }
}

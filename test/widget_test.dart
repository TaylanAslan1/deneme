// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fitnessapp/main.dart';

void main() {
  testWidgets('Alt menü navigasyonu testi', (WidgetTester tester) async {
    // Uygulamayı çalıştır
    await tester.pumpWidget(FitnessApp());

    // İlk ekran Dashboard olmalı
    expect(find.text('Dashboard'), findsOneWidget);

    // Egzersiz sekmesine tıkla
    await tester.tap(find.byIcon(Icons.list));
    await tester.pumpAndSettle();

    // Exercise List ekranı yüklendi mi?
    expect(find.text('Exercise List'), findsOneWidget);

    // Workout sekmesine tıkla
    await tester.tap(find.byIcon(Icons.timer));
    await tester.pumpAndSettle();

    // Workout ekranı yüklendi mi?
    expect(find.text('Workout Timer'), findsOneWidget);
  });
}

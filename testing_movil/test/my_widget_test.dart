import 'package:flutter_test/flutter_test.dart';
import 'package:testing_movil/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:testing_movil/list_widget.dart';
void main()
{
  testWidgets("Mi widget de login ", (tester) async{
    await tester.pumpWidget(const MyWidget(user: "U", password: "C"));

    final userFinder = find.text("U");
    final passFinder = find.text("C");

    expect(userFinder, findsOneWidget);
    expect(passFinder, findsOneWidget);
  });
  testWidgets("Mi widget de appBar ", (tester) async{
    await tester.pumpWidget(const ListWidget());

    final buttonFinder = find.byType(IconButton);
    expect(buttonFinder, findsAtLeast(3));
  });

}
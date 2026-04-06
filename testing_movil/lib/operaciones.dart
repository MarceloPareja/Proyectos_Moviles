class Operaciones {
  late double num1;
  late double num2;
  Operaciones({required this.num1, required this.num2});

  double suma()
  {
    return num1 + num2;
  }
  double resta()
  {
    return num1 - num2;
  }
  double division()
  {
    return (num2 == 0) ? 0.0 : num1/num2;
  }
}
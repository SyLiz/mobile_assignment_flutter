import 'model/fibonacci_model.dart';

List<Fibonacci> generateFibonacciList(int count) {
  List<BigInt> fibNumbers = [BigInt.zero, BigInt.one];
  for (int i = 2; i < count; i++) {
    fibNumbers.add(fibNumbers[i - 1] + fibNumbers[i - 2]);
  }

  return List.generate(count, (i) => Fibonacci(i, fibNumbers[i], getFibonacciType(fibNumbers[i])));
}

FibonacciType getFibonacciType(BigInt number) {
  int remainder = (number % BigInt.from(3)).toInt();

  switch (remainder) {
    case 0:
      return FibonacciType.circle; // ⭕ Divisible by 3
    case 1:
      return FibonacciType.square; // 🔲 Remainder 1
    case 2:
      return FibonacciType.cross; // ❎ Remainder 2
    default:
      return FibonacciType.cross; // Fallback (should never happen)
  }
}

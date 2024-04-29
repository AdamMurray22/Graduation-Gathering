import 'package:graduation_gathering/Sorts/heap_sort.dart';
import 'package:graduation_gathering/Sorts/comparator.dart';
import 'package:test/test.dart';

void main() {
  group('Heap Sort Tests', () {

    test('.sort() valid integer list', () {
      HeapSort<int> sort = HeapSort((int1, int2) {
        return int1 <= int2 ? Comparator.before : Comparator.after;
      });
      expect(sort.sort([3, 2, 1]), equals([1, 2, 3]));
    });

    test('.sort() empty list', () {
      HeapSort<int> sort = HeapSort((int1, int2) {
        return int1 <= int2 ? Comparator.before : Comparator.after;
      });
      expect(sort.sort([]), equals([]));
    });
  });
}
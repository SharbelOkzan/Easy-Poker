enum CardIndex {
  two(value: 2, displayName: '2'),
  three(value: 3, displayName: '3'),
  four(value: 4, displayName: '4'),
  five(value: 5, displayName: '5'),
  six(value: 6, displayName: '6'),
  seven(value: 7, displayName: '7'),
  eight(value: 8, displayName: '8'),
  nine(value: 9, displayName: '9'),
  ten(value: 10, displayName: '10'),
  jack(value: 11, displayName: 'J'),
  queen(value: 12, displayName: 'Q'),
  king(value: 13, displayName: 'K'),
  ace(value: 13, displayName: 'A');

  final int value;
  final String displayName;

  const CardIndex({required this.value, required this.displayName});
}

bool isDatePassed(DateTime expirationDate) {
  final now = DateTime.now();
  final bool isExpired = expirationDate.isBefore(now);
  return isExpired;
}

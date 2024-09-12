// The part of data layer which will collect raw data from the external source and provide the raw data to the repositoriey.

class CounterDataProvider {
  Future<void> updateValueInBackend({required int val}) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getCountStoredInBackend() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return 18;
    } catch (e) {
      rethrow;
    }
  }
}

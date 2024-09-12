// The part of data layer which will raw data from the data providers and convert into objects of type(defined in model class) intract with the bloc

import 'package:counter_custom_bloc/backend_service/counter_data_layer/counter_data_model.dart';
import 'counter_data_provider.dart';

class CounterRepository {
  CounterDataProvider counterDataProvider = CounterDataProvider();

  Future<void> updateCount({required int count}) async {
    try {
      await counterDataProvider.updateValueInBackend(val: count);
    } catch (e) {
      rethrow;
    }
  }

  Future<CounterDataModel> getCountStoredInBackend() async {
    try {
      int initCount = await counterDataProvider.getCountStoredInBackend();
      CounterDataModel dataModel = CounterDataModel(
        auId: 'userId',
        count: initCount,
      );
      return dataModel;
    } catch (e) {
      rethrow;
    }
  }
}

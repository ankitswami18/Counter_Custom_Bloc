import 'dart:async';
import 'package:counter_custom_bloc/backend_service/counter_data_layer/counter_data_model.dart';
import 'package:counter_custom_bloc/backend_service/counter_data_layer/counter_repository.dart';
import 'package:counter_custom_bloc/bloc/counter_bloc_model.dart';
import 'package:provider/provider.dart';

class CounterBloc {
  // GETTING THE BLOC MODEL OBJECT.
  CounterBlocModel _model = CounterBlocModel();

  // STEP 1: CREATE THE STREAM-CONTROLLER
  final StreamController<CounterBlocModel> _streamController =
      StreamController<CounterBlocModel>();

  // Step 2: CLOSING THE STREAM-CONTROLLER
  dispose() {
    _streamController.close();
  }

  // Step 3: STREAM (GET THE VALUES FROM STREAM)
  Stream<CounterBlocModel> get streamBlocModel => _streamController.stream;

  // Step 4: ADDING VALUES TO THE STREAM
  void updateWith({
    int? count,
    bool? isLoading,
  }) {
    _model = _model.copyWith(
      count: count,
      isLoading: isLoading,
    );
    _streamController.sink.add(_model);
  }

  // LOGIC CODE:

  Future<CounterDataModel> getVal(context) async {
    final repoObj = Provider.of<CounterRepository>(
      context,
      listen: false,
    );
    try {
      return await repoObj.getCountStoredInBackend();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveVal(context, {required int count}) {
    final repoObj = Provider.of<CounterRepository>(
      context,
      listen: false,
    );
    try {
      return repoObj.updateCount(count: count);
    } catch (e) {
      rethrow;
    }
  }
}

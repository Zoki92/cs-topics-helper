import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cs_topics_app/models/data_structure.dart';
import 'package:cs_topics_app/repository/repository.dart';
import 'package:equatable/equatable.dart';

import 'package:rxdart/rxdart.dart';

part 'infinite_scroll_event.dart';
part 'infinite_scroll_state.dart';

class InfiniteScrollBloc
    extends Bloc<InfiniteScrollEvent, InfiniteScrollState> {
  final DataStructureRepository _dataStructureRepository;
  static const SERVER_ERROR = "Failed to obtain data from the server.";

  InfiniteScrollBloc(this._dataStructureRepository);

  @override
  InfiniteScrollState get initialState => InfiniteScrollInitial();

  bool _hasReachedMax(InfiniteScrollState state) =>
      state is InfiteScrollSuccess && state.hasReachedMax;

  @override
  Stream<Transition<InfiniteScrollEvent, InfiniteScrollState>> transformEvents(
    Stream<InfiniteScrollEvent> events,
    TransitionFunction<InfiniteScrollEvent, InfiniteScrollState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<InfiniteScrollState> mapEventToState(
    InfiniteScrollEvent event,
  ) async* {
    var currentState = state;
    if (event is FetchData && !_hasReachedMax(currentState)) {
      if (currentState is InfiniteScrollInitial) {
        try {
          Map dataAndNextUrl =
              await _dataStructureRepository.getDataStructureList();
          yield InfiteScrollSuccess(
            dataStructures: dataAndNextUrl['data'],
            hasReachedMax: !_checkIfNextUrl(dataAndNextUrl['nextUrl']),
            nextUrl: dataAndNextUrl['nextUrl'],
          );
        } catch (e) {
          yield InfiteScrollFailure(message: SERVER_ERROR);
        }
      } else if (currentState is InfiteScrollSuccess) {
        try {
          Map dataAndNextUrl = await _dataStructureRepository
              .getDataStructureList(url: currentState.nextUrl);
          yield currentState.copyWith(
            dataStructures:
                currentState.dataStructures + dataAndNextUrl['data'],
            hasReachedMax: _checkIfNextUrl(dataAndNextUrl['nextUrl']),
            nextUrl: dataAndNextUrl['nextUrl'],
          );
        } catch (e) {
          yield InfiteScrollFailure(message: SERVER_ERROR);
        }
      }
    }
  }

  bool _checkIfNextUrl(String nextUrl) {
    String url;
    if (nextUrl != null) {
      return true;
    }
    return false;
  }
}

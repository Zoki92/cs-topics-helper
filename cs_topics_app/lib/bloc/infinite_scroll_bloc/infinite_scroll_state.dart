part of 'infinite_scroll_bloc.dart';

abstract class InfiniteScrollState extends Equatable {
  const InfiniteScrollState();
  @override
  List<Object> get props => [];
}

class InfiniteScrollInitial extends InfiniteScrollState {}

class InfiteScrollFailure extends InfiniteScrollState {
  final String message;

  const InfiteScrollFailure({this.message});

  List<Object> get props => [message];
}

class InfiteScrollSuccess extends InfiniteScrollState {
  final List<DataStructure> dataStructures;
  final bool hasReachedMax;
  final String nextUrl;

  const InfiteScrollSuccess(
      {this.dataStructures, this.hasReachedMax, this.nextUrl});

  InfiteScrollSuccess copyWith({
    List<DataStructure> dataStructures,
    bool hasReachedMax,
    String nextUrl,
  }) {
    return InfiteScrollSuccess(
      dataStructures: dataStructures ?? this.dataStructures,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      nextUrl: nextUrl ?? this.nextUrl,
    );
  }

  @override
  List<Object> get props => [dataStructures, hasReachedMax, nextUrl];
}

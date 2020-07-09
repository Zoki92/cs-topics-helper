part of 'on_app_start_bloc.dart';

abstract class OnAppStartState {}

class OnAppStartInitial extends OnAppStartState {}

class OnAppStartLoading extends OnAppStartState {}

class OnAppStartLoaded extends OnAppStartState {}

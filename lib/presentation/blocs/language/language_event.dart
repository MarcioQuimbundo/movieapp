part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class ToogleLanguageEvents extends LanguageEvent {
  final LanguageEntity language;

  const ToogleLanguageEvents(this.language);

  @override
  List<Object> get props => [language];
}

class LoadPreferredLanguageEvent extends LanguageEvent {}

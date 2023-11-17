import 'package:equatable/equatable.dart';

class LookupsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetLookups extends LookupsEvent {}

class GetLookupsByKey extends LookupsEvent {
  final String lookupKey;

  GetLookupsByKey({required this.lookupKey});
}

class GetCountriesLookup extends LookupsEvent {}

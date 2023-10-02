import 'dart:async';
import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_hotel/data.dart';

abstract class NumberEvent extends Equatable{
  const NumberEvent();
  @override
  List<Object> get props => [];
}

class ChangeNumberEvent extends NumberEvent{
final String number;
  const ChangeNumberEvent({required this.number});
}




abstract class NumberState extends Equatable{
  const NumberState();
  @override
  List<Object> get props => [];
}

class ChangeNumberState extends NumberState{
  final String number;
  const ChangeNumberState({required this.number});
}
class BeginNumberState extends NumberState{
  const BeginNumberState();
}

class MiddleNumberState extends NumberState{
  const MiddleNumberState();
}
class ArticleErrorState extends NumberState{
  const ArticleErrorState();
}




class NumberBloc extends Bloc<NumberEvent,NumberState>{

  NumberBloc() : super(const BeginNumberState()){
    on<NumberEvent>((event,emit)async{
      if(event is ChangeNumberEvent){
        emit(const MiddleNumberState());
       emit(ChangeNumberState(number: event.number));
      }
    });

  }

}
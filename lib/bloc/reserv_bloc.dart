import 'dart:async';
import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_hotel/data.dart';

abstract class ReserveEvent extends Equatable{
  const ReserveEvent();
  @override
  List<Object> get props => [];
}

class LoadReserveEvent extends ReserveEvent{

  const LoadReserveEvent();
}




abstract class ReserveState extends Equatable{
  const ReserveState();
  @override
  List<Object> get props => [];
}

class LoadReserveBegin extends ReserveState{
  const LoadReserveBegin();
}


class LoadReserveProgress extends ReserveState{
  const LoadReserveProgress();
}
class ReserveErrorState extends ReserveState{
  const ReserveErrorState();
}

class ReserveFinishData extends ReserveState{
  final Map<String,dynamic> article;
  const ReserveFinishData(this.article);
}




class ReserveBloc extends Bloc<ReserveEvent,ReserveState>{
  PersonRemoteDataSource data = PersonRemoteDataSourceImpl();
  ReserveBloc() : super(const LoadReserveBegin()) {
    on<ReserveEvent>((event,emit)async{
      if(event is ReserveEvent){
        await loadArticleData(event, emit);
      }
    });
    add(const LoadReserveEvent());
  }

  Future<void> loadArticleData(
      ReserveEvent event,
      Emitter<ReserveState> emit,
      ) async {
    emit(const LoadReserveProgress());
    final dataRes = await data.getReserveData();
    emit(ReserveFinishData(dataRes));
    print("${state}articlesss");
    print((state as ReserveFinishData).article);

  }
}
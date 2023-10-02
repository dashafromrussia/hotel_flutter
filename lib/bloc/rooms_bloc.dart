import 'dart:async';
import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_hotel/data.dart';

abstract class RoomEvent extends Equatable{
  const RoomEvent();
  @override
  List<Object> get props => [];
}

class LoadRoomEvent extends RoomEvent{

  const LoadRoomEvent();
}




abstract class RoomState extends Equatable{
  const RoomState();
  @override
  List<Object> get props => [];
}

class LoadRoomBegin extends RoomState{
  const LoadRoomBegin();
}


class LoadRoomProgress extends RoomState{
  const LoadRoomProgress();
}
class RoomErrorState extends RoomState{
  const RoomErrorState();
}

class RoomFinishData extends RoomState{
  final List<Map<String,dynamic>> articles;
  const RoomFinishData(this.articles);
}




class RoomBloc extends Bloc<RoomEvent,RoomState>{
  PersonRemoteDataSource data = PersonRemoteDataSourceImpl();
  RoomBloc() : super(const LoadRoomBegin()) {
    on<RoomEvent>((event,emit)async{
      if(event is LoadRoomEvent){
        await loadArticleData(event, emit);
      }
    });
    add(const LoadRoomEvent());
  }

  Future<void> loadArticleData(
      LoadRoomEvent event,
      Emitter<RoomState> emit,
      ) async {
    emit(const LoadRoomProgress());
    final dataRes = await data.getRoomInfo();
    emit(RoomFinishData(dataRes));
    print("${state}articlesss");
    print((state as RoomFinishData).articles);

  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hotel/bloc/reserv_bloc.dart';
import 'package:flutter_hotel/main.dart';


class ReserveScreen extends StatelessWidget {
  const ReserveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(centerTitle:true,title: const Text('Бронирование',textAlign:TextAlign.center, style: TextStyle(fontSize: 16,color: Colors.black)),
    backgroundColor: Colors.white,
    leading: GestureDetector(
    onTap: (){
    Navigator.pop(context);
    },
    child: const Icon(Icons.arrow_back_ios_outlined,color: Colors.black,),
    ),
    ),
     body:Container(
       margin: const EdgeInsets.only(top: 5),
       child: ListView(children: const [
       MainReserve(),
       SizedBox(height: 5,),
        AboutReserve()
     ],),),
    );
  }
}

class InfoBuy extends StatefulWidget {
  const InfoBuy({Key? key}) : super(key: key);

  @override
  State<InfoBuy> createState() => _InfoBuyState();
}

class _InfoBuyState extends State<InfoBuy> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding:const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
    decoration:const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    color: Colors.white
    ),
    child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       const Text("Информация о покупателе",style:TextStyle(fontSize: 22,fontWeight: FontWeight.w500,)),
    ],)
    );
  }
}


class AboutReserve extends StatelessWidget {
  const AboutReserve({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ReserveBloc>();
    final data = bloc.state is ReserveFinishData? (bloc.state as ReserveFinishData).article :{};
    return  bloc.state is ReserveFinishData? Container(
      padding:const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
      decoration:const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
   Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     mainAxisAlignment: MainAxisAlignment.start,
     children: [
       Text("Вылет из",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color:HexColor.fromHex('#828796'),)),
       const SizedBox(height: 19,),
       Text("Страна,город",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color:HexColor.fromHex('#828796'),)),
       const SizedBox(height: 19,),
       Text("Даты",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color:HexColor.fromHex('#828796'),)),
       const SizedBox(height: 19,),
       Text("Кол-во ночей",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color:HexColor.fromHex('#828796'),)),
       const SizedBox(height: 19,),
       Text("Отель",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color:HexColor.fromHex('#828796'),)),
       const SizedBox(height: 19,),
       const SizedBox(height: 19,),
       Text("Номер",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color:HexColor.fromHex('#828796'),)),
       const SizedBox(height: 19,),
       const SizedBox(height: 19,),
       Text("Питание",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color:HexColor.fromHex('#828796'),)),
     ],
   ),
          const SizedBox(width: 20,),
          Expanded(child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(data["departure"],style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,)),
              const SizedBox(height: 19,),
              Text(data["arrival_country"],style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,)),
              const SizedBox(height: 19,),
              Text("${data["tour_date_start"]}-${data["tour_date_stop"]}",style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,)),
              const SizedBox(height: 19,),
              Text(data["number_of_nights"].toString(),style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,)),
              const SizedBox(height: 19,),
              Text(data["hotel_adress"],style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,)),
              const SizedBox(height: 19,),
              Text(data["room"].toString(),style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,)),
              const SizedBox(height: 19,),
              Text(data["nutrition"],style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,)),
            ],
          )),
        ],),
    ):const SizedBox();
  }
}

class MainReserve extends StatelessWidget {
  const MainReserve({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ReserveBloc>();
    final data = bloc.state is ReserveFinishData? (bloc.state as ReserveFinishData).article :{};
    return  bloc.state is ReserveFinishData? Container(
      padding:const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
       // width: 90,
       // height: 22,
    decoration:const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    color: Colors.white
    ),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 149,
                height: 29,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: HexColor.fromHex('#FFC700').withOpacity(0.2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star,size:15,color: HexColor.fromHex('#FFA800'),),
                    Text(" ${data['horating'].toString()}",style: TextStyle(color: HexColor.fromHex('#FFA800'),fontSize: 16),),
                    Text(" ${data['rating_name']}",style: TextStyle(color: HexColor.fromHex('#FFA800'),fontSize: 16))
                  ],),
              )],),
          const SizedBox(height: 5,),
        const SizedBox(
            width: 343,
            height: 26,
            child: Text('Steigenberger Makadi',style:  TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
          ),
          const SizedBox(height: 5,),
          SizedBox(
              height: 17,
              width: 343,
              child:GestureDetector(child: Text(data['hotel_adress'],style:TextStyle(fontSize: 14, color:HexColor.fromHex('#0D72FF'),fontWeight: FontWeight.w500),),)
          ),
          const SizedBox(height: 5,),
      ],),
    ):const SizedBox();
  }
}
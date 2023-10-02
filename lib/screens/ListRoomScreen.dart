import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hotel/bloc/reserv_bloc.dart';
import 'package:flutter_hotel/bloc/rooms_bloc.dart';
import 'package:flutter_hotel/data.dart';
import 'package:flutter_hotel/main.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_hotel/screens/ReserveScreen.dart';



class ListRoom extends StatelessWidget {
  const ListRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<RoomBloc>();
    final data = bloc.state is RoomFinishData? (bloc.state as RoomFinishData).articles :[];
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(centerTitle:true,title: const Text('Steigenberger Makadi',style: TextStyle(fontSize: 16,color: Colors.black)),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_outlined,color: Colors.black,),
        ),
      ),
      body:Container(
      //  padding:const EdgeInsets.only(top:5),
        child:bloc.state is RoomFinishData ? ListView.builder(
          itemCount: data.length,
            itemBuilder:(context,index){
             return Column(
               children: [
                 AboutRoom(data: data[index],index:index),
                 const SizedBox(height: 5,)
               ],
             );
            }
      ):const SizedBox(),),
    );
  }
}


class AboutRoom extends StatefulWidget {
  final Map<String,dynamic> data;
  final int index;
  const AboutRoom({Key? key,required this.data,required this.index}) : super(key: key);

  @override
  State<AboutRoom> createState() => _AboutRoomState();
}

class _AboutRoomState extends State<AboutRoom> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      ...widget.data['image_urls']
    ];
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
      child: Container(
        //  margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: Stack(
              children: <Widget>[
                Image.network(item, fit: BoxFit.cover, width:343,height: 257,),
              ],
            )),
      ),
    ))
        .toList();
    return Column(children: [
      Container(
        padding: const EdgeInsets.only(top: 10),
          decoration:BoxDecoration(
              borderRadius:widget.index==0?const BorderRadius.vertical(bottom: Radius.circular(12),top: Radius.zero):const BorderRadius.all(Radius.circular(12)),
              color: Colors.white
          ),
          child: Column(children: [Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                CarouselSlider(
                  items: imageSliders,
                  carouselController: _controller,
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                ),
                Container(
                  width: 90,
                  height: 22,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration:const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Colors.white
                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Expanded(child:Container(
                          width: 7.0,
                          height: 7.0,
                          margin:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                                  .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                        )),
                      );
                    }).toList(),
                  ),),
              ]),
            const SizedBox(height: 10,),
            Container(
              margin:const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 343,
                  height: 52,
                  child:  Text(widget.data["name"],style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
                ),
                const SizedBox(height: 15,),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Text("${widget.data["peculiarities"][0]}",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color:HexColor.fromHex('#828796'),),),),
                      const SizedBox(width: 5,),
                      Expanded(child: Text("${widget.data["peculiarities"][1]}",style:TextStyle(fontSize: 16, color:HexColor.fromHex('#828796'),fontWeight: FontWeight.w500),)),

                    ]),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 192,
                      height: 29,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          color: HexColor.fromHex('#0D72FF').withOpacity(0.1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Подробнее о номере",style: TextStyle(color: HexColor.fromHex('#0D72FF'),fontSize: 16)),
                          const SizedBox(width: 10,),
                          Icon(Icons.arrow_forward_ios,size:15,color: HexColor.fromHex('#0D72FF'),),
                        ],),
                    )],),
                const SizedBox(height: 5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("${widget.data['price'].toString().substring(0,3)} ${widget.data['price'].toString().substring(3,6)} ₽ ",style:const TextStyle(fontSize: 30,fontWeight: FontWeight.w600),),
                   Expanded(child:Text(widget.data['price_per'].toLowerCase(),style:TextStyle(fontSize: 16, color:HexColor.fromHex('#828796'),fontWeight: FontWeight.w400),))
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(child:GestureDetector(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>MultiBlocProvider(
                              providers: [
                                BlocProvider<ReserveBloc>(
                                    create: (context) =>ReserveBloc()),
                              ],
                              child: const ReserveScreen()),));
                        },
                        child:Container(
                      width: 343,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color:HexColor.fromHex('#0D72FF'),
                          borderRadius:const BorderRadius.all(Radius.circular(15))
                      ),
                      child:const Text("Выбрать номер",textAlign:TextAlign.center,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white)),
                    ))),
                  ],
                ),
               const SizedBox(height: 5,)
            ],),)
        ,
            const SizedBox(height: 10,),
          ]))
    ],);
  }
}



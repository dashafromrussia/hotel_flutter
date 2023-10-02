import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';


abstract class PersonRemoteDataSource {
  Future<Map<String,dynamic>> getData();
  Future<List<Map<String,dynamic>>> getRoomInfo();
  Future<Map<String,dynamic>> getReserveData();
}



class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final client = http.Client();


 PersonRemoteDataSourceImpl();
/*{
  "id": 1,
  "hotel_name": "Лучший пятизвездочный отель в Хургаде, Египет",
  "hotel_adress": "Madinat Makadi, Safaga Road, Makadi Bay, Египет",
  "horating": 5,
  "rating_name": "Превосходно",
  "departure": "Москва",
  "arrival_country": "Египет, Хургада",
  "tour_date_start": "19.09.2023",
  "tour_date_stop": "27.09.2023",
  "number_of_nights": 7,
  "room": "Люкс номер с видом на море",
  "nutrition": "Все включено",
  "tour_price": 289400,
  "fuel_charge": 9300,
  "service_charge": 2150
}*/
  @override
  Future<Map<String,dynamic>> getReserveData() async {

    var uri = Uri.http('run.mocky.io','v3/e8868481-743f-4eb2-a0d7-2bc4012275c8');
    final response = await client
        .post(uri,
        headers: {"Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'}, body: '');
    // client.close();
    if (response.statusCode == 200) {
      //print("RESPO${response.body}respose");
      final data = json.decode(response.body);
      final Map<String,dynamic> dataRes = (data as Map<String,dynamic>);

      return {
        "id": dataRes["id"] as int,
        "hotel_name": dataRes["hotel_name"] as String,
        "hotel_adress": dataRes["hotel_adress"] as String,
        "horating": dataRes["horating"] as int,
        "rating_name": dataRes["rating_name"] as String,
        "departure": dataRes["departure"] as String,
        "arrival_country": dataRes["arrival_country"] as String,
        "tour_date_start": dataRes["tour_date_start"] as String,
        "tour_date_stop": dataRes["tour_date_stop"] as String,
        "number_of_nights": dataRes["number_of_nights"] as int,
        "room": dataRes["room"] as String,
        "nutrition": dataRes["nutrition"] as String,
        "tour_price": dataRes["tour_price"] as int,
        "fuel_charge": dataRes["fuel_charge"] as int,
        "service_charge": dataRes["service_charge"] as int
      };
    } else {
      throw Exception();
    }
  }

  @override
  Future<Map<String,dynamic>> getData() async {
    // final String parameters = jsonEncode(user.toJson());
    // print("params${parameters}");
    var uri = Uri.http('run.mocky.io','v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3');
    final response = await client
        .post(uri,
        headers: {"Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'}, body: '');
    // client.close();
    if (response.statusCode == 200) {
      //print("RESPO${response.body}respose");
      final data = json.decode(response.body);
      final Map<String,dynamic> dataRes = (data as Map<String,dynamic>);
      //print(dataRes['сategories'].runtimeType);
      List<String> images =[];
      dataRes['image_urls'].forEach((elem){
        //  print(elem.runtimeType);
        images.add(elem.toString());
        // return elem as Map<String,dynamic>;
      });
      final Map<String,dynamic> about = dataRes["about_the_hotel"] as Map<String,dynamic>;
      List<List<String>> peculiarities = [];
      for (var element in (about["peculiarities"] as List)) {
        if(about['peculiarities'].indexOf(element)%2==0){
          peculiarities.add([element,about['peculiarities'][data["about_the_hotel"]['peculiarities'].indexOf(element)+1]]);
        }
      }
      final Map<String,dynamic> newAbout ={
        "description":about["description"] as String,
        "peculiarities":peculiarities
      //  "peculiarities":(about["peculiarities"] as List).map((e) => e as String).toList()
      };
      print({
        "name": dataRes["name"] as String,
        "adress": dataRes["adress"] as String,
        "minimal_price": dataRes["minimal_price"] as int,
        "price_for_it": dataRes["price_for_it"] as String,
        "rating_name": dataRes["rating_name"] as String,
        "about_the_hotel": newAbout,
        "image_urls":images,
        "rating":dataRes["rating"] as int,
        "id":dataRes["id"] as int,
      });
      return {
        "name": dataRes["name"] as String,
        "adress": dataRes["adress"] as String,
        "minimal_price": dataRes["minimal_price"] as int,
        "price_for_it": dataRes["price_for_it"] as String,
        "rating_name": dataRes["rating_name"] as String,
        "about_the_hotel": newAbout,
        "image_urls":images,
        "rating":dataRes["rating"] as int,
        "id":dataRes["id"] as int,
      };

    } else {
      throw Exception();
    }
  }


  /*{
  "rooms": [
  {
  "id": 1,
  "name": "Стандартный номер с видом на бассейн",
  "price": 186600,
  "price_per": "За 7 ночей с перелетом",
  "peculiarities": [
  "Включен только завтрак",
  "Кондиционер"
  ],
  "image_urls": [
  "https://www.atorus.ru/sites/default/files/upload/image/News/56871/%D1%80%D0%B8%D0%BA%D1%81%D0%BE%D1%81%20%D1%81%D0%B8%D0%B3%D0%B5%D0%B9%D1%82.jpg",
  "https://q.bstatic.com/xdata/images/hotel/max1024x768/267647265.jpg?k=c8233ff42c39f9bac99e703900a866dfbad8bcdd6740ba4e594659564e67f191&o=",
  "https://worlds-trip.ru/wp-content/uploads/2022/10/white-hills-resort-5.jpeg"
  ]
  },
  {
  "id": 2,
  "name": "Люкс номер с видом на море",
  "price": 289400,
  "price_per": "За 7 ночей с перелетом",
  "peculiarities": [
  "Все включено",
  "Кондиционер",
  "Собственный бассейн"
  ],
  "image_urls": [
  "https://mmf5angy.twic.pics/ahstatic/www.ahstatic.com/photos/b1j0_roskdc_00_p_1024x768.jpg?ritok=65&twic=v1/cover=800x600",
  "https://www.google.com/search?q=%D0%BD%D0%BE%D0%BC%D0%B5%D1%80+%D0%BB%D1%8E%D0%BA%D1%81+%D0%B2+%D0%BE%D1%82%D0%B5%D0%BB%D0%B8+%D0%B5%D0%B3%D0%B8%D0%BF%D1%82%D0%B0+%D1%81+%D1%81%D0%BE%D0%B1%D1%81%D1%82%D0%B2%D0%B5%D0%BD%D0%BD%D1%8B%D0%BC+%D0%B1%D0%B0%D1%81%D1%81%D0%B5%D0%B9%D0%BD%D0%BE%D0%BC&tbm=isch&ved=2ahUKEwilufKp-4KBAxUfJxAIHR4uAToQ2-cCegQIABAA&oq=%D0%BD%D0%BE%D0%BC%D0%B5%D1%80+%D0%BB%D1%8E%D0%BA%D1%81+%D0%B2+%D0%BE%D1%82%D0%B5%D0%BB%D0%B8+%D0%B5%D0%B3%D0%B8%D0%BF%D1%82%D0%B0+%D1%81+%D1%81%D0%BE%D0%B1%D1%81%D1%82%D0%B2%D0%B5%D0%BD%D0%BD%D1%8B%D0%BC+%D0%B1%D0%B0%D1%81%D1%81%D0%B5%D0%B9%D0%BD%D0%BE%D0%BC&gs_lcp=CgNpbWcQAzoECCMQJ1CqAVi6HGDmHWgAcAB4AIABXIgB3wySAQIyNZgBAKABAaoBC2d3cy13aXotaW1nwAEB&sclient=img&ei=Y3fuZOX7KJ_OwPAPntyE0AM&bih=815&biw=1440#imgrc=Nr2wzh3vuY4jEM&imgdii=zTCXWbFgrQ5HBM",
  "https://tour-find.ru/thumb/2/bsb2EIEFA8nm22MvHqMLlw/r/d/screenshot_3_94.png"
  ]
  }
  ]
  }*/
  @override
  Future<List<Map<String,dynamic>>> getRoomInfo() async {
    var uri = Uri.http('run.mocky.io','v3/f9a38183-6f95-43aa-853a-9c83cbb05ecd');
    final response = await client
        .post(uri,
        headers: {"Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'}, body: '');
    // client.close();
    if (response.statusCode == 200) {
      //print("RESPO${response.body}respose");
      final data = json.decode(response.body);
      /* ((data as Map<String,dynamic>)["rooms"] as List).map((el){
        final Map<String,dynamic> elem = el as Map<String,dynamic>;
        return {
          "id":elem["id"] as int,
          "name": elem["name"] as String,
          "price": elem["price"] as int,
          "price_per":elem["price_per"] as String,
          "peculiarities": (elem["peculiarities"] as List).map((e) => e as String).toList(),
          "image_urls":(elem["image_urls"] as List).map((e) => e as String).toList()
        };
      }).toList();*/
      List<Map<String,dynamic>> res = ((data as Map<String,dynamic>)["rooms"] as List).map((el){
    final Map<String,dynamic> elem = el as Map<String,dynamic>;
    return {
    "id":elem["id"] as int,
    "name": elem["name"] as String,
    "price": elem["price"] as int,
    "price_per":elem["price_per"] as String,
    "peculiarities": (elem["peculiarities"] as List).map((e) => e as String).toList(),
    "image_urls":(elem["image_urls"] as List).map((e) => e as String).toList()
    };
    }).toList();
    return [res[0],res[0]];

    } else {
      throw Exception();
    }
  }



}
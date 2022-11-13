import 'dart:convert';

import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

// HAVE TO PASS VALUE OF USER CITY TO THIS PAGE.
class WeatherInfoPage extends StatefulWidget {
  String userCity;
  String tz = '';
  String bckg = '';
  WeatherInfoPage({required this.userCity});


  @override
  State<WeatherInfoPage> createState() => _WeatherInfoPageState();
}

class _WeatherInfoPageState extends State<WeatherInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(                        // future Builder is called as soon as the program begins. to prevent that, variable called isPressed, only when button pressed, it'll run future builder
          future : apicall(widget.userCity),
          builder: (context,snapshot){
            if (snapshot.hasData){
              return Container(
                child: Stack(
                  children: [
                  Image.asset('images/pleasantBckg.webp',         // first thing in stack is this pic made to fill bckg size.
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,),
                Container(
                  decoration: BoxDecoration(color: Colors.black38),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Container(
                      child: Column(                                               // second in stack is this column which contains the text
                      crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 50),            // this is giving space between the city name and the top of the screen.
                            Text('${widget.userCity}'.toUpperCase() + ", " +snapshot.data['country'],
                                  style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                  color: Colors.white)
                              ,),
                            // Text('date and time', style: GoogleFonts.lato(
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 25,
                            //     color: Colors.white)
                            // ),
                        Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 40),                 // WHAT IS MARGIN FOR A CONTAINER
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network("http://openweathermap.org/img/w/"+snapshot.data['icon'].toString()+".png",
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.contain,),
                                    Text(snapshot.data['temperature'].toString() + " °C",
                                    style: GoogleFonts.lato(fontSize: 100, color: Colors.white),),
                                    Text('Minimum : ' + snapshot.data['min'].toString() + " °C",
                                    style: GoogleFonts.lato(fontSize: 30, color: Colors.white),),
                                    Text('Maximum : ' + snapshot.data['max'].toString() + " °C",
                                    style: GoogleFonts.lato(fontSize: 30, color: Colors.white)),
                                    Text("Humidity : " + snapshot.data['humidity'].toString() + " gm^-3",
                                    style: GoogleFonts.lato(fontSize: 30, color: Colors.white),),
                                    Text('Weather : ' + snapshot.data['desc'].toString(),
                                    style: GoogleFonts.lato(fontSize: 30, color: Colors.white),),
                                    // String tz = tzmap.latLngToTimezoneString(snapshot.data['lat'], snapshot.data['lon']);

                                  ],
                                ),
                              ),


              ]),
              ]),
                      )]
            )
            )
            ]),
            );


            }
            else{
              //return CircularProgressIndicator();
              return Container(
                height: 2000,
                width: 2000,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image : AssetImage('.idea/images/pleasantBckg.webp')
                  )
                ),
                child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Text("Oops, could not find this city!",
                       style: GoogleFonts.lato(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 50),
            ),
              ]
                )
              );



            }
          }
    ),
    );
    }
}
// should pass the city that the user has entered in this http query.
// reason why we put async is because this function, apicall() is retrieving data from the web, which might take some time,
// thus making it asynchronous. So, it's response will also have a waiting time / await keyword.
Future apicall(String cityVal) async{
  final url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q="+cityVal+"&appid=faf469c4a3c46c7bf539017ab3325e0c");
  final response = await http.get(url);         // final means the variable response does not change during the runtime of the code(during a particular request)
  print (response.body);      // this body is of type string
  final json = jsonDecode(response.body);
  print (json);
  final output = {
    'description' : json["weather"][0]['description'],
    'temperature' : ((json["main"]['temp']) - 273.15).round(),    // converting from kelvin to celsius.
    'humidity': json['main']['humidity'],
    'icon' : json['weather'][0]['icon'],
    'desc' : json['weather'][0]['description'],
    'lat' : json['coord']['lat'],
    'lon' : json['coord']['lon'],
    'country' : json['sys']['country'],
    'min' : ((json['main']['temp_min']) - 273.15).round(),
    'max' : ((json['main']['temp_max']) - 273.15).round(),

  };

  return output;
}


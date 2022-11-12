import 'package:flutter/material.dart';
import 'package:untitled/WeatherInfoPage.dart';
import 'package:google_fonts/google_fonts.dart';

// SHOULD FUTURE BUILDER FUNCTION BE PUT IN THE NEXT PAGE OR IS IT EASIER TO PASS VALUES BETWEEN SCREENS??


void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
const MyApp({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
  return MaterialApp(
      home : MyHomePage()
  );
}
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  final _textController = TextEditingController();      // textController is the widget that will have access to input in TextField
  String userCity = '';
  bool isPressed = false;
  String bckgImg = '.idea/images/pleasantBckg.webp';
  //double temp = snapshot.data['temperature'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,

      ),
      body : Container(
        decoration : BoxDecoration(
          image : DecorationImage(
            image : AssetImage(bckgImg),          // always do right click of the image and copy content root. s
            fit: BoxFit.cover,
          )
        ),
        child: Row(
          children: [
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 300,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2
                                ),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            border: OutlineInputBorder(),
                            hintText: "Enter the city",
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                            ),
                            suffixIcon:
                            IconButton(onPressed: (){
                              _textController.clear();                     // Controller has clear() method.
                            }, icon: Icon(Icons.clear))
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WeatherInfoPage(userCity: _textController.text)));
              },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    onPrimary: Colors.black,
                    textStyle: GoogleFonts.lato()

                  ),

                // setState(() {
                //   userCity = _textController.text;
                //   isPressed = !isPressed;
                // });

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Submit"),
                  )
              ),

              // isPressed?FutureBuilder(                        // future Builder is called as soon as the program begins. to prevent that, variable called isPressed, only when button pressed, it'll run future builder
              //     future : apicall(userCity),
              //     builder: (context,snapshot){
              //       if (snapshot.hasData){
              //         double temp = snapshot.data['temperature'];
              //         if (temp >= 25){
              //           bckgImg = '.idea/images/desertBckg.jpg';
              //           String weather = 'That\'s scorching!';
              //         }
              //         // else if ((25 <= temp) & (temp <= 30)){
              //         //   bckgImg = '.idea/images/pleasantBckg.webp';
              //         //   String weather = 'The perfect time for a stroll!';
              //         // }
              //         // else if (temp < 25) {
              //         //   bckgImg = '.idea/images/chillyBckg.jpg';
              //         //   String weather = 'That\'s chilly!';
              //         // }
              //         // else {
              //         //   bckgImg = '.idea/images/mountains_bkg.jpg';
              //         // }
              //         return Column(
              //             children : [
              //               const Padding(
              //                 padding: EdgeInsets.all(5.0),
              //                 child: SizedBox(                    // to set dimensions of the TextField
              //                   width : 300,
              //                   height : 50,
              //                   // child: TextField(
              //                   //   decoration: InputDecoration(
              //                   //     hintText: "Enter the city",
              //                   //     border: OutlineInputBorder()
              //                   //   ),
              //                   // ),
              //                 ),
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(12.0),
              //                 child: Text(snapshot.data['description'].toString()),
              //               ),
              //               Text(snapshot.data['temperature'].toString())
              //             ]
              //         );
              //
              //       }
              //       else{
              //         return CircularProgressIndicator();
              //       }
              //     }):Text("")
            ],
          ),

      ]),
    ));
  }
}
// should pass the city that the user has entered in this http query.
// reason why we put async is because this function, apicall() is retrieving data from the web, which might take some time,
// thus making it asynchronous. So, it's response will also have a waiting time / await keyword.
// Future apicall(String cityVal) async{
//   // final url = Uri(host : "https://api.openweathermap.org",
//   //     path : "/data/2.5/weather",
//   //     queryParameters : {
//   //       //'q' : '${userCity}',
//   //       'q' : cityVal,
//   //       'appid' : "faf469c4a3c46c7bf539017ab3325e0c"
//   //     });
//   // print(url);
//   // print("hI");
//   final url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q="+cityVal+"&appid=faf469c4a3c46c7bf539017ab3325e0c");
//   final response = await http.get(url);         // final means the variable response does not change during the runtime of the code(during a particular request)
//   print (response.body);      // this body is of type string
//   final json = jsonDecode(response.body);
//   print (json["weather"][0]['description']);
//   final output = {
//     'description' : json["weather"][0]['description'],
//     'temperature' : ((json["main"]['temp']) - 273.15).round()         // converting from kelvin to celsius.
//   };
//   print (((json["main"]['temp']) - 273.15).round());
//   return output;
//   }


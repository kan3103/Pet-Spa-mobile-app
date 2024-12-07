import 'package:flutter/material.dart';
import 'package:frontend/class_model/models/Staff.dart';
import 'package:frontend/homepage/home_screen.dart';
import 'package:frontend/homepage/customer_homepage.dart';
import 'package:frontend/homepage/manager_homepage.dart';
import 'package:frontend/service_screen/allService.dart';
import 'package:frontend/service_screen/managerService.dart';
import 'package:frontend/service_screen/newOrder_screen.dart';
import 'package:frontend/service_screen/reService/maOrder.dart';
import 'package:frontend/service_screen/userService.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/service_screen/staffService/staffService.dart';
import 'package:frontend/service_screen/staffService/staffAllService.dart';

/*
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyServiceScreen(),
    );
  }
}
*/
class MyServiceScreen extends StatefulWidget {
  @override
  _MyServiceScreenState createState() => _MyServiceScreenState();
}

class _MyServiceScreenState extends State<MyServiceScreen> {
  
  String accountType = 'customer';
  

  void getType() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
       accountType = prefs.getString('account')!;
    });
   
    //print(accountType);
  }
  
  @override
  void initState() {
    // TODO: implement initState
    getType();
    super.initState();
  }

  var selectedIndex = 0; 
  // void _navigateToNewOrder() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => NewOrderScreen()),
  //   ).then((newPet) {
  //     if (newPet != null) {
  //       setState(() {
  //         pets.add(newPet);
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = (accountType == 'customer' ? userService() : (accountType == 'manager' ? OrderManager() : (accountType == 'staff' ? staffService() : userService())));
    case 1:
        page = (accountType == 'customer'? Allservice(): (accountType == 'manager' ? reServicePage() : (accountType == 'staff' ? StaffAllService() : userService()) ) );
        //myBlogs(myprofile: widget.myprofile, isProfile: false);
    default:
    throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
        'My Service',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: "Popins",
        ),
      ),
        backgroundColor: Colors.white,
        centerTitle: true,
        
        leading: SizedBox(width: 0,),
        
        /*IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
           /* 
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  customerHomePage()),
            );

            */
          },
        ),*/
        actions:
        [
          TextButton(
            onPressed: () {},
            child: Text(
              'History',
              style: TextStyle(color: Color(0xFF616165)),
            ),
          ),
        ],
      ),
      body: 
      Column(
        children: [
          SafeArea(
                    child:
                    NavigationBarTheme(
                       data: NavigationBarThemeData(
                        indicatorColor: Colors.black,
                        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
                            (Set<WidgetState> states) {
                              if (states.contains(WidgetState.selected)) {
                                return const TextStyle(
                                  color: Colors.black, 
                                  fontWeight: FontWeight.bold,
                                );
                              }
                              return const TextStyle(
                                color: Colors.black, 
                              );
                            },
                          ),
                        ),
                      child: NavigationBar(
                        
                        backgroundColor: Color.fromARGB(255, 255, 250, 250),
                        height: 70,
                        destinations: const [
                            //Text('Home'),
                           NavigationDestination(
                            icon: Icon(Icons.home, ), 
                              label:  'Your Service',
                              
                            ),
                            NavigationDestination(
                              icon: Icon(Icons.search), 
                              label: 'All Service',
                            ),
                        ],
                        selectedIndex: selectedIndex,
                            onDestinationSelected: (value) {
                              setState(() {
                                  selectedIndex = value;
                                }
                              );
                            },
                            indicatorColor: Color(0xFFF49FA4),
                        ),
                    ),
                  ),
          Expanded(
                    child: Container(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: page,
                    ),
            ),
            //page,
        ],
      ),
              
      
      //userService()
      
    );
  }
}
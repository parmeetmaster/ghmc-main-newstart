import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:ghmc/provider/add_gvp_bep_provider/addGvpBepProvider.dart';
import 'package:ghmc/provider/add_data/add_data_provider.dart';
import 'package:ghmc/provider/add_parking/add_parking.dart';
import 'package:ghmc/provider/add_resident/add_resident_provider.dart';
import 'package:ghmc/provider/add_vehicle/add_vehicle.dart';
import 'package:ghmc/provider/community_hall/community_hall.dart';
import 'package:ghmc/provider/complex_building/complex_building.dart';
import 'package:ghmc/provider/create_street_vendor/create_street_vendor.dart';
import 'package:ghmc/provider/culvert/culvert_provider.dart';
import 'package:ghmc/provider/dashboard_provider/dash_board_provider.dart';
import 'package:ghmc/provider/location_provider/location_provider.dart';
import 'package:ghmc/provider/login_provider/login_provider.dart';
import 'package:ghmc/provider/maps_provider/maps_provider.dart';
import 'package:ghmc/provider/open_place/open_place.dart';
import 'package:ghmc/provider/splash_provider/splash_provider.dart';
import 'package:ghmc/provider/toilet/toilet.dart';
import 'package:ghmc/provider/userHistory_provider/logHistory_provider.dart';
import 'package:ghmc/screens/login/ghmc_loginpage.dart';
import 'package:ghmc/splashScreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:ghmc/util/utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'globals/constants.dart';
import 'provider/support/support.dart';

import 'dart:async';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _flutterLocalNotificationsPlugin(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await HiveUtils.initalised();

  FirebaseMessaging.onBackgroundMessage(_flutterLocalNotificationsPlugin);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );

  FirebaseMessaging.instance.getToken().then((value) {
    fcmToken = value;
    print('FCM token for FirebaseMessaging $fcmToken');
    // token!.printwtf; // print fcm token
  });

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
    
        ChangeNotifierProvider(create: (ctx) => LoginProvider()),
        ChangeNotifierProvider(create: (ctx) => DashBoardProvider()),
        ChangeNotifierProvider(create: (ctx) => AddVehicleProvider()),
        ChangeNotifierProvider(create: (ctx) => AddDataProvider()),
        ChangeNotifierProvider(create: (ctx) => LocationProvider()),
        ChangeNotifierProvider(create: (ctx) => GvpBepProvider()),
        ChangeNotifierProvider(create: (ctx) => SupportProvider()),
        ChangeNotifierProvider(create: (ctx) => SplashProvider()),
        ChangeNotifierProvider(create: (ctx) => CulvertProvider()),
        ChangeNotifierProvider(create: (ctx) => LogHistoryProvider()),
        ChangeNotifierProvider(create: (ctx) => MapLocationProvider()),
        ChangeNotifierProvider(create: (ctx) => ComplexBuildingProvider()),
        ChangeNotifierProvider(create: (ctx) => CommunityHallProvider()),
        ChangeNotifierProvider(create: (ctx) => AddResidentProvider()),
        ChangeNotifierProvider(create: (ctx) => CreateStreetVendorProvider()),
        ChangeNotifierProvider(create: (ctx) => OpenPlaceProvider()),
        ChangeNotifierProvider(create: (ctx) => AddParkingProvider()),
        ChangeNotifierProvider(create: (ctx) => ToiletProvider()),
      ],
      child: Phoenix(child: MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: android.smallIcon,
                playSound: true,
                // other properties...
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp event will published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('${notification.title}'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${notification.body}'),
                ],
              ),
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    HiveUtils utils = new HiveUtils();
    // utils.addRecord(DownloadModel(id: "14",download_link: "www.google.com",download_path: "storage", file_type: 'mp4', file_name: 'dad.com',));
    utils.getRecordsById("14");
    return GetMaterialApp(
      /*  theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme,
        )
      ),*/
      debugShowCheckedModeBanner: false,
      title: 'GHMC',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/signIn': (context) => LoginPage(),
      },
    );
  }
}
// todo working start from owner type test pending

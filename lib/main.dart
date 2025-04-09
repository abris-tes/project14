import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

/// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message: ${message.messageId}');
}

/// Global list to store notification history
List<Map<String, String>> notificationHistory = [];

/// Create a global FlutterLocalNotificationsPlugin instance
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

/// Stream to handle notification taps
final StreamController<String?> selectNotificationStream =
StreamController<String?>.broadcast();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await initializeLocalNotifications();
  runApp(MyApp());
}

/// Initialize local notifications with updated callbacks
Future<void> initializeLocalNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsIOS =
  DarwinInitializationSettings();
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      selectNotificationStream.add(response.payload);
    },
  );
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Firebase Messaging',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Firebase Messaging'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String? title;

  MyHomePage({Key? key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FirebaseMessaging messaging;

  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic("messaging");

    // Retrieve FCM token for testing purposes
    messaging.getToken().then((value) {
      print("FCM Token: $value");
    });

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      _handleMessage(event);
    });

    // Handle notification taps
    selectNotificationStream.stream.listen((String? payload) {
      if (payload != null) {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => NotificationDetailsScreen(payload: payload),
          ),
        );
      }
    });

    // Handle notification tap when the app is brought to the foreground
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => NotificationDetailsScreen(
            payload: message.data['payload'],
          ),
        ),
      );
    });
  }

  void _handleMessage(RemoteMessage event) {
    String notificationType = event.data['type'] ?? 'regular';
    String notificationBody = event.notification?.body ?? "No body";
    String title = event.notification?.title ?? "Notification";

    // Store notification in history
    notificationHistory.add({
      'title': title,
      'body': notificationBody,
      'type': notificationType,
    });

    // Define channel details based on notification type
    AndroidNotificationDetails androidDetails;
    if (notificationType == 'important') {
      androidDetails = AndroidNotificationDetails(
        'important_channel',
        'Important Notifications',
        channelDescription:
        'Channel for important notifications with custom sound and vibration',
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('notification_sound'),
        enableVibration: true,
        vibrationPattern: Int64List.fromList([0, 1000, 500, 2000]),
      );
    } else {
      androidDetails = AndroidNotificationDetails(
        'regular_channel',
        'Regular Notifications',
        channelDescription: 'Channel for regular notifications',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
      );
    }

    NotificationDetails platformDetails =
    NotificationDetails(android: androidDetails);

    // Show local notification
    flutterLocalNotificationsPlugin.show(
      0,
      "$title - ${notificationType.toUpperCase()}",
      notificationBody,
      platformDetails,
      payload: "$notificationType|$notificationBody",
    );

    // Display an in-app dialog with action buttons
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("New ${notificationType.toUpperCase()} Notification"),
          content: Text(notificationBody),
          actions: [
            TextButton(
              child: Text("View Details"),
              onPressed: () {
                Navigator.of(context).pop();
                navigatorKey.currentState?.push(
                  MaterialPageRoute(
                    builder: (context) => NotificationDetailsScreen(
                      payload: "$notificationType|$notificationBody",
                    ),
                  ),
                );
              },
            ),
            TextButton(
              child: Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationHistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(child: Text("Messaging Tutorial")),
    );
  }
}

/// Screen to display notification details
class NotificationDetailsScreen extends StatelessWidget {
  final String payload;

  NotificationDetailsScreen({required this.payload});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Details"),
      ),
      body: Center(
        child: Text("Payload: $payload"),
      ),
    );
  }
}

/// Screen to display the history of notifications received
class NotificationHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("
            ::contentReference[oaicite:3]{index=3}


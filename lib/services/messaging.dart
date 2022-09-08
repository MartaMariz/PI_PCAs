import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:smile/models/notification.dart';
import 'package:smile/services/notification.dart';

class MessagingService {
  final NotificationService _notificationService;

  MessagingService(this._notificationService);

  Future<void> initialize() async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      badge: true,
    );
    _onMessage();
  }

  _onMessage(){
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null){
        _notificationService.showNotification(
          CustomNotification(
              id: android.hashCode,
              title: notification.title,
              body: notification.body,
              payload: '')
        );
      }
    });
  }

}
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pi_pcas/models/notification.dart';
import 'package:pi_pcas/services/notification.dart';

class MessagingService {
  final NotificationService _notificationService;

  MessagingService(this._notificationService);

  Future<void> initialize() async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      badge: true,
    );
    getDeviceFirebaseToken();
    _onMessage();
    _onMessageOpenedApp();
  }

  getDeviceFirebaseToken() async{
    final token = await FirebaseMessaging.instance.getToken();
    print('TOKEN: $token');
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

  _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMessage);
  }

  _goToPageAfterMessage(message){
    //Navigator.push
  }

}
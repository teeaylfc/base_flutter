import 'package:oev_timesheet/src/common/constants/constants.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../globals.dart';

class NotificationService {
  static final NotificationService _notificationUtils =
      new NotificationService._();

  factory NotificationService.getInstance() => _notificationUtils;

  NotificationService._();

  initNotification() {}
}

sendNotification() async {
  var status = await OneSignal.shared.getPermissionSubscriptionState();

  var playerId = status.subscriptionStatus.userId;
  await OneSignal.shared.postNotification(OSCreateNotification(
      playerIds: [playerId],
      content: "You have some booking",
      heading: "Test Notification",
      buttons: [
        OSActionButton(text: "test1", id: "id1"),
        OSActionButton(text: "test2", id: "id2")
      ]));
}

getPlayerID() async {
  var status = await OneSignal.shared.getPermissionSubscriptionState();
  return status.subscriptionStatus.userId;
}

addOneSignalUser(userId) {
  OneSignal.shared.sendTag("user_id", userId);
}

addOneSignalTerminalId(terminalId) {
  OneSignal.shared.sendTag("terminal_id", terminalId);
}

removeOneSignalUser() {
  OneSignal.shared.deleteTag("user_id");
  OneSignal.shared.deleteTag("merchant_id");
  OneSignal.shared.deleteTag("terminal_id");
  OneSignal.shared.deleteTag("type");
  OneSignal.shared.setSubscription(false);
}

addOneSignalMerchatID(id) {
  OneSignal.shared.sendTag("merchant_id", id);
}

addOneSignalType(type) {
  OneSignal.shared.sendTag("type", type);
  OneSignal.shared.setSubscription(true);
}

// NotificationService notificationService;
removeOneSignalMerchatID() {}

import Foundation
import UserNotifications

func currentNotificationPermitStatus(closure: @escaping (UNNotificationSettings) -> Void) {
    UNUserNotificationCenter
        .current()
        .getNotificationSettings(completionHandler: closure)
}

func requestAuthorizationIfNotPermit(settings: UNNotificationSettings) {
    switch settings.authorizationStatus {
    case .notDetermined:
        requestAuthorization()
    case .denied, .authorized, .provisional, .ephemeral:
        return
    @unknown default:
        fatalError("unexpected pattern settings.authorizationStatus: \(settings.authorizationStatus)")
    }
}

func requestAuthorization() {
    UNUserNotificationCenter.current().requestAuthorization(
        options: [.alert, .badge, .sound],
        completionHandler: { granted, error in
            print(granted, String(describing: error))
        })
}

func fire() {
    let keyword = "💩"
    let identifier = keyword

    let content = UNMutableNotificationContent()
    content.title = "\(keyword)"
    content.body = Array(repeating: keyword, count: 40).joined()

    (0...23).forEach { (hour) in
        let dateComponents = DateComponents(hour: hour, minute: 0, second: 0)
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: calendarTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}

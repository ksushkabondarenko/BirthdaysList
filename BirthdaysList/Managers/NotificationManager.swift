import Foundation
import UserNotifications

struct NotificationManager {
    func save(name: String) {
        let content = UNMutableNotificationContent()
        content.body = "Сегодня \(name) отмечает день рождения!"
        content.sound = .default
        
        var dateComponent = Calendar.current.dateComponents([.month, .day], from: Date())
        dateComponent.hour = 20
        dateComponent.minute = 03
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        let request = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
}

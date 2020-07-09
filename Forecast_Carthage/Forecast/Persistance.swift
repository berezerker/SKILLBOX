import Foundation

import RealmSwift

class Task: Object{
    @objc dynamic var task: String = ""
    @objc dynamic var id: Int = 0
}

class PersistanceTask{
    static let shared = PersistanceTask()
    
    private let realm = try! Realm()
    
    func allTasks() -> Results<Task>{
        let allTasks = realm.objects(Task.self)
        return allTasks
    }
    func addTask(task: String, id: Int){
        let new = Task()
        new.task = task
        new.id = id
        try! realm.write(){
        realm.add(new)
        }
    }
    func deleteTask(_ object: Task){
        try! realm.write{
            if let objToDelete = realm.objects(Task.self).filter("task = '\(object.task)' AND id = \(object.id) ").first{
                realm.delete(objToDelete)
            }
        }
    }
    
    func updateData(){
         var i = 1
        let objects = realm.objects(Task.self)
        try! realm.write{
        for v in objects{
            v.id = i
            i += 1
        }
        }
    }
}

class PersistanceUser{
    static let shared = PersistanceUser()
    
    private let kUserName = "Persistance.kUserName"
    private let kUserSurname = "Persistance.kPassword"
    
    var userName: String?{
        set {UserDefaults.standard.set(newValue, forKey: kUserName)}
        get {return UserDefaults.standard.string(forKey: kUserName)}
    }
    var userSurname: String?{
        set {UserDefaults.standard.set(newValue, forKey: kUserSurname)}
        get {return UserDefaults.standard.string(forKey: kUserSurname)}
    }
    
}

class PersistanceForecast{
    static let shared = PersistanceForecast()
    private let kCurrent = "Persistance.kCurrent"
    private let kDaily = "Persistance.kDaily"
    
    let defaults = UserDefaults.standard
    
    var current: Current?{
        set {
            let value = try? JSONEncoder().encode(newValue)
            defaults.set(value, forKey: kCurrent)
        }
        get {
            if let data = defaults.object(forKey: kCurrent) as? Data{
            let decoded = try? JSONDecoder().decode(Current.self, from: data)
            return decoded
            }else {return nil}
        }
    }
    var daily: dailyForecast?{
        set {
            let value = try? JSONEncoder().encode(newValue)
            defaults.set(value, forKey: kDaily)
        }
        get {
            if let data = defaults.object(forKey: kDaily) as? Data{
            let decoded = try? JSONDecoder().decode(dailyForecast.self, from: data)
            return decoded
            }else {return nil}
        }
    }
}

//
//  DataController.swift
//  UsersApp
//
//  Created by Kesh Gurung on 10/05/2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    
    static let shared = DataController()
    let container = NSPersistentContainer(name: "UsersApp")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully!!")
        } catch {
            // Handle errors in our database
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func deleteUsers() {
        let context = self.container.viewContext
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            let results = try context.fetch(request)
            for result in results {
                context.delete(result)
            }
        } catch {
            print(error)
        }
        self.save(context: context)
    }
    
    func fetchUsers() -> [UserEntity]? {
        let context = self.container.viewContext
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()

        do {
            let results = try context.fetch(request)
            return results
        } catch {
            print(error)
        }
        return nil
    }
    
    func addUsers(users: [User]) {
        users.forEach {
            let userEntity = UserEntity(context: container.viewContext)
            userEntity.id = Int16($0.id)
            userEntity.name = $0.name
            userEntity.email = $0.email
            userEntity.company = $0.company
            userEntity.twitterUsername = $0.twitterUsername
            userEntity.avatarUrl = $0.avatarUrl
        }
        save(context: container.viewContext)
    }
}

//
//  Store.swift
//  HP Trivia
//
//  Created by Admin on 2023-07-26.
//

import Foundation
import StoreKit
@MainActor

enum BookStatus: Codable{
    case active
    case inactive
    case locked
}

class Store:ObservableObject{
    @Published  var  books: [BookStatus] = [.active, .active, .inactive, .inactive, .locked, .locked, .locked]
    @Published var products: [Product] = []
    @Published var purchasedIDs = Set<String>() // because everything inside is unique
    
    private var productIDs = ["hp5","hp6","hp7"]
    private var updates: Task<Void,Never>? = nil
    
    private let savePath = FileManager.documentsdirectiory.appending(path: "SavedBookStatus")
    
    init(){
        updates = watchForUpdates()
    }
    func loadProducts()async {
        do{
            products = try await Product.products(for: productIDs)
        }catch{
            print("Could not fetch products: \(error)")
        }
    }
    
    func purchase(_ product: Product) async{
        do{
            let result = try await product.purchase()
            
            switch result{
                // Purchase successful, but verify receipt for valid purchase
            case .success(let verificationResult):
                switch verificationResult{
                case .unverified(let signedType, let verificationError):
                    print("Error on \(signedType) : \(verificationError)")
                case .verified(let signedType):
                    purchasedIDs.insert(signedType.productID)
                }
                // User canceled or parent disapproved child's purchase
            case .userCancelled:
                break
                // Waiting for approval from user or parent
            case .pending:
                break
            @unknown default:
                break
            }
        }catch{
            print("Could not purchase product: \(error)")
        }
    }
    
    func saveStatus(){
        do{
            let data = try JSONEncoder().encode(books)
            try data.write(to: savePath)
        }catch{
            print("Unable to save data : \(error)")
        }
    }
    
    func loadStatus(){
        do{
            let data = try Data(contentsOf: savePath)
            books = try JSONDecoder().decode([BookStatus].self, from:data)
            
        }catch{
            print("Could not load book status")
        }
    }
    
    private func checkPurchased() async{
        for product in products{
            guard let state = await product.currentEntitlement else {return}
            
            switch state{
            case .unverified(let signedType, let verificationError):
                print("Error on \(signedType) : \(verificationError)")
            case .verified(let signedType):
                if signedType.revocationDate == nil{
                    purchasedIDs.insert(signedType.productID)
                }else{
                    purchasedIDs.remove(signedType.productID)
                }
            }
        }
    }
    
    private func watchForUpdates() ->Task<Void,Never>{
        Task(priority:.background){
            for await _ in Transaction.updates{
                await checkPurchased()
            }
        }
    }
    
}

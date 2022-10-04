//
//  ItemModel.swift
//  Task
//
//  Created by Vika Granadzer on 03.10.2022.
//

import Foundation

class ItemModel: Identifiable, ObservableObject{
    init(){
        self.Name = "None";
        self.Price = 0
        self.CountryOfOrigin = "None"
        self.DateOfPackaging = "None"
        self.Description = "None"
        self.ttype = -1
    }
    func setBaseInfo(name: String, type: Int){
        Name = name
        ttype = type
    }
    var Name: String
    var Price: Float
    var CountryOfOrigin: String
    var DateOfPackaging: String
    var Description: String
    var ttype: Int
}

class Book: ItemModel{
    override init(){
        self.NumberOfPages = 0
        self.PublishingHouse = "None"
        self.Authors = "None"
        self.type = 2
    }
    var NumberOfPages: Int
    var PublishingHouse: String
    var Authors: String
    var type: Int
    func setBook(price: String, country: String, dateP: String, description: String, number: String, house: String, authors: String){
        if (price != ""){
            let priceConv = (price as NSString).floatValue
            Price = priceConv
        }
        if (country != ""){
            CountryOfOrigin = country
        }
        if (dateP != ""){
            DateOfPackaging = dateP
        }
        if (description != ""){
            Description = description
        }
        if (number != ""){
            let numberConv = (number as NSString).integerValue
            NumberOfPages = numberConv
        }
        if (house != ""){
            PublishingHouse = house
        }
        if (authors != ""){
            Authors = authors
        }
    }
}

class Product: ItemModel{
    override init(){
        self.ExpirationDate = "None"
        self.Amount = 0
        self.Unit = "None"
        self.type = 1
    }
    func returnName() -> String{
        return Name;
    }
    var ExpirationDate: String
    var Amount: Int
    var Unit: String
    var type: Int
    func setProduct(price: String, country: String, dateP: String, description: String, dateE: String, amount: String, unit: String){
        if (price != ""){
            let priceConv = (price as NSString).floatValue
            Price = priceConv
        }
        if (country != ""){
            CountryOfOrigin = country
        }
        if (dateP != ""){
            DateOfPackaging = dateP
        }
        if (description != ""){
            Description = description
        }
        if (dateE != ""){
            ExpirationDate =  dateE
        }
        if (amount != ""){
            let amountConv = (amount as NSString).integerValue
            Amount = amountConv
        }
        if (unit != ""){
            Unit =  unit
        }
    }
}

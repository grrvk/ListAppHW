//
//  ProductView.swift
//  Task
//
//  Created by Vika Granadzer on 03.10.2022.
//

import SwiftUI

struct ProductView: View {
    var product: Product
    @Environment(\.presentationMode) var presentationMode
    @State var showingAlert = false
    @State var textFieldtextPrice: String = ""
    @State var textFieldtextCountryOfOrigin: String = ""
    @State var textFieldtextDateOfPackaging: String = ""
    @State var textFieldtextDescription: String = ""
    @State var textFieldtextExpirationDate: String = ""
    @State var textFieldtextAmount: String = ""
    @State var textFieldtextUnit: String = ""
    var body: some View {
        VStack{
            Form {
                Section(header: Text("Price"), content: {
                    TextField(product.Price.description, text: $textFieldtextPrice)
                        .padding(.horizontal)
                        .frame(height: 45)
                        .background(Color(#colorLiteral(red: 0.1137, green: 0.0902, blue: 0.1294, alpha: 0.1)))
                        .cornerRadius(10)
                })
                Section(header: Text("Country of origin: "), content: {
                    TextField(product.CountryOfOrigin, text: $textFieldtextCountryOfOrigin)
                        .padding(.horizontal)
                        .frame(height: 45)
                        .background(Color(#colorLiteral(red: 0.1137, green: 0.0902, blue: 0.1294, alpha: 0.1)))
                        .cornerRadius(10)
                })
                Section(header: Text("Date of packaging:(dd.mm.yyyy)"), content: {
                    TextField(product.DateOfPackaging, text: $textFieldtextDateOfPackaging)
                        .padding(.horizontal)
                        .frame(height: 45)
                        .background(Color(#colorLiteral(red: 0.1137, green: 0.0902, blue: 0.1294, alpha: 0.1)))
                        .cornerRadius(10)
                })
                Section(header: Text("Description:"), content: {
                    TextField(product.Description, text: $textFieldtextDescription)
                        .padding(.horizontal)
                        .frame(height: 45)
                        .background(Color(#colorLiteral(red: 0.1137, green: 0.0902, blue: 0.1294, alpha: 0.1)))
                        .cornerRadius(10)
                })
                Section(header: Text("Expiration date:(dd.mm.yyyy)"), content: {
                    TextField(product.ExpirationDate, text: $textFieldtextExpirationDate)
                        .padding(.horizontal)
                        .frame(height: 45)
                        .background(Color(#colorLiteral(red: 0.1137, green: 0.0902, blue: 0.1294, alpha: 0.1)))
                        .cornerRadius(10)
                })
                Section(header: Text("Amount:"), content: {
                    TextField(product.Amount.description, text: $textFieldtextAmount)
                        .padding(.horizontal)
                        .frame(height: 45)
                        .background(Color(#colorLiteral(red: 0.1137, green: 0.0902, blue: 0.1294, alpha: 0.1)))
                        .cornerRadius(10)
                })
                Section(header: Text("Unit:"), content: {
                    TextField(product.Unit, text: $textFieldtextUnit)
                        .padding(.horizontal)
                        .frame(height: 45)
                        .background(Color(#colorLiteral(red: 0.1137, green: 0.0902, blue: 0.1294, alpha: 0.1)))
                        .cornerRadius(10)
                })
                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Invalid input"), message: Text("Values Amount and Price must be numerical and positive\n Date must be written like dd.mm.yyyy"), dismissButton: .default(Text("Got it!")))
                }
            }
        }
    }
    func saveButtonPressed(){
        do{
            try checkData()
            product.setProduct(price: textFieldtextPrice, country: textFieldtextCountryOfOrigin, dateP: textFieldtextDateOfPackaging, description: textFieldtextDescription, dateE: textFieldtextExpirationDate, amount: textFieldtextAmount, unit: textFieldtextUnit)
            presentationMode.wrappedValue.dismiss()
        } catch productError.negativeValue{
            showingAlert = true
        } catch is NSError{
            showingAlert = true
        }
    }
    enum productError: Error {
        case negativeValue
    }
    func checkData() throws{
        var nonNegativeCheck = false
        if (textFieldtextPrice != ""){
            let priceConv = (textFieldtextPrice as NSString).floatValue
            if (priceConv<=0){
                nonNegativeCheck = true
            }
        }
        if (textFieldtextAmount != ""){
            let amountConv = (textFieldtextAmount as NSString).floatValue
            if (amountConv<=0){
                nonNegativeCheck = true
            }
        }
        if (textFieldtextDateOfPackaging != ""){
            let num = textFieldtextDateOfPackaging.count
            var counter = 0
            if (num != 10){
                nonNegativeCheck = true
            }
            else{
                for character in textFieldtextDateOfPackaging{
                    if (counter == 2){
                        if (character != "."){
                            nonNegativeCheck = true
                        }
                    }
                    else if (counter == 5){
                        if (character != "."){
                            nonNegativeCheck = true
                        }
                    }
                    else{
                        if (character < "0" || character > "9"){
                            nonNegativeCheck = true
                        }
                    }
                    counter = counter + 1
                }
            }
        }
        if (textFieldtextExpirationDate != ""){
            let num = textFieldtextExpirationDate.count
            var counter = 0
            if (num != 10){
                nonNegativeCheck = true
            }
            else{
                for character in textFieldtextExpirationDate{
                    if (counter == 2){
                        if (character != "."){
                            nonNegativeCheck = true
                        }
                    }
                    else if (counter == 5){
                        if (character != "."){
                            nonNegativeCheck = true
                        }
                    }
                    else{
                        if (character < "0" || character > "9"){
                            nonNegativeCheck = true
                        }
                    }
                    counter = counter + 1
                }
            }
        }
        if (nonNegativeCheck){
            throw productError.negativeValue
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var product1 = Product()
    static var previews: some View {
        ProductView(product: product1)
    }
}

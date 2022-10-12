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
    @State var textFieldtextDescription: String = ""
    @State var textFieldtextAmount: String = ""
    @State var textFieldtextUnit: String = ""
    @State var expDate: Date = Date()
    @State var packDate: Date = Date()
    @State var baseDate: Date = Date()
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
                Section(header: Text("Date of packaging:"), content: {
                    Text(product.DateOfPackaging)
                    DatePicker(selection: $packDate, label: { Text("Date picker") })
                })
                Section(header: Text("Description:"), content: {
                    TextField(product.Description, text: $textFieldtextDescription)
                        .padding(.horizontal)
                        .frame(height: 45)
                        .background(Color(#colorLiteral(red: 0.1137, green: 0.0902, blue: 0.1294, alpha: 0.1)))
                        .cornerRadius(10)
                })
                Section(header: Text("Expiration date:"), content: {
                    Text(product.ExpirationDate)
                    DatePicker(selection: $expDate, label: { Text("Date picker") })
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
                    Alert(title: Text("Invalid input"), message: Text("Values Amount and Price must be numerical and positive"), dismissButton: .default(Text("Got it!")))
                }
            }
        }
    }
    func saveButtonPressed(){
        do{
            try checkData()
            product.setProduct(price: textFieldtextPrice, country: textFieldtextCountryOfOrigin, description: textFieldtextDescription, amount: textFieldtextAmount, unit: textFieldtextUnit, ExpDate: expDate, PackageDate: packDate, baseDate: baseDate)
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

//
//  BookView.swift
//  Task
//
//  Created by Vika Granadzer on 03.10.2022.
//

import SwiftUI

struct BookView: View {
    var book: Book
    @Environment(\.presentationMode) var presentationMode
    @State var showingAlert = false
    @State var textFieldtextPrice: String = ""
    @State var textFieldtextCountryOfOrigin: String = ""
    @State var textFieldtextDescription: String = ""
    @State var textFieldtextNumber: String = ""
    @State var textFieldtextPublishingHouse: String = ""
    @State var textFieldtextAuthors: String = ""
    @State var packDate: Date = Date()
    @State var baseDate: Date = Date()
    var body: some View {
        VStack{
            Form {
                Section(header: Text("Price"), content: {
                    TextField(book.Price.description, text: $textFieldtextPrice)
                        .padding(.horizontal)
                        .frame(height: 45)
                        .background(Color(#colorLiteral(red: 0.1137, green: 0.0902, blue: 0.1294, alpha: 0.1)))
                        .cornerRadius(10)
                })
                Section(header: Text("Country of origin: "), content: {
                    TextField(book.CountryOfOrigin, text: $textFieldtextCountryOfOrigin)
                        .padding(.horizontal)
                        .frame(height: 45)
                        .background(Color(#colorLiteral(red: 0.1137, green: 0.0902, blue: 0.1294, alpha: 0.1)))
                        .cornerRadius(10)
                })
                Section(header: Text("Date of packaging:"), content: {
                    Text(book.DateOfPackaging)
                    DatePicker(selection: $packDate, label: { Text("Date picker") })
                })
                Section(header: Text("Description:"), content: {
                    TextField(book.Description, text: $textFieldtextDescription)
                        .padding(.horizontal)
                        .frame(height: 45)
                        .background(Color(#colorLiteral(red: 0.1137, green: 0.0902, blue: 0.1294, alpha: 0.1)))
                        .cornerRadius(10)
                })
                Section(header: Text("Number of pages: "), content: {
                    TextField(book.NumberOfPages.description, text: $textFieldtextNumber)
                        .padding(.horizontal)
                        .frame(height: 45)
                        .background(Color(#colorLiteral(red: 0.1137, green: 0.0902, blue: 0.1294, alpha: 0.1)))
                        .cornerRadius(10)
                })
                Section(header: Text("Publishing house:"), content: {
                    TextField(book.PublishingHouse, text: $textFieldtextPublishingHouse)
                        .padding(.horizontal)
                        .frame(height: 45)
                        .background(Color(#colorLiteral(red: 0.1137, green: 0.0902, blue: 0.1294, alpha: 0.1)))
                        .cornerRadius(10)
                })
                Section(header: Text("Authors:"), content: {
                    TextField(book.Authors, text: $textFieldtextAuthors)
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
                    Alert(title: Text("Invalid input"), message: Text("Values Price and Number of pages must be numerical and positive"), dismissButton: .default(Text("Got it!")))
                }
            }
        }
    }
    func saveButtonPressed(){
        do{
            try checkData()
            book.setBook(price: textFieldtextPrice, country: textFieldtextCountryOfOrigin, description: textFieldtextDescription, number: textFieldtextNumber, house: textFieldtextPublishingHouse, authors: textFieldtextAuthors, PackageDate: packDate, baseDate: baseDate)
            presentationMode.wrappedValue.dismiss()
        } catch bookError.negativeValue{
            showingAlert = true
        } catch is NSError{
            showingAlert = true
        }
    }
    enum bookError: Error {
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
        if (textFieldtextNumber != ""){
            let numberConv = (textFieldtextNumber as NSString).floatValue
            if (numberConv<=0){
                nonNegativeCheck = true
            }
        }
        if (nonNegativeCheck){
            throw bookError.negativeValue
        }
    }
}

struct BookView_Previews: PreviewProvider {
    static var book1 = Book()
    static var previews: some View {
        BookView(book: book1)
    }
}


//
//  ContentView.swift
//  BinaryWizard
//
//  Created by Aryan Sharma on 7/25/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var input = TextLimiter(limit: 255)
    @State var binaryNumber = "00000000"
    
    @State var bit1 = "0" // 1
    @State var bit2 = "0" // 2
    @State var bit3 = "0" // 4
    @State var bit4 = "0" // 8
    @State var bit5 = "0" // 16
    @State var bit6 = "0" // 32
    @State var bit7 = "0" // 64
    @State var bit8 = "0" // 128
    
    var body: some View {
        VStack {
            TextField("A number 0-255", text: $input.value)
                .padding()
                .keyboardType(.decimalPad)
                .font(.system(.title3, design: .monospaced))
                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(Color("TextBG")))
                .padding()
                .onChange(of: input.value, perform: { value in
                    binaryNumber = toBinary(valueS: value)
                })
            
            Text("To Binary:")
                .font(.system(.title3, design: .monospaced))
            
            Menu {
                Button(action: {
                    UIPasteboard.general.string = binaryNumber
                }) {
                    Label("Copy", systemImage: "doc.on.doc")
                }
            } label: {
                Text(binaryNumber)
                    .fontWeight(.bold)
                    .foregroundColor(Color.green)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .font(.system(.title, design: .monospaced))
                
            }
            
            
        }
        
    }
    
    func toBinary(valueS: String) -> String {
        var value = Int(valueS) ?? 0
        
        if value >= 128 {
            bit1 = "1"
            value = value - 128
        } else {
            bit1 = "0"
        }
        
        if value >= 64 {
            bit2 = "1"
            value = value - 64
        } else {
            bit2 = "0"
        }
        
        if value >= 32 {
            bit3 = "1"
            value = value - 32
        } else {
            bit3 = "0"
        }
        
        if value >= 16 {
            bit4 = "1"
            value = value - 16
        } else {
            bit4 = "0"
        }
        
        if value >= 8 {
            bit5 = "1"
            value = value - 8
        } else {
            bit5 = "0"
        }
        
        if value >= 4 {
            bit6 = "1"
            value = value - 4
        } else {
            bit6 = "0"
        }
        
        if value >= 2 {
            bit7 = "1"
            value = value - 2
        } else {
            bit7 = "0"
        }
        
        if value >= 1 {
            bit8 = "1"
            value = value - 1
        } else {
            bit8 = "0"
        }
        
        return "\(bit1)\(bit2)\(bit3)\(bit4)\(bit5)\(bit6)\(bit7)\(bit8)"
    }
    
}



class TextLimiter: ObservableObject {
    private let limit: Int
    
    init(limit: Int) {
        self.limit = limit
    }
    
    @Published var value = "" {
        didSet {
            if value.isInt {
                if Int(value)! > self.limit {
                    value = String(self.limit)
                    self.hasReachedLimit = true
                } else {
                    self.hasReachedLimit = false
                }
            } else {
                if value != "" {
                    value.removeLast()
                }
            }
        }
    }
    @Published var hasReachedLimit = false
}

extension String {
    var isInt: Bool {
        return Double(self) != nil
    }
    var isDouble: Bool {
        return Double(self) != nil
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}

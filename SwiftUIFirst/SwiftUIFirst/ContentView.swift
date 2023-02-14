//
//  ContentView.swift
//  SwiftUIFirst
//
//  Created by 김지태 on 2023/02/13.
//

import SwiftUI

struct ContentView: View {
    
    @State var isShow: Bool = false
    @State var backgrounddd: UIColor = .red
    
    @State var content: String = ""
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading) {
                Text("아이디를 입력하세요.")
                    .padding()
                TextField("ID", text: $content)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    
            }
            
            Button {
                self.isShow = true
            } label: {
                Text("아이디 확인")
            }
            
            .alert("입력된 ID", isPresented: $isShow, actions: {
                Button {
                    self.isShow = false
                } label: {
                    Text("확인")
                }
            }, message: {
                Text(self.content)
            })
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

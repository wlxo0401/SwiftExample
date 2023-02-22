//
//  ContentView.swift
//  SwiftUIFirst
//
//  Created by 김지태 on 2023/02/13.
//

import SwiftUI

struct ContentView: View {
    
    @State var SelectedColor: Color = .white
    
    var body: some View {
        
        
        
        List {
            Text("Hi")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

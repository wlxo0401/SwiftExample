//
//  MyDynamicWidgetBundle.swift
//  MyDynamicWidget
//
//  Created by 김지태 on 2023/04/19.
//

import WidgetKit
import SwiftUI

@main
struct MyDynamicWidgetBundle: WidgetBundle {
    var body: some Widget {
        MyDynamicWidget()
        MyDynamicWidgetLiveActivity()
    }
}

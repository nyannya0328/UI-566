//
//  BaseViewModel.swift
//  BaseViewModel
//
//  Created by nyannyan0328 on 2021/09/01.
//

import SwiftUI

class BaseViewModel: ObservableObject {
    
    @Published var currentTab : Tab = .Home
    
    @Published var homeTab = "Sneakers"
    
    @Published var  showDetail = false
    @Published var  currentProduct : Product?
    
 
}

enum Tab : String{
    
    case Home = "home"
    case heart = "heart"
    case Clipboard = "clipboard"
    case PerSon = "person"
    
    
}


//
//  BaseView.swift
//  BaseView
//
//  Created by nyannyan0328 on 2021/09/01.
//

import SwiftUI

struct BaseView: View {
    @StateObject var baseViewModel = BaseViewModel()
    
    init(){
        
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $baseViewModel.currentTab) {
            
           Home()
                .environmentObject(baseViewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.03))
                .tag(Tab.Home)
            
            Text("B")
                .environmentObject(baseViewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.03))
                .tag(Tab.heart)
            
            Text("C")
                .environmentObject(baseViewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.03))
                .tag(Tab.Clipboard)
            
            Text("D")
                .environmentObject(baseViewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.03))
                .tag(Tab.PerSon)
            
            
        }
        .overlay(
        
            HStack(spacing:0){
                
                TabButton(tab: .Home)
                
                TabButton(tab: .heart)
                    .offset(x: -5)
                
                Button {
                    
                } label: {
                    
                    Image("cart")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                        .foregroundColor(.white)
                        .padding(15)
                        .offset(x: -2)
                        .background( Color("DarkBlue"),in: Circle())
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 5, y: 5)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: -5, y: -5)
                       
                    
                }
                .offset(y: -35)

                
                
                TabButton(tab: .Clipboard)
                    .offset(x: +5)
                
                TabButton(tab: .PerSon)
                
                
                
            }
                .background(Color.white.clipShape(CustomShape())
                                .shadow(color: .black.opacity(0.3), radius: 5, x: -5, y: -5)
                                .ignoresSafeArea(.container, edges: .bottom)
                           
                           
                           
                           )
            ,alignment: .bottom
        )
    }
    
    @ViewBuilder
    func TabButton(tab : Tab) ->some  View{
        
        Button {
            
            withAnimation{
                
                baseViewModel.currentTab = tab
                
            }
            
        } label: {
            Image(tab.rawValue)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .frame(maxWidth: .infinity)
                .foregroundColor(baseViewModel.currentTab == tab ? Color("DarkBlue") : Color.gray.opacity(0.3))
        }

        
        
        
        
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}

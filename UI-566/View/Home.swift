//
//  Home.swift
//  Home
//
//  Created by nyannyan0328 on 2021/09/01.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var baseViewModel : BaseViewModel
    
    @Namespace var animation
    var body: some View {
      
        CustomRefleshView(lottieName: "Loading", content: {
            
            VStack{
                
                HStack{
                    
                    
                    Button {
                        
                        
                    } label: {
                        
                        Image("menu")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                    }
                    
                    Spacer()
                    
                    
                    Button {
                        
                        
                    } label: {
                        
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                    }
                    
                    
                    
                }
                .foregroundColor(.black)
                .overlay(Image("logo"))
                
                
                HStack{
                    
                    
                    Text("Our Products")
                        .font(.largeTitle.bold())
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        
                        HStack{
                            
                            Text("Sort By")
                                .font(.title2.weight(.thin))
                                .foregroundColor(.orange)
                            
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.orange)
                        }
                    }
                    
                    
                }
                .padding(.top,20)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    HStack(spacing:20){
                        
                        
                        segMentButton(title: "Sneakers", image: "p1")
                        
                        segMentButton(title: "Watch", image: "watch")
                        
                        segMentButton(title: "BackPack", image: "backpack")
                        
                        
                        
                    }
                    .padding(.vertical)
                    
                    
                    let columns = Array(repeating: GridItem(.flexible(),spacing: 10), count: 2)
                    
                    
                    
                    LazyVGrid(columns: columns,spacing: 15) {
                        
                        ForEach(products){product in
                            
                            cardView(product: product)
                                .onTapGesture {
                                    
                                    withAnimation{
                                        
                                        baseViewModel.currentProduct = product
                                        baseViewModel.showDetail = true
                                    }
                                    
                                }
                            
                            
                        }
                        
                        
                    }
                  
                  
                    
                    
                }
                
                
                
            }
            .padding()
            .padding(.bottom,100)
        }, onReflesh: {
            
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            
        })
            
            
            
       
       
        .overlay(
        
                 DetaileView(animation: animation)
                        .environmentObject(baseViewModel)
                    
          
        )
        
    }
    
    
    @ViewBuilder
    
    func cardView(product : Product)->some View{
        
        
        VStack(spacing:15){
            
            
            Button {
                
            } label: {
                
                Image(systemName: "suit.heart.fill")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(product.isliked ? .white : .gray)
                    .padding(8)
                    .background(
                    
                        Color.red.opacity(0.3),in: Circle()
                    
                    
                    )
                
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            
            
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .matchedGeometryEffect(id: product.productImage, in: animation)
                .padding()
             .rotationEffect(.init(degrees: -20))
                .background(
                
                
                    ZStack{
                        
                        Circle()
                            .fill(product.productBG)
                            .padding(-10)
                        
                        ZStack{
                            
                            
                            Circle()
                                .stroke(.white,lineWidth: 5)
                                .padding(-3)
                            
                        }
                    }
                
                )
 
            
            
            Text(product.productTitle)
                .font(.title3.bold())
            
            Text(product.productPrice)
                .font(.callout.italic())
            
            
            HStack{
                
                ForEach(1...5,id:\.self){index in
                    
                    
                    Image(systemName: "star")
                        .font(.system(size: 9.5))
                        .foregroundColor(product.productRating >= index ? .yellow : .gray.opacity(0.3))
                    
                }
                
                
                Text("(\(product.productRating).0)")
                    .font(.callout)
            }
          
            
            
            
            
            
            
            

        }
        .padding()
        .background(Color.white,in: RoundedRectangle(cornerRadius: 20))
        
        
        
        
        
        
    }
    
    @ViewBuilder
    
    func segMentButton(title : String,image : String)->some View{
        
        
        
        
        Button {
            
            withAnimation{
                
                baseViewModel.homeTab = title
            }
            
        } label: {
            
            HStack(spacing:8){
                
                Image(image)
                    .resizable()
                   // .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                
                Text(title)
                    .font(.system(size: 11.5, weight: .light))
                    .foregroundColor(.black)
                
                
            }
            .padding(.vertical,10)
            .padding(.horizontal)
            .background(
            
            
                ZStack{
                    
                    
                    if baseViewModel.homeTab == title{
                        
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.white)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                            .shadow(color: .black.opacity(0.03), radius: 5, x: 5, y: 5)
                            
                        
                        
                    }
                
                }
            )
            
        }
        
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}

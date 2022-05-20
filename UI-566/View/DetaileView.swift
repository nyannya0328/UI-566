//
//  DetaileView.swift
//  DetaileView
//
//  Created by nyannyan0328 on 2021/09/01.
//

import SwiftUI

struct DetaileView: View {
    @EnvironmentObject var baseViewModel : BaseViewModel
    var animation : Namespace.ID
    
    @State var currentSize = "US 6"
    @State var showColor : Color = .red
    var body: some View {
        if let product =  baseViewModel.currentProduct,baseViewModel.showDetail{
            
            
            VStack{
                
                HStack{
                    
                    
                    Button {
                        
                        
                        withAnimation{
                            
                            
                            baseViewModel.showDetail = false
                        }
                        
                        
                        
                        
                    } label: {
                        
                       Image(systemName: "arrow.left")
                            .font(.system(size: 35))
                            .foregroundColor(.black)
                         
                    }
                    
                    Spacer()
                    
                    
                    Button {
                        
                        
                    } label: {
                        
                        Image(systemName: "suit.heart.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Color.red,in: Circle())
                    }
                    
                    
                    
                }
                .padding(.horizontal)
                .padding(.bottom)
                .overlay(Image("logo"))
                
                
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: product.productImage, in: animation)
                    .frame(width: 250, height: 250)
                    .rotationEffect(.init(degrees: -20))
                    .background(
                    
                        ZStack{
                            
                            
                            Circle()
                                .fill(product.productBG)
                                .padding()
                            
                            
                            
                            Circle()
                                .fill(Color.white.opacity(0.3))
                                .padding(60)
                            
                            
                        }
                    
                    
                    
                    )
                    .frame(height: getScreenBounds().height / 3)
                
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    HStack{
                        
                        
                        Text(product.productTitle)
                            .font(.largeTitle.bold())
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        
                        Image(systemName: "star")
                            .font(.system(size: 9.4))
                        
                        
                        Text("(\(product.productRating).0)")
                        
                    }
                    
                    Text("We could use a lot of superlatives to describe the Nike Air Max 2021. We could tell you that we've incorporated recycled materials.")
                        .lineSpacing(9)
                    
                    
                    HStack(spacing:0){
                        
                        Text("Size :")
                            .font(.caption.weight(.black))
                            .padding(.trailing)
                        
                    
                        ForEach(["US 6","US 7","US 8","US 9","US 10"],id:\.self){size in
                            
                            
                            Button {
                                
                                self.currentSize = size
                                
                            } label: {
                                
                                
                                Text(size)
                                    .font(.callout.italic())
                                    .padding(.vertical,10)
                                    .padding(.horizontal,10)
                                    .background(
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.green.opacity(self.currentSize == size ? 0.8 : 0))
                                    
                                    
                                    )
                                
                                
                            }

                            
                            
                        }
                        
                            
                        
                        
                    }
                    .padding(.vertical)
                    
                    HStack(spacing:18){
                        
                        Text("Availbl Color :")
                            .font(.caption.weight(.black))
                            .padding(.trailing)
                        
                        
                        let colos : [Color] = [.red,.green,.orange,.purple,.gray]
                    
                        ForEach(colos,id:\.self){color in
                            
                            
                            Button {
                                
                                self.showColor = color
                                
                            } label: {
                                
                                
                                Circle()
                                    .fill(color)
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                    
                                        
                                        Circle()
                                            .stroke(.white.opacity(self.showColor == color ? 1 : 0),lineWidth: 3)
                                        
                                    
                                    )
                                
                              
                                
                            
                              
                                
                                
                            }

                            
                            
                        }
                        
                            
                        
                        
                    }
                    
                    
                    
                    Button {
                        
                    } label: {
                        
                        HStack{
                            
                            Image(systemName: "cart")
                                .font(.title2)
                                .foregroundColor(.black)
                            
                            
                            Text("Add to Cart")
                                .fontWeight(.black)
                                .foregroundColor(.black)
                            
                            
                        }
                        .padding(.vertical,10)
                        .padding(.horizontal,20)
                        .frame(maxWidth:.infinity)
                        .background(Color("DarkBlue").opacity(0.3),in: RoundedRectangle(cornerRadius: 20))
                    }
                    .padding(.bottom,20)

                    
                    
                    
                    
                    
                }
                .padding(.top)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
                .background(Color("DarkBlue").opacity(0.3)
                                .cornerRadius(10)
                                .ignoresSafeArea(.container, edges: .bottom)
                
                
                
                )
           
                
                
                
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
            .background(Color.white)
            .transition(.slide)
            
            
            
        }
        
        
        
    }
}

struct DetaileView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}

extension View{
    
    func getScreenBounds()->CGRect{
        
        return UIScreen.main.bounds
    }
}

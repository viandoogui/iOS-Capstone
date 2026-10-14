//
//  ProductDetails.swift
//  Ios Capstone Group 4
//
//  Created by user302999 on 10/1/26.
//

import SwiftUI

struct ProductDetails:View{
    @State  var product:Product
    
    
    var body: some View{
        
        
        
        VStack{
            VStack(){
                HStack(){
                    Text("Back button")
                        .padding(12)
                    Spacer()
                    Text("Home Button")
                        .padding(12)
                }
                Text("\(product.name)")
                    .font(Font.largeTitle)
                
                VStack(){
                    HStack(){
                        
                        
                        
                        
                        
                    }
                    VStack(){
                        
                        VStack(){
                            HStack(){
                                //base64 string can figure it out
                                AsyncImage(url:URL(string:"https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.shutterstock.com%2Fimage-vector%2Fblank-image-photo-placeholder-icon-600nw-2501054919.jpg&f=1&nofb=1&ipt=1fe05258ed3420df3534141caa7f073cdf7ae982a02880f78da58d71b5819396&ipo=images")){ image in
                                    image.resizable().scaledToFit()
                                }placeholder: {
                                    ProgressView()
                                }
                                .padding(8)
                                VStack(){
                                    
                                    Text("ID:")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        
                                    Text("\(product.id)")
                                         .font(.body)
                                        Divider()
                                    Text("\n Product Number:")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text("\(product.productNumber)")
                                        .font(.body)
                                   
                                    Text("\n Inventory: N/A")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    Text("\n Price: \(String(format:"%.2f", product.listPrice))")
                                }
                                .padding(12)

                            }
                            
                            Text("Summary: \(product.summary)")
                            Text("Color: \(product.color)")
                            Text("photo file name: \(product.thumbnailPhotoFileName)")
                            Text("warranty \(product.warranty ?? "none")")



                            
                            
                            
                            
                       
                            

                        }
                        .frame(maxWidth: .infinity) //ensure horizontal center
                        .background(Color.white)
                        .padding(10)

                        
                    }
                }
                .background(Color.blue)
                .cornerRadius(20)
                .padding(10)
                .frame(maxWidth: .infinity) //ensure horizontal center

            }
            .padding(.top, 20)
            .background(Color.cyan)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
            
            
        Spacer()
            
        }
        .frame(maxWidth: .infinity) //ensure horizontal center
        .padding(10)
    }
}



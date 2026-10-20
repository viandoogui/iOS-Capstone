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
//                HStack(){
//                    Text("Home Button")
//                        .padding(12)
//                }
                Text("\(product.name)")
                    .font(Font.largeTitle)
                
                VStack(){
//                    HStack(){
//                        
//                        
//                        
//                        
//                        
//                    }
                    VStack(){
                        
                        VStack(){
                            HStack(){
                                //base64 string can figure it out
                                //"https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.shutterstock.com%2Fimage-vector%2Fblank-image-photo-placeholder-icon-600nw-2501054919.jpg&f=1&nofb=1&ipt=1fe05258ed3420df3534141caa7f073cdf7ae982a02880f78da58d71b5819396&ipo=images"
                                
                                if(product.thumbnailPhotoFileName == "no_image_available_small.gif" || product.thumbnailPhotoFileName == "" || product.thumbnailPhotoFileName == "no_image_available.gif" || product.thumbnailPhotoFileName.isEmpty){
                                    EmptyView()
                                }else{
                                    if let image = extractFirstFrame(fromBase64: product.thumbnailPhoto){
                                        
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill() // Try scaledToFill or scaledToFit
                                            .frame(width: image.size.width / 0.5, height: image.size.height / 0.5)                                            .clipped() // Crops any overflow if using scaledToFill
                                            .padding(8)
                                            .accessibilityLabel(Text("Image of \(product.name)"))
                                    }
                                    else{
                                        ContentUnavailableView("Invalid image", systemImage: "photo.slash", description: Text("could not decode base64 string"))
                                    }
                                }
                                
                                VStack(){
                                    
                                    Text("ID:")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                        
                                    Text("\(product.id)")
                                         .font(.body)
                                        Divider()
                                    Text("Product Number:")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                    Text("\(product.productNumber)")
                                        .font(.body)
                                   
//                                    Text("\n Inventory: N/A")
//                                        .font(.caption)
//                                        .foregroundColor(.gray)
                                    Divider()
                                    Text("Price:")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                    Text("$\(String(format:"%.2f", product.listPrice))")
                                        .font(.body)

                                }
                                .padding(12)

                            }
                            
                            
                            
                            
                            if let summary = product.summary{
                                Divider()
                                Text("Summary:")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(8)
                                Text("\(summary)")
                                    .padding(8)
                            }
                            
                            if let color = product.color{
                                Divider()

                                Text("Color:" )
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(8)
                                Text("\(color)")
                                    .padding(8)
                                


                            }
                            
                            Divider()

                            Text("warranty:")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(8)
                            Text("\(product.warranty ?? "none")")
                                .padding(8)



                            
                            
                            
                            
                       
                            

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
            .frame(maxWidth: .infinity) //ensure horizontal center
            .padding(.top, 20)
            .background(Color.cyan)
            
            
        Spacer()
            
        }
        .frame(maxWidth: .infinity) //ensure horizontal center
        .background(Color.cyan)
        //.padding(10)
    }

}

func extractFirstFrame(fromBase64 base64String: String) -> UIImage? {
    let cleanedString: String
    if let commaRange = base64String.range(of: ",") {
        cleanedString = String(base64String[commaRange.upperBound...])
    } else {
        cleanedString = base64String
    }
    
    guard let gifData = Data(base64Encoded: cleanedString, options: .ignoreUnknownCharacters) else {
        return nil
    }
    
    guard let imageSource = CGImageSourceCreateWithData(gifData as CFData, nil) else {
        return nil
    }
    
    guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, 0, nil) else {
        return nil
    }
    
    return UIImage(cgImage: cgImage)
}

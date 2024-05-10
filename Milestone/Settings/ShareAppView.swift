//
//  ShareAppView.swift
//  Milestone
//
//  Created by Nikita Kolomoec on 09.05.2024.
//

import SwiftUI

struct ShareAppView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var clipboardMessage = "Just Copy Link"
    @State private var clipboardImage = "doc.on.doc"
    
    var body: some View {
        GeometryReader { geo in
            
            LazyVStack(alignment: .leading) {
                
                HStack {
                    Text("Share Milestone Via...")
                        .font(.title2.bold())
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.secondary)
                            .shadow(radius: 15)
                    }
                }
                .padding(.bottom)
                
                Button {
                    shareViaTwitter()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: geo.size.height / 5)
                            .foregroundStyle(.bar)
                            .translucentStroke(10)
                        
                        HStack {
                            Text("Twitter")
                                .font(.title3.bold())
                            
                            Spacer()
                            
                            Image("Twitter")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .contentShape(Rectangle())
                        }
                        .padding(.horizontal, 25)
                    }
                }
                
                Button {
                    shareViaTelegram()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: geo.size.height / 5)
                            .foregroundStyle(.bar)
                            .translucentStroke(10)
                        
                        HStack {
                            Text("Telegram")
                                .font(.title3.bold())
                            
                            Spacer()
                            
                            Image("telegramLogo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .contentShape(Rectangle())
                        }
                        .padding(.horizontal, 25)
                    }
                }
                
                Button {
                    copyToClipboard()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: geo.size.height / 5)
                            .foregroundStyle(.bar)
                            .translucentStroke(10)
                        
                        HStack {
                            Text(clipboardMessage)
                                .font(.title3.bold())
                            
                            Spacer()
                            
                            Image(systemName: clipboardImage)
                                .font(.title2)
                        }
                        .padding(.horizontal, 25)
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.top)
            .buttonStyle(.plain)
        }
    }
    
    func shareViaTwitter() {
        let tweetUrl = "https://t.co/HkSMlLWauu"
        
        let shareString = "https://twitter.com/intent/tweet?url=\(tweetUrl)"
        
        // encode a space to %20 for example
        let escapedShareString = shareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        // cast to an url
        let url = URL(string: escapedShareString)
        
        // open in safari
        UIApplication.shared.open(url!)
    }
    
    func shareViaTelegram() {
        let telegramUrl = "https://t.co/HkSMlLWauu"
        
        let shareString = "tg://msg_url?url=\(telegramUrl)"
        
        // encode a space to %20 for example
        let escapedShareString = shareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        // cast to an url
        let url = URL(string: escapedShareString)
        
        // open app, or in safari
        UIApplication.shared.open(url!)
    }
    
    func copyToClipboard() {
        let message = "https://t.co/HkSMlLWauu"
        UIPasteboard.general.setValue(message, forPasteboardType: "public.plain-text")
        
        clipboardMessage = "Copied!"
        clipboardImage = "checkmark"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                clipboardMessage = "Just Copy Link"
                clipboardImage = "doc.on.doc"
            }
        }
    }
}

struct ShareAppView_Previews: PreviewProvider {
    static var previews: some View {
        ShareAppView()
    }
}

struct TranslucentStroke: ViewModifier {
    let cornerRadius: Int
    
    func body(content: Content) -> some View {
        ZStack {
            content
            RoundedRectangle(cornerRadius: CGFloat(cornerRadius))
                .stroke(.secondary, lineWidth: 1)
        }
    }
}

extension View {
    func translucentStroke(_ cornerRadius: Int) -> some View {
        modifier(TranslucentStroke(cornerRadius: cornerRadius))
    }
}

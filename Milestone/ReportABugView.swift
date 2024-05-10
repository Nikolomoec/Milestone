//
//  ReportABugView.swift
//  Milestone
//
//  Created by Nikita Kolomoec on 09.05.2024.
//

import SwiftUI

struct ReportABugView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader { geo in
            
            LazyVStack(alignment: .leading) {
                
                HStack {
                    Text("Report a Bug Via...")
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
                    sendEmail()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: geo.size.height / 3.7)
                            .foregroundStyle(.bar)
                            .translucentStroke(10)
                        
                        HStack {
                            Text("Mail")
                                .font(.title3.bold())
                            
                            Spacer()
                            
                            Image(systemName: "mail.stack")
                                .font(.title2)
                        }
                        .padding(.horizontal, 25)
                    }
                }
                
                Button {
                    openTwitterProfile()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: geo.size.height / 3.7)
                            .foregroundStyle(.bar)
                            .translucentStroke(10)
                        
                        HStack {
                            Text("Twitter DMs")
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
            }
            .padding(.horizontal, 30)
            .padding(.top)
            .buttonStyle(.plain)
        }
    }
    
    private func sendEmail() {
        let myEmail = "nikolomoeceng@gmail.com"
        
        // Show third party email composer
        if let emailUrl = createEmailUrl(to: myEmail) {
            UIApplication.shared.open(emailUrl)
        }
    }
    
    private func createEmailUrl(to: String) -> URL? {
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)")
        let defaultUrl = URL(string: "mailto:\(to)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }
        
        return defaultUrl
    }
    
    private func openTwitterProfile() {
        let screenName = "nikolomoec"
        
        let appURL = URL(string: "twitter://user?screen_name=\(screenName)")!
        let webURL = URL(string: "https://twitter.com/\(screenName)")!
        
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            // If the user has the Twitter (X) app installed.
            application.open(appURL, options:  [:], completionHandler:  nil)
        } else {
            // If the user does not have the Twitter (X) app installed, then it goes to the website.
            application.open(webURL, options:  [:], completionHandler:  nil)
        }
    }
}

struct ReportABugView_Previews: PreviewProvider {
    static var previews: some View {
        ReportABugView()
    }
}

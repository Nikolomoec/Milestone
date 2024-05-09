//
//  SettingsView.swift
//  Milestones test learning
//
//  Created by Nikita Kolomoec on 09.05.2024.
//

import SwiftUI
import Setting

struct SettingsView: View {
    
    @State private var isMilestonePlusOn = false
    @State private var isShowingShareScreen = false
    @State private var isShowingReportABugScreen = false
    
    var body: some View {
        GeometryReader { geo in
            SettingStack {
                SettingPage(title: "Milestone", navigationTitleDisplayMode: .inline) {
                    
                    // Default Settings
                    SettingGroup {
                        SettingPage(title: "Milestones") {
                            
                        }
                        .previewIcon(icon: .system(icon: "star.fill", foregroundColor: .white, backgroundColor: .black))
                        
                        SettingPage(title: "Notifications") {
                            
                        }
                        .previewIcon(icon: .system(icon: "bell.fill", foregroundColor: .white, backgroundColor: Color(red: 0.60, green: 0.72, blue: 0.81)))
                        
                        SettingPage(title: "Stats") {
                            
                        }
                        .previewIcon(icon: .system(icon: "percent", foregroundColor: .white, backgroundColor: Color(red: 0.38, green: 0.42, blue: 0.22)))
                    }
                    
                    // Sound & Haptics
                    SettingGroup {
                        SettingPage(title: "Sound & Haptics") {
                            
                        }
                        .previewIcon(icon: .system(icon: "speaker.wave.2.fill", foregroundColor: .white, backgroundColor: Color(red: 0.62, green: 0.01, blue: 0.03)))
                    }
                    
                    SettingGroup {
                        SettingPage(title: "Quick Guide") {
                            
                        }
                        .previewIcon(icon: .system(icon: "person.fill.questionmark", foregroundColor: .white, backgroundColor: Color(red: 0.83, green: 0.64, blue: 0.45)))
                    }
                    
                    // Additional
                    SettingGroup {
                        SettingButton(title: "Rate on Appstore") {
                            
                        }
                        .icon("heart.fill", color: Color(red: 0.80, green: 0.27, blue: 0.19))
                        
                        SettingButton(title: "Share") {
                            
                        }
                        .icon("person.2.fill", color: Color(red: 0.46, green: 0.51, blue: 0.56))
                        
                        SettingButton(title: "Report a Bug") {
                            
                        }
                        .icon("exclamationmark.triangle.fill", color: Color(red: 0.51, green: 0.40, blue: 0.33))
                    }
                    
                    // Media and Terms
                    
                    SettingGroup {
                        SettingButton(title: "Follow on Twitter") { openTwitterProfile()
                        }
                        .icon("bird.fill", color: Color(red: 0.27, green: 0.38, blue: 0.38))
                        
                        SettingPage(title: "Terms and Privacy") {
                            
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $isMilestonePlusOn) {
                
            }
            .sheet(isPresented: $isShowingShareScreen) {
                ShareAppView()
                    .presentationDetents([.height(geo.size.height / 2)])
                    .presentationCornerRadius(30)
            }
            .sheet(isPresented: $isShowingReportABugScreen) {
                ReportABugView()
                    .presentationDetents([.height(geo.size.height / 2.8)])
                    .presentationCornerRadius(30)
            }
        }
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

#Preview {
    SettingsView()
}

